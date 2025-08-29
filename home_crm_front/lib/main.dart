import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:home_crm_front/home_crm_app.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(HomeCrmApp());
}
