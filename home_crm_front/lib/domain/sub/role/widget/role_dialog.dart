import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/role/dto/request/role_create_dto.dart';

import '../../../../theme/theme.dart';
import '../../../support/components/button/button.dart';
import '../../scope/dto/response/scope_dto.dart';
import '../dto/response/role_full_dto.dart';
import '../service/role_service.dart';

class RoleDialog extends StatefulWidget {
  final RoleFullDto? role;
  final List<ScopeDTO> allScope;

  const RoleDialog({super.key, this.role, required this.allScope});

  @override
  _RoleDialogState createState() => _RoleDialogState();
}

class _RoleDialogState extends State<RoleDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _description;
  List<ScopeDTO> _selectedItems = [];

  @override
  void initState() {
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
                child: fieldMultySelected(),
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
                      var resul = await GetIt.I.get<RoleService>().addRole(
                        RoleCreateDto(
                          name: _name!,
                          description: _description!,
                          scopes: _selectedItems.map((i) => i.id).toList(),
                        ),
                      );
                      Navigator.pop(context, resul);
                    } else {
                      // BlocProvider.of<OrganizationEditBloc>(context).add(
                      //   OrganizationEditUpdateEvent(
                      //     id: organization!.id,
                      //     name: organizationName ?? organization!.name,
                      //   ),
                      // );
                      Navigator.pop(context);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget fieldMultySelected() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.allScope.length,
      itemBuilder: (_, index) {
        final currentScope = widget.allScope[index];
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
