import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/sub/authentication/state/auth_state.dart';
import 'package:home_crm_front/domain/support/router/roters.gr.dart';

import '../../../theme/theme.dart';
import '../../support/phone.dart';
import 'auth_base_page.dart';
import 'bloc/auth_bloc.dart';
import 'event/auth_event.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends AuthPageBase<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _phone;
  String? _password;

  @override
  Form getForm(AuthState state) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ВХОД', style: Theme.of(context).textTheme.headlineMedium),
          if (state is AuthLoginErrorState)
            Column(
              children: [
                SizedBox(height: 5),
                Text(state.message, style: TextStyle(color: Colors.red)),
              ],
            ),
          SizedBox(height: 5),
          _buildLoginField(),
          SizedBox(height: 5),
          _buildPasswordField(),
          SizedBox(height: 5),
          TextButton(
            onPressed: () {
              //TODO: Забыли пароль?
            },
            child: Text(
              'Забыли пароль?',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          const SizedBox(height: 10),
          // Кнопка входа
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: WidgetStateProperty.all(Size.fromWidth(420)),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<AuthBloc>(
                  context,
                ).add(AuthLoginEvent(phone: _phone!, password: _password!),
                );
              }
            },
            child: state is AuthProcessingState
                ? CircularProgressIndicator()
                : const Text('Войти'),
          ),
          const SizedBox(height: 10),

          TextButton(
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all(
                CustomColors.backgroundDark,
              ),
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return CustomColors.accentColor.withOpacity(0.1);
                }
                return CustomColors.accentColor;
              }),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              shadowColor: WidgetStateProperty.all(Colors.transparent),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              minimumSize: WidgetStateProperty.all(Size(double.maxFinite, 56)),
            ),
            onPressed: () {
              AutoRouter.of(context).push(RegistrationRoute());
            },
            child: Text('Регистрация →'),
          ),
        ],
      ),
    );
  }

  // Вспомогательные методы для построения полей ввода
  Widget _buildLoginField() {
    return TextFormField(
      inputFormatters: [Phone.phoneFormatter],
      decoration: const InputDecoration(
        hintText: '+7 (___) ___-__-__',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        filled: true,
        fillColor: Colors.white60,
      ),
      keyboardType: TextInputType.phone,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (Phone.isValidPhoneNumber(value)) {
          return null;
        }
        return 'Поле телефона обязательно для заполнения!';
      },
      onChanged: (value) => _phone = value,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Пароль',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        filled: true,
        fillColor: Colors.white60,
      ),
      style: const TextStyle(color: Colors.black),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Поле пароля обязательно для заполнения!';
        }
        return null;
      },
      onChanged: (value) => _password = value,
    );
  }
}
