import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/theme.dart';
import '../../../sub/user/bloc/user_bloc.dart';
import '../../../sub/user/event/user_event.dart';
import '../../../sub/user/user_state/user_state.dart';
import '../../router/roters.gr.dart';
import '../../widgets/stamp.dart';
import '../button/button_link.dart';

class NavProfile extends StatefulWidget {
  @override
  _NavProfileState createState() => _NavProfileState();
}

class _NavProfileState extends State<NavProfile> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(UserLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        if (state is UserInitState) {
          return Stamp.loadWidget(context);
        } else if (state is UserLoadedState) {
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
                    child: Icon(Icons.face, size: 44),
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
                        state.user!.name,
                        style: CustomColors.getBodyLarge(context, null),
                      ),
                      Text(
                        'ID: ${state.user!.id}',
                        style: CustomColors.getLabelMedium(context, null),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: CustomButtonLink(
                          text: 'Профиль',
                          textStyle: CustomColors.getBodySmall(context, null),
                          onPressed: () {
                            AutoRouter.of(context).push(UserProfileRoute());
                          },
                        ),
                      ),
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
