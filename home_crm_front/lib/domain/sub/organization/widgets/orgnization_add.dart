import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/support/components/screen/Screen.dart';

import '../../../../theme/theme.dart';
import '../../../support/components/button/button.dart';
import '../../../support/components/button/hovered_region.dart';
import '../bloc/organization_bloc.dart';
import '../bloc/organization_edit_bloc.dart';
import '../event/organization_edit_event.dart';
import '../event/organization_event.dart';

class OrganizationAdd extends StatefulWidget {
  const OrganizationAdd({super.key});

  @override
  _OrganizationAddState createState() => _OrganizationAddState();
}

class _OrganizationAddState extends State<OrganizationAdd> {
  @override
  Widget build(BuildContext context) {
    return HoveredRegion(
      onTap: () async {
        BlocProvider.of<OrganizationBloc>(
          context,
        ).add(OrganizationUnSelectedEvent());
        editUserName(context);
      },
      child: (isHovered) {
        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 12, 12),
          child: Container(
            width: 220,
            decoration: BoxDecoration(
              color: CustomColors.getSecondaryBackground(context),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isHovered
                    ? CustomColors.getAlternate(context)
                    : CustomColors.getSecondaryText(context),
                width: 1.5,
              ),
            ),
            child: Center(
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: AlignmentDirectional(0, 0),
                child: Icon(
                  Icons.add_circle,
                  color: isHovered
                      ? CustomColors.getAlternate(context)
                      : CustomColors.getSecondaryText(context),
                  size: 36,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void editUserName(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    String? organizationName = null;
    await showAdaptiveDialog(
      context: context,
      barrierDismissible: false, // Окно не закрывается при нажатии вне области
      builder: (context) {
        return Dialog(
          backgroundColor: CustomColors.getPrimaryBackground(context),
          insetPadding: EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              width: Screen.getMaxWidth(),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                      child: Text(
                        'Создать организацию',
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            height: 50,
                            width: 150,
                            onPressed: () => Navigator.pop(context),
                          ),
                          SizedBox(width: 10),
                          CustomButton(
                            text: 'Создать организацию',
                            height: 50,
                            width: 220,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<OrganizationEditBloc>(
                                  context,
                                ).add(
                                  OrganizationEditCreateEvent(
                                    name: organizationName!,
                                  ),
                                );
                                Navigator.pop(context); // Возвратим новое имя
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
