import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/theme.dart';
import '../../../support/components/button/hovered_region.dart';
import '../../../support/widgets/stamp.dart';
import '../../employee/dto/response/employee_dto.dart';
import '../bloc/organization_bloc.dart';
import '../event/organization_event.dart';
import '../state/organization_state.dart';
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
      crossAxisCount: 3, // Количество элементов в строке
      childAspectRatio: 1.0, // Соотношение сторон (квадраты)
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
                empOrg.organization.name,
                empOrg.role.name,
                empOrg.role.owner,
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

  Widget organizationCard(
    String name,
    String role,
    bool owner,
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: CustomColors.getAccent1(context),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: AlignmentDirectional(0, 0),
                    child: Icon(
                      owner ? Icons.workspace_premium : Icons.work,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  name,
                  style: CustomColors.getTitleMedium(context, null),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                  child: Text(
                    role,
                    style: CustomColors.getTitleSmall(context, null),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
