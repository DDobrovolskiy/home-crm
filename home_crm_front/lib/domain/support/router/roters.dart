import 'package:flutter/cupertino.dart';
import 'package:home_crm_front/domain/sub/login/login_registration_page.dart';

import '../../sub/home/home_page.dart';
import '../../sub/login/login_page.dart';

class RoutersApp {
  static const String home = '/home';
  static const String login = '/login';
  static const String registration = '/register';
  static const String splash = '/splash';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => HomePage(),
    login: (context) => LoginPage(),
    registration: (context) => LoginRegistrationPage(),
  };
}
