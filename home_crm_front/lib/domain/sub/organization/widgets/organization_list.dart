import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/support/components/screen/Screen.dart';

import '../../../../theme/theme.dart';
import '../../../support/components/button/hovered_region.dart';
import '../../../support/widgets/stamp.dart';
import '../../employee/dto/response/employee_dto.dart';
import '../../role/dto/response/role_dto.dart';
import '../bloc/organization_bloc.dart';
import '../bloc/organization_edit_bloc.dart';
import '../dto/response/organization_dto.dart';
import '../event/organization_edit_event.dart';
import '../event/organization_event.dart';
import '../state/organization_state.dart';
import 'organization_dialog.dart';
import 'orgnization_add.dart';

class OrganizationList extends StatefulWidget {
  final List<EmployeeDto> employees;

  const OrganizationList({super.key, required this.employees});

  @override
  _OrganizationListState createState() => _OrganizationListState();
}

class _OrganizationListState extends State<OrganizationList> {
  int select = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationBloc, OrganizationState>(
      listener: (context, state) {
        if (state is OrganizationErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        if (state is OrganizationUnSelectedState) {
          select = 0;
          return getContent();
        } else if (state is OrganizationSelectedState) {
          select = state.selected.organization.id;
          return getContent();
        } else {
          return Stamp.errorWidget(context);
        }
      },
    );
  }

  Widget getContent() {
    return GridView.count(
      crossAxisCount: (Screen.getWidthWithMaxWidth(context) / 200).round(),
      // Количество элементов в строке
      childAspectRatio: 1.0,
      // Соотношение сторон (квадраты)
      primary: true,
      shrinkWrap: true,
      children: [
        for (final empOrg in widget.employees)
          HoveredRegion(
            onTap: () async {
              BlocProvider.of<OrganizationBloc>(
                context,
              ).add(OrganizationSelectedEvent(id: empOrg.organization.id));
            },
            child: (isHovered) {
              return organizationCard(
                empOrg.organization,
                empOrg.role,
                empOrg.organization.id == select,
                isHovered,
              );
            },
          ),
        OrganizationAdd(),
      ],
    );
  }

  Color getColor(bool selected, bool hovered) {
    if (selected) {
      if (hovered) {
        return CustomColors.getPrimary(context).withAlpha(130);
      } else {
        return CustomColors.getPrimary(context);
      }
    } else if (hovered) {
      return CustomColors.getAlternate(context).withAlpha(130);
    } else {
      return CustomColors.getAlternate(context);
    }
  }

  Widget organizationCard(OrganizationDto organization,
      RoleDto role,
    bool selected,
    bool hovered,
  ) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 12, 12),
      child: Container(
        decoration: BoxDecoration(
          color: getColor(selected, hovered),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x34090F13),
              offset: Offset(0.0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: CustomColors.getAlternate(context),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: CustomColors.getSecondaryText(context),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Icon(
                          role.owner ? Icons.workspace_premium : Icons.work,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      if (role.owner)
                        PopupMenuButton<String>(
                          color: CustomColors.getSecondaryBackground(context),
                          icon: Icon(Icons.more_horiz), // Три точки
                          onSelected: (String choice) {
                            if (choice == 'Edit') {
                              OrganizationDialog(
                                organization: organization,
                              ).addOrganization(context);
                            } else if (choice == 'Delete') {
                              BlocProvider.of<OrganizationEditBloc>(
                                context,
                              ).add(
                                OrganizationEditDeleteEvent(
                                  id: organization.id,
                                ),
                              );
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'Edit',
                                child: Text(
                                  'Редактировать',
                                  style: CustomColors.getBodyMedium(
                                    context,
                                    null,
                                  ),
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'Delete',
                                child: Text(
                                  'Удалить',
                                  style: CustomColors.getBodyMedium(
                                    context,
                                    null,
                                  ),
                                ),
                              ),
                            ];
                          },
                        ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    organization.name,
                    style: CustomColors.getBodyLarge(context, null),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                    child: Text(
                      role.name,
                      style: CustomColors.getBodySmall(context, null),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
