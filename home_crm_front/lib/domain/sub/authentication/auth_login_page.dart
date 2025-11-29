import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:home_crm_front/domain/support/components/logo/Logo.dart';

import '../../../theme/theme.dart';
import '../../support/components/animate/animated.dart';

@RoutePage()
class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({super.key});

  @override
  _AuthLoginPage createState() => _AuthLoginPage();
}

class _AuthLoginPage extends State<AuthLoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: CustomColors.getSecondaryBackground(context),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                CustomColors.getAccent1(context),
                CustomColors.getPrimary(context),
              ],
              stops: [0.3, 1],
              begin: AlignmentDirectional(1, -1),
              end: AlignmentDirectional(-1, 1),
            ),
          ),
          alignment: AlignmentDirectional(0, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(maxWidth: 530),
                    decoration: BoxDecoration(),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0,
                                0,
                                0,
                                30,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AnimatedWrapper(
                                    animationInfo: AnimationInfo(
                                      trigger: AnimationTrigger.onPageLoad,
                                      effects: [
                                        VisibilityEffect(milliseconds: 1800),
                                        MoveEffect(
                                          curve: Curves.easeInOut,
                                          delayMilliseconds: 1800,
                                          durationMilliseconds: 1800,
                                          begin: Offset(0.0, 60.0),
                                          end: Offset.zero,
                                        ),
                                      ],
                                    ),
                                    child: Logo(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
