import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/theme.dart';
import '../../../support/widgets/stamp.dart';
import '../bloc/organization_bloc.dart';
import '../event/organization_event.dart';
import '../state/organization_state.dart';

class OrganizationSelect extends StatefulWidget {
  const OrganizationSelect({super.key});

  @override
  _OrganizationSelectState createState() => _OrganizationSelectState();
}

class _OrganizationSelectState extends State<OrganizationSelect> {
  @override
  void initState() {
    BlocProvider.of<OrganizationBloc>(context).add(OrganizationRefreshEvent());
    super.initState();
  }

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
          return Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: CustomColors.getAccent1(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: CustomColors.getWarning(context)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Icon(
                      color: CustomColors.getWarning(context),
                      Icons.warning,
                      size: 24,
                    ),
                  ),
                ),
              ),
              Text('Выбирете организацию, с которой будете работать'),
            ],
          );
        } else if (state is OrganizationSelectedState) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: CustomColors.getAccent1(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: CustomColors.getPrimary(context)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Icon(
                      state.selected.role.owner
                          ? Icons.workspace_premium
                          : Icons.work,
                      size: 44,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.selected.organization.name,
                        style: CustomColors.getBodyLarge(context, null),
                      ),
                      Text(
                        state.selected.role.name,
                        style: CustomColors.getLabelMedium(context, null),
                      ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      //   child: Text(
                      //     'Информация',
                      //     style: CustomColors.getBodySmall(
                      //       context,
                      //       CustomColors.getPrimary(context),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
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
}
