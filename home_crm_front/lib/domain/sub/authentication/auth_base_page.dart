import 'package:flutter/material.dart';
import 'package:home_crm_front/domain/sub/authentication/state/auth_state.dart';

import '../../../theme/theme.dart';
import '../../support/components/animate/animated.dart';
import '../../support/components/logo/Logo.dart';
import '../../support/phone.dart';

abstract class AuthPageBase<T extends StatefulWidget> extends State<T> {
  bool passwordVisible = false;

  Widget createLogo() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedWrapper(
            animationInfo: AnimationInfo(
              trigger: AnimationTrigger.onPageLoad,
              effects: [
                VisibilityEffect(milliseconds: 600),
                MoveEffect(durationMilliseconds: 600, begin: Offset(0.0, 20.0)),
                ScaleEffect(durationMilliseconds: 600, begin: 0.9),
              ],
            ),
            child: Logo(),
          ),
        ],
      ),
    );
  }

  Widget createWelcomeDesc(AuthState state) {
    return AnimatedWrapper(
      animationInfo: AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effects: [
          VisibilityEffect(milliseconds: 600),
          MoveEffect(durationMilliseconds: 600, begin: Offset(0.0, 50.0)),
          ScaleEffect(durationMilliseconds: 600, begin: 0.9),
        ],
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
        child: state.error != null
            ? Text(
                state.error!.message,
                style: CustomColors.getLabelLarge(
                  context,
                  CustomColors.getError(context),
                ),
              )
            : Text(
                'Используйте форму ниже для доступа',
                style: CustomColors.getLabelLarge(context, null),
              ),
      ),
    );
  }

  Widget createPhoneField(Function(String) onChanged) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              child: TextFormField(
                controller: null,
                focusNode: null,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Телефон',
                  labelStyle: CustomColors.getLabelMedium(context, null),
                  hintText: '+7 (___) ___-__-__',
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
                  contentPadding: EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                ),
                style: CustomColors.getBodyMedium(context, null),
                cursorColor: CustomColors.getPrimary(context),
                inputFormatters: [Phone.phoneFormatter],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (Phone.isValidPhoneNumber(value)) {
                    return null;
                  }
                  return 'Поле телефона обязательно для заполнения!';
                },
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createPasswordField(Function(String) onChanged) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Пароль',
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
                  return 'Поле пароля обязательно для заполнения!';
                }
                return null;
              },
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget createSocDesc() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              'Используйте социальную платформу для продолжения',
              textAlign: TextAlign.center,
              style: CustomColors.getLabelMedium(context, null),
            ),
          ),
        ],
      ),
    );
  }

  Widget createSocIcon() {
    return Padding(
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
                  color: CustomColors.getAccent1(context),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: CustomColors.getPrimary(context),
                    width: 2,
                  ),
                ),
                alignment: AlignmentDirectional(0, 0),
                child: Icon(Icons.circle_outlined, size: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}