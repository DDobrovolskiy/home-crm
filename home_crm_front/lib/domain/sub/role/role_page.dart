import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/role/state/role_edit_state.dart';

import '../../support/widgets/stamp.dart';
import '../scope/dto/response/scope_dto.dart';
import 'bloc/role_edit_bloc.dart';
import 'event/role_edit_event.dart';

@RoutePage()
class RolePage extends StatefulWidget {
  const RolePage({super.key, @PathParam("roleId") required this.roleId});

  final int? roleId;

  @override
  _RolePageState createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _description;
  Set<ScopeDTO> selectedItems = {};

  final _roleEditBloc = GetIt.instance.get<RoleEditBloc>();

  @override
  void initState() {
    _roleEditBloc.add(RoleEditLoadEvent(id: widget.roleId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoleEditBloc, RoleEditState>(
      listener: (context, state) {
        if (state.roleScope != null) {
          selectedItems.clear();
          for (ScopeDTO scope in state.roleScope?.scopes ?? {}) {
            if (state.scopes.contains(scope)) {
              selectedItems.add(scope);
            }
          }
        }
        if (state.isEndEdit) {
          context.router.back();
        } else if (state.error != null) {
          context.router.back();
        }
      },
      builder: (context, state) {
        if (state.error != null) {
          return SafeArea(
            child: Scaffold(appBar: AppBar(title: Text(state.error!.message))),
          );
        } else {
          return getContent(context, state);
        }
      },
    );
  }

  getContent(BuildContext context, RoleEditState state) {
    if (state.isLoading) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Stamp.loadWidget(context)),
          body: Stamp.loadWidget(context),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: state.data == null
                ? Text('Добавление роли')
                : Text('Редактирование роли'),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Название роли'),
                      initialValue: state.data?.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Необходимо ввести название роли';
                        }
                        return null;
                      },
                      onChanged: (value) => _name = value,
                    ),
                    SizedBox(height: 5),
                    fieldEdit('Описание роли', state.data?.description, (
                      value,
                    ) {
                      _description = value;
                    }),
                    SizedBox(height: 5),
                    fieldMultySelected(
                      state.scopes,
                      state.roleScope?.scopes ?? [],
                    ),
                    const SizedBox(height: 32),
                    if (!state.isOnlyWatch)
                      ElevatedButton(
                        child: state.data == null
                            ? Text('Добавить роль')
                            : Text('Обновить роль'),
                        onPressed: () {
                          if (state.data == null) {
                            BlocProvider.of<RoleEditBloc>(context).add(
                              RoleEditCreateEvent(
                                name: _name!,
                                description: _description!,
                                scopes: selectedItems.map((s) => s.id).toList(),
                              ),
                            );
                          } else {
                            BlocProvider.of<RoleEditBloc>(context).add(
                              RoleEditUpdateEvent(
                                id: widget.roleId!,
                                name: _name ?? state.data!.name,
                                description:
                                    _description ?? state.data!.description,
                                scopes: selectedItems.map((s) => s.id).toList(),
                              ),
                            );
                          }
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget fieldEdit(
    String nameVal,
    String? val,
    ValueChanged<String>? onChanged,
  ) {
    return TextFormField(
      decoration: InputDecoration(labelText: nameVal),
      initialValue: val,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Поле не должно быть пустым';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }

  Widget fieldMultySelected(
    List<ScopeDTO> allScopes,
    List<ScopeDTO> preSelectedScopes,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: allScopes.length,
      itemBuilder: (_, index) {
        final currentScope = allScopes[index];
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(currentScope.description),
          value: selectedItems.contains(currentScope),
          activeColor: Colors.green,
          checkColor: Colors.white,
          onChanged: (bool? checked) {
            if (checked!) {
              selectedItems.add(currentScope);
            } else {
              selectedItems.remove(currentScope);
            }
            setState(() {});
          },
        );
      },
    );
  }
}
