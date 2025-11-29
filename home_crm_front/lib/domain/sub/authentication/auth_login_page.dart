import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:home_crm_front/domain/support/components/logo/Logo.dart';

import '../../../theme/theme.dart';
import '../../support/components/animate/animated.dart';
import '../../support/phone.dart';

@RoutePage()
class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({super.key});

  @override
  _AuthLoginPage createState() => _AuthLoginPage();
}

class _AuthLoginPage extends State<AuthLoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String? _login;
  String? _password;
  bool _passwordVisible = false;

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
                                        VisibilityEffect(milliseconds: 600),
                                        MoveEffect(
                                          durationMilliseconds: 600,
                                          begin: Offset(0.0, 20.0),
                                        ),
                                        ScaleEffect(
                                          durationMilliseconds: 600,
                                          begin: 0.9,
                                        ),
                                      ],
                                    ),
                                    child: Logo(),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedWrapper(
                              animationInfo: AnimationInfo(
                                trigger: AnimationTrigger.onPageLoad,
                                effects: [
                                  VisibilityEffect(milliseconds: 600),
                                  MoveEffect(
                                    durationMilliseconds: 600,
                                    begin: Offset(0.0, 40.0),
                                  ),
                                  ScaleEffect(
                                    durationMilliseconds: 600,
                                    begin: 0.9,
                                  ),
                                ],
                              ),
                              child: Text(
                                'Добро пожаловать!',
                                style: CustomColors.getDisplaySmall(
                                  context,
                                  null,
                                ),
                              ),
                            ),
                            AnimatedWrapper(
                              animationInfo: AnimationInfo(
                                trigger: AnimationTrigger.onPageLoad,
                                effects: [
                                  VisibilityEffect(milliseconds: 600),
                                  MoveEffect(
                                    durationMilliseconds: 600,
                                    begin: Offset(0.0, 50.0),
                                  ),
                                  ScaleEffect(
                                    durationMilliseconds: 600,
                                    begin: 0.9,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                  0,
                                  4,
                                  0,
                                  0,
                                ),
                                child: Text(
                                  'Используйте форму ниже для доступа',
                                  style: CustomColors.getLabelLarge(
                                    context,
                                    null,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0,
                                16,
                                0,
                                0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        0,
                                        16,
                                        0,
                                        0,
                                      ),
                                      child: TextFormField(
                                        controller: null,
                                        focusNode: null,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Телефон',
                                          labelStyle:
                                          CustomColors.getLabelMedium(
                                            context,
                                            null,
                                          ),
                                          hintText: '+7 (___) ___-__-__',
                                          hintStyle:
                                          CustomColors.getLabelMedium(
                                            context,
                                            null,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: CustomColors.getAccent4(
                                                context,
                                              ),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              40,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: CustomColors.getPrimary(
                                                context,
                                              ),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              40,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: CustomColors.getError(
                                                context,
                                              ),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              40,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: CustomColors.getError(
                                                context,
                                              ),
                                              width: 2,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(40),
                                          ),
                                          filled: true,
                                          fillColor: CustomColors.getAccent4(
                                            context,
                                          ),
                                          contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                            16,
                                            24,
                                            0,
                                            24,
                                          ),
                                        ),
                                        style: CustomColors.getBodyMedium(
                                          context,
                                          null,
                                        ),
                                        cursorColor: CustomColors.getPrimary(
                                          context,
                                        ),
                                        inputFormatters: [Phone.phoneFormatter],
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (Phone.isValidPhoneNumber(value)) {
                                            return null;
                                          }
                                          return 'Поле телефона обязательно для заполнения!';
                                        },
                                        onChanged: (value) => _login = value,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0,
                                16,
                                0,
                                0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Пароль',
                                        labelStyle: CustomColors.getLabelMedium(
                                          context,
                                          null,
                                        ),
                                        hintText: 'Введите пароль...',
                                        hintStyle: CustomColors.getLabelMedium(
                                          context,
                                          null,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CustomColors.getAccent4(
                                              context,
                                            ),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CustomColors.getPrimary(
                                              context,
                                            ),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CustomColors.getError(
                                              context,
                                            ),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CustomColors.getError(
                                              context,
                                            ),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: CustomColors.getAccent4(
                                          context,
                                        ),
                                        contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                          16,
                                          24,
                                          24,
                                          24,
                                        ),
                                        suffixIcon: InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          onTap: () =>
                                          {
                                            setState(() {
                                              _passwordVisible =
                                              !_passwordVisible;
                                            }),
                                          },
                                          focusNode: FocusNode(
                                            skipTraversal: true,
                                          ),
                                          child: Icon(
                                            _passwordVisible
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: Color(0xFF57636C),
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                      style: CustomColors.getBodyMedium(
                                        context,
                                        null,
                                      ),
                                      cursorColor: CustomColors.getPrimary(
                                        context,
                                      ),
                                      obscureText: !_passwordVisible,
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Поле пароля обязательно для заполнения!';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) => _password = value,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0,
                                24,
                                0,
                                0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      print('fogot_password');
                                    },
                                    child: Text(
                                      'Забыли пароль?',
                                      style: CustomColors.getLabelMedium(
                                        context,
                                        null,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {},
                                    child: false
                                        ? CircularProgressIndicator()
                                        : Text(
                                      'Войти',
                                      style: CustomColors.getTitleMedium(
                                        context,
                                        null,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                        CustomColors.getPrimary(context),
                                      ),
                                      fixedSize: WidgetStateProperty.all(
                                        Size(130, 50),
                                      ),
                                      elevation: WidgetStateProperty.all(2),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0,
                                24,
                                0,
                                12,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Используйте социальную платформу для продолжения',
                                      textAlign: TextAlign.center,
                                      style: CustomColors.getLabelMedium(
                                        context,
                                        null,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: CustomColors.getAccent1(
                                            context,
                                          ),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: CustomColors.getPrimary(
                                              context,
                                            ),
                                            width: 2,
                                          ),
                                        ),
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Icon(
                                          Icons.circle_outlined,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0,
                                24,
                                0,
                                24,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('У вас нет учетной записи?',
                                    style: CustomColors.getLabelMedium(
                                        context, null),),
                                  TextButton(
                                    onPressed: () async {},
                                    style: ButtonStyle(
                                      // backgroundColor: WidgetStateProperty.all(
                                      //   CustomColors.getPrimary(context),
                                      // ),
                                      fixedSize: WidgetStateProperty.all(
                                        Size(200, 30),
                                      ),
                                      elevation: WidgetStateProperty.all(2),
                                    ),
                                    child: Text(
                                      'Зарегистрироваться',
                                      style: CustomColors.getTitleMedium(
                                        context,
                                        null,
                                      ),
                                    ),
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
