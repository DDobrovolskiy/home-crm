import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_create_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_update_dto.dart';
import 'package:home_crm_front/domain/sub/organization/service/organization_service.dart';

import '../../../../theme/theme.dart';
import '../../../support/components/button/button.dart';
import '../dto/response/organization_dto.dart';

class OrganizationDialog extends StatefulWidget {
  final OrganizationDto? organization;

  const OrganizationDialog({super.key, this.organization});

  @override
  _OrganizationDialogState createState() => _OrganizationDialogState();
}

class _OrganizationDialogState extends State<OrganizationDialog> {
  final _formKey = GlobalKey<FormState>();
  String? organizationName;

  @override
  void initState() {
    organizationName = widget.organization?.name;
    super.initState();
  }

  bool isCreate() {
    return widget.organization == null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
          child: Text(
            isCreate() ? 'Создать организацию' : 'Обновить организацию',
            style: CustomColors.getDisplaySmall(context, null),
          ),
        ),
        Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              TextFormField(
                decoration: CustomColors.getTextFormInputDecoration(
                  'Название организации',
                  context,
                ),
                style: CustomColors.getBodyMedium(context, null),
                maxLines: null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: organizationName,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Необходимо ввести название';
                  }
                  return null;
                },
                onChanged: (value) => organizationName = value,
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
                      GetIt.I.get<OrganizationService>().addOrganization(
                          OrganizationCreateDto(
                            name: organizationName ?? widget.organization!.name,
                          ));
                    } else {
                      GetIt.I.get<OrganizationService>().updateOrganization(
                          OrganizationUpdateDto(
                            id: widget.organization!.id,
                            name: organizationName ?? widget.organization!.name,
                          ));
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
