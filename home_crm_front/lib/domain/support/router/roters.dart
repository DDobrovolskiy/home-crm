import 'package:flutter/cupertino.dart';

import '../../sub/authentication/login_page.dart';
import '../../sub/authentication/registration_page.dart';
import '../../sub/home/home_page.dart';

class RoutersApp {
  static const String home = '/home';
  static const String login = '/login';
  static const String registration = '/register';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => HomePage(),
    login: (context) => LoginPage(),
    registration: (context) => RegistrationPage(),
  };
}
