import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_crm_front/domain/home/home_page.dart';

final routes = {"/": (context) => HomePage(title: 'CRM Demo Home Page')};

Route<dynamic>? generateRoute(settings) {
  if (settings.name == "/house") {
    final value = settings.arguments as int;
    return MaterialPageRoute(
      builder: (pageSate) => HomePage(title: "house$value"),
      settings: settings,
    );
  }
  return null; // Let `onUnknownRoute` handle this behavior.
}