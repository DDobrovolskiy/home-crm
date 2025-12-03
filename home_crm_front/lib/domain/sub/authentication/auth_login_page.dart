import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/sub/authentication/state/auth_state.dart';

import '../../../theme/theme.dart';
import '../../support/components/animate/animated.dart';
import '../../support/router/roters.gr.dart';
import '../../support/widgets/stamp.dart';
import 'auth_base_page.dart';
import 'bloc/auth_bloc.dart';
import 'event/auth_event.dart';

@RoutePage()
class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({super.key});

  @override
  _AuthLoginPage createState() => _AuthLoginPage();
}

class _AuthLoginPage extends AuthPageBase<AuthLoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _login;
  String? _password;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(AuthCheckEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginState) {
          if (state.organizationId != null) {
            AutoRouter.of(context).push(HomeRoute());
          } else {
            AutoRouter.of(context).push(UserProfileRoute());
          }
        }
      },
      builder: (context, state) {
        if (state.check) {
          return Stamp.loadWidget(context);
        } else {
          return getContent(context, state);
        }
      },
    );
  }

  Widget getContent(BuildContext context, AuthState state) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                            createLogo(),
                            createWelcome(),
                            createWelcomeDesc(state),
                            createPhoneField((value) => _login = value),
                            createPasswordField((value) => _password = value),
                            createButtonLogin(state),
                            createSocDesc(),
                            createSocIcon(),
                            createRegistry(),
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

  Widget createWelcome() {
    return AnimatedWrapper(
      animationInfo: AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effects: [
          VisibilityEffect(milliseconds: 600),
          MoveEffect(durationMilliseconds: 600, begin: Offset(0.0, 40.0)),
          ScaleEffect(durationMilliseconds: 600, begin: 0.9),
        ],
      ),
      child: Text(
        'Добро пожаловать!',
        style: CustomColors.getDisplaySmall(context, null),
      ),
    );
  }

  Widget createButtonLogin(AuthState state) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () async {
              Stamp.showTemporarySnackbar(context, 'Функционал не реализован');
            },
            child: Text(
              'Забыли пароль?',
              style: CustomColors.getLabelMedium(context, null),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<AuthBloc>(
                  context,
                ).add(AuthLoginEvent(phone: _login!, password: _password!));
              }
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                CustomColors.getPrimary(context),
              ),
              fixedSize: WidgetStateProperty.all(Size(130, 50)),
              elevation: WidgetStateProperty.all(2),
            ),
            child: state.loaded
                ? CircularProgressIndicator()
                : Text(
                    'Войти',
                    style: CustomColors.getTitleMedium(context, null),
                  ),
          ),
        ],
      ),
    );
  }

  Widget createRegistry() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'У вас нет учетной записи?',
            style: CustomColors.getLabelMedium(context, null),
          ),
          TextButton(
            onPressed: () async {
              AutoRouter.of(context).push(AuthCreateRoute());
            },
            style: ButtonStyle(
              fixedSize: WidgetStateProperty.all(Size(200, 30)),
              elevation: WidgetStateProperty.all(2),
            ),
            child: Text(
              'Зарегистрироваться',
              style: CustomColors.getTitleMedium(context, null),
            ),
          ),
        ],
      ),
    );
  }
}
