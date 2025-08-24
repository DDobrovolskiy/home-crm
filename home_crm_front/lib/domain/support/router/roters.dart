import 'package:flutter/cupertino.dart';
import 'package:home_crm_front/domain/sub/organization/organizations_page.dart';
import 'package:home_crm_front/domain/sub/user/user_page.dart';

import '../../sub/authentication/login_page.dart';
import '../../sub/authentication/registration_page.dart';
import '../../sub/home/home_page.dart';

class RoutersApp {
  static const String registration = '/register';
  static const String login = '/login';
  static const String user = '/user';
  static const String organization = '/organization';
  static const String home = '/home';

  static final Map<String, WidgetBuilder> routes = {
    registration: (context) => RegistrationPage(),
    login: (context) => LoginPage(),
    user: (context) => UserPage(),
    organization: (context) => OrganizationPage(),
    home: (context) => HomePage(),
  };
}
