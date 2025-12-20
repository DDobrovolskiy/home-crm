import 'package:flutter/material.dart';
import 'package:home_crm_front/theme/theme.dart';

enum StatusDoc {
  DRAFT(
    description: 'ЧЕРНОВИК',
    ready: false,
    color: Colors.grey,
    colorText: Colors.black54,
  ),
  READY(
    description: 'ГОТОВ',
    ready: true,
    color: Colors.green,
    colorText: Colors.white,
  ),
  WAIT(
    description: 'НЕ НАЧАТО',
    ready: false,
    color: Color(0xFFD79913),
    colorText: Colors.black54,
  ),
  BEGIN(
    description: 'НАЧАТО',
    ready: false,
    color: Color(0xFF135FD7),
    colorText: Colors.white,
  ),
  FAILED(
    description: 'НЕ ПРОЙДЕН',
    ready: false,
    color: Color(0xFFCB3535),
    colorText: Colors.black54,
  ),
  DONE(
    description: 'ВЫПОЛНЕН',
    ready: true,
    color: Color(0xFF048178),
    colorText: Colors.white,
  );

  final String description;
  final bool ready;
  final Color color;
  final Color colorText;

  const StatusDoc({
    required this.description,
    required this.ready,
    required this.color,
    required this.colorText,
  });

  String toJson() {
    return this.name;
  }

  factory StatusDoc.fromJson(String json) => StatusDoc.values.firstWhere(
    (s) => s.name == json,
    orElse: () => StatusDoc.DRAFT,
  );
}

class CustomStatusDoc extends StatelessWidget {
  final StatusDoc status;

  const CustomStatusDoc({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: status.color,
      child: Padding(
        padding: EdgeInsetsGeometry.all(2),
        child: Text(
          status.description,
          style: CustomColors.getLabelSmall(context, status.colorText),
        ),
      ),
    );
  }
}
