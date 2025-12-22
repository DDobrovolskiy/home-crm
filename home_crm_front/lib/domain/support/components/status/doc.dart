import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:home_crm_front/theme/theme.dart';
import 'package:json_annotation/json_annotation.dart';

import '../button/button.dart';

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
  ARCHIVE(
    description: 'АРХИВ',
    ready: false,
    color: Color(0xFF6C52DC),
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
  ),
  ACTIVE(
    description: 'АКТИВНО',
    ready: false,
    color: Color(0xFF1368D7),
    colorText: Colors.white,
  ),
  NOT_ACTIVE(
    description: 'НЕ АКТИВНО',
    ready: false,
    color: Colors.grey,
    colorText: Colors.black54,
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

class StatusDocConverter implements JsonConverter<StatusDoc, String> {
  const StatusDocConverter();

  @override
  StatusDoc fromJson(String json) {
    return StatusDoc.values.firstWhere(
      (s) => s.name == json,
      orElse: () => StatusDoc.DRAFT,
    );
  }

  @override
  String toJson(StatusDoc object) => object.name;
}

Future<bool?> showStausAlertDialog(
  StatusDoc init,
  StatusDoc end,
  BuildContext context,
) async {
  return await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    // Пользователь обязан нажать кнопку, чтобы закрыть окно
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Подтвердите действие',
          style: CustomColors.getTitleMedium(context, null),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text(
                  'Текущий статус документа:',
                  style: CustomColors.getBodyMedium(context, null),
                ),
              ),
              Center(child: CustomStatusDoc(status: init)),
              Center(
                child: Text(
                  'Для изменения документа необходим статус:',
                  style: CustomColors.getBodyMedium(context, null),
                ),
              ),
              Center(child: CustomStatusDoc(status: end)),
            ],
          ),
        ),
        actions: <Widget>[
          CustomButton(
            text: 'Отмена',
            onPressed: () => Navigator.of(context).pop(false),
          ),
          CustomButton(
            primary: true,
            text: 'Изменить',
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      );
    },
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

class CustomStatusDocChange<T> extends StatelessWidget {
  final StatusDoc init;
  final Map<StatusDoc, String? Function(T)> map;
  final ValueChanged<MapEntry<StatusDoc, String? Function(T)>?> onChanged;

  const CustomStatusDocChange({
    super.key,
    required this.init,
    required this.map,
    required this.onChanged,
  });

  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: CustomStatusDoc(status: init),
        items: map.entries
            .map(
              (entry) =>
                  DropdownMenuItem<MapEntry<StatusDoc, String? Function(T)>>(
                    value: entry,
                    child: CustomStatusDoc(status: entry.key),
                  ),
            )
            .toList(),
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          // This is necessary for the ink response to match our customButton radius.
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
        ),
        dropdownStyleData: DropdownStyleData(
          width: 120,
          padding: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: CustomColors.getPrimaryBackground(context),
          ),
          offset: const Offset(40, -4),
        ),
        menuItemStyleData: MenuItemStyleData(
          customHeights: [...List<double>.filled(map.length, 24)],
          padding: const EdgeInsets.only(left: 16, right: 16),
        ),
      ),
    );
  }
}