import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/theme.dart';
import '../../../support/components/button/button.dart';
import '../../../support/components/dialog/custom_dialog.dart';
import '../bloc/organization_edit_bloc.dart';
import '../dto/response/organization_dto.dart';
import '../event/organization_edit_event.dart';

class OrganizationDialog {
  final _formKey = GlobalKey<FormState>();
  final OrganizationDto? organization;
  String? organizationName;

  OrganizationDialog({required this.organization}) {
    organizationName = organization?.name;
  }

  bool isCreate() {
    return organization == null;
  }

  void addOrganization(BuildContext context) async {
    CustomDialog.showDialog(_body(context), context);
  }

  Widget _body(BuildContext context) {
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
                      BlocProvider.of<OrganizationEditBloc>(context).add(
                        OrganizationEditCreateEvent(name: organizationName!),
                      );
                    } else {
                      BlocProvider.of<OrganizationEditBloc>(context).add(
                        OrganizationEditUpdateEvent(
                          id: organization!.id,
                          name: organizationName ?? organization!.name,
                        ),
                      );
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
