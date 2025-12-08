import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/role/dto/request/role_create_dto.dart';
import 'package:home_crm_front/domain/sub/role/dto/request/role_update_dto.dart';
import 'package:home_crm_front/domain/support/service/loaded.dart';

import '../../../../theme/theme.dart';
import '../../../support/components/button/button.dart';
import '../../../support/widgets/stamp.dart';
import '../../scope/bloc/scope_bloc.dart';
import '../../scope/dto/response/scope_dto.dart';
import '../../scope/service/scope_service.dart';
import '../../scope/state/scope_state.dart';
import '../dto/response/role_full_dto.dart';
import '../service/role_service.dart';

class RoleDialog extends StatefulWidget {
  final RoleFullDto? role;

  const RoleDialog({super.key, this.role});

  @override
  _RoleDialogState createState() => _RoleDialogState();
}

class _RoleDialogState extends State<RoleDialog> {
  final _formKey = GlobalKey<FormState>();
  int? _id;
  String? _name;
  String? _description;
  List<ScopeDTO> _selectedItems = [];

  @override
  void initState() {
    GetIt.instance.get<ScopeService>().refreshScopes(Loaded.ifNotLoad);
    _id = widget.role?.role.id;
    _name = widget.role?.role.name;
    _description = widget.role?.role.description;
    _selectedItems = widget.role?.roleScopes.scopes ?? [];
    super.initState();
  }

  bool isCreate() {
    return widget.role == null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScopeBloc, ScopeState>(
      listener: (context, state) {
        if (state is ScopeErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        if (!state.loaded()) {
          return Stamp.loadWidget(context);
        } else if (state.getBody() != null) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                child: Text(
                  isCreate() ? 'Добавить должность' : 'Обновить должность',
                  style: CustomColors.getDisplaySmall(context, null),
                ),
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
                      child: TextFormField(
                        decoration: CustomColors.getTextFormInputDecoration(
                          'Название должности',
                          context,
                        ),
                        style: CustomColors.getBodyMedium(context, null),
                        maxLines: null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: _name,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Необходимо ввести название должности';
                          }
                          return null;
                        },
                        onChanged: (value) => _name = value,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
                      child: TextFormField(
                        decoration: CustomColors.getTextFormInputDecoration(
                          'Описание должности',
                          context,
                        ),
                        style: CustomColors.getBodyMedium(context, null),
                        maxLines: null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: _description,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Необходимо ввести описание должности';
                          }
                          return null;
                        },
                        onChanged: (value) => _description = value,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(6, 6, 6, 6),
                      child: Text(
                        'Разрешения:',
                        style: CustomColors.getLabelMedium(context, null),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(6, 6, 6, 6),
                      child: fieldMultySelected(state.getBody()!),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      text: 'Отменить',
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10),
                    CustomButton(
                      text: isCreate() ? 'Создать' : 'Обновить',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (isCreate()) {
                            var resul = await GetIt.I
                                .get<RoleService>()
                                .addRole(
                                  RoleCreateDto(
                                    name: _name!,
                                    description: _description!,
                                    scopes: _selectedItems
                                        .map((i) => i.id)
                                        .toList(),
                                  ),
                                );
                            Navigator.pop(context, resul);
                          } else {
                            var resul = await GetIt.I
                                .get<RoleService>()
                                .updateRole(
                                  RoleUpdateDto(
                                    id: _id!,
                                    name: _name!,
                                    description: _description!,
                                    scopes: _selectedItems
                                        .map((i) => i.id)
                                        .toList(),
                                  ),
                                );
                            Navigator.pop(context, resul);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Stamp.errorWidget(context);
        }
      },
    );
  }

  Widget fieldMultySelected(List<ScopeDTO> allScope) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: allScope.length,
      itemBuilder: (_, index) {
        final currentScope = allScope[index];
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(currentScope.description),
          value: _selectedItems.contains(currentScope),
          activeColor: CustomColors.getPrimary(context),
          checkColor: Colors.white,
          onChanged: (bool? checked) {
            if (checked!) {
              _selectedItems.add(currentScope);
            } else {
              _selectedItems.remove(currentScope);
            }
            setState(() {});
          },
        );
      },
    );
  }
}
