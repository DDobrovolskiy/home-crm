import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_crm_front/domain/core/login/login_form.dart';
import 'package:home_crm_front/domain/core/login/login_main_page.dart';
import 'package:home_crm_front/domain/core/login/registration_form.dart';

import '../domain/core/home/home_page.dart';

final routes = {
  "/": (context) =>
      Routers.checkAuth(context, const HomePage(title: 'CRM Demo Home Page')),
  Routers.login: (context) =>
      LoginMainPage(form: LoginForm().buildForm(context)),
  Routers.registration: (context) =>
      LoginMainPage(form: RegistrationForm().buildForm(context)),
};

// Route<dynamic>? generateRoute(settings) {
//   if (settings.name == "/house") {
//     final value = settings.arguments as int;
//     return MaterialPageRoute(
//       builder: (pageSate) => HomePage(title: "house$value"),
//       settings: settings,
//     );
//   }
//   return null; // Let `onUnknownRoute` handle this behavior.
// }

class Routers {
  static String login = "/login";
  static String registration = "/registration";

  static Widget checkAuth(BuildContext context, Widget widget) {
    // TokenService().checkAuthAndRedirect(context);
    print("object");
    // return await TokenService().checkAuthAndRedirect(context)
    //   .then((value) {
    //   return widget;
    // });
    return widget;
  }
}
