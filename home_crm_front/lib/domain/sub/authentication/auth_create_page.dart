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
class AuthCreatePage extends StatefulWidget {
  const AuthCreatePage({super.key});

  @override
  _AuthCreatePage createState() => _AuthCreatePage();
}

class _AuthCreatePage extends AuthPageBase<AuthCreatePage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _login;
  String? _password;
  bool _isHidden = true; // Переменная для управления отображением пароля

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
                            createGetStarted(),
                            createWelcomeDesc(state),
                            createPhoneField((value) => _login = value),
                            createNameField(),
                            createPasswordField((value) => _password = value),
                            createPasswordMatchingField(),
                            createButtonAuth(state),
                            createSocDesc(),
                            createSocIcon(),
                            createLogin(),
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

  Widget createGetStarted() {
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
        'Зарегистрироваться',
        style: CustomColors.getDisplaySmall(context, null),
      ),
    );
  }

  Widget createNameField() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Ваше имя',
                labelStyle: CustomColors.getLabelMedium(context, null),
                hintText: 'Введите ваше имя...',
                hintStyle: CustomColors.getLabelMedium(context, null),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.getAccent4(context),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.getPrimary(context),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.getError(context),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.getError(context),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                filled: true,
                fillColor: CustomColors.getAccent4(context),
                contentPadding: EdgeInsetsDirectional.fromSTEB(16, 24, 24, 24),
              ),
              style: CustomColors.getBodyMedium(context, null),
              cursorColor: CustomColors.getPrimary(context),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Поле имя обязательно для заполнения!';
                }
                return null;
              },
              onChanged: (value) => _name = value,
            ),
          ),
        ],
      ),
    );
  }

  Widget createPasswordMatchingField() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Повторите пароль',
                labelStyle: CustomColors.getLabelMedium(context, null),
                hintText: 'Введите пароль...',
                hintStyle: CustomColors.getLabelMedium(context, null),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.getAccent4(context),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.getPrimary(context),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.getError(context),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.getError(context),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                filled: true,
                fillColor: CustomColors.getAccent4(context),
                contentPadding: EdgeInsetsDirectional.fromSTEB(16, 24, 24, 24),
                suffixIcon: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () => {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    }),
                  },
                  focusNode: FocusNode(skipTraversal: true),
                  child: Icon(
                    passwordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Color(0xFF57636C),
                    size: 22,
                  ),
                ),
              ),
              style: CustomColors.getBodyMedium(context, null),
              cursorColor: CustomColors.getPrimary(context),
              obscureText: !passwordVisible,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Пароли не совпали!';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget createButtonAuth(AuthState state) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<AuthBloc>(context).add(
                  AuthRegistrationEvent(
                    name: _name!,
                    phone: _login!,
                    password: _password!,
                  ),
                );
              }
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                CustomColors.getPrimary(context),
              ),
              fixedSize: WidgetStateProperty.all(Size(220, 50)),
              elevation: WidgetStateProperty.all(2),
            ),
            child: state.loaded
                ? CircularProgressIndicator()
                : Text(
                    'Зарегистрироваться',
                    style: CustomColors.getTitleMedium(context, null),
                  ),
          ),
        ],
      ),
    );
  }

  Widget createLogin() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'У вас уже есть аккаунт?',
            style: CustomColors.getLabelMedium(context, null),
          ),
          TextButton(
            onPressed: () async {
              AutoRouter.of(context).push(AuthLoginRoute());
            },
            style: ButtonStyle(
              fixedSize: WidgetStateProperty.all(Size(150, 30)),
              elevation: WidgetStateProperty.all(2),
            ),
            child: Text(
              'Войти',
              style: CustomColors.getTitleMedium(context, null),
            ),
          ),
        ],
      ),
    );
  }
}
