import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../theme/theme.dart';
import '../dialog/custom_dialog.dart';

class CustomCalendar {
  static void showSingleDate(
    BuildContext context,
    DateTime? initialSelectedDate,
    Function(Object?)? onSubmit,
    VoidCallback? onCancel,
  ) {
    CustomDialog.showDialog(
      SizedBox.fromSize(
        size: Size(300, 400),
        child: SfDateRangePicker(
          headerHeight: 40,
          viewSpacing: 0,
          toggleDaySelection: true,
          enablePastDates: false,
          showNavigationArrow: true,
          showActionButtons: true,
          cancelText: 'Отмена',
          confirmText: 'Установить',
          monthViewSettings: DateRangePickerMonthViewSettings(
              firstDayOfWeek: 1, dayFormat: 'EEE'),
          headerStyle: DateRangePickerHeaderStyle(
            backgroundColor: CustomColors.getPrimaryBackground(context),
            textStyle: CustomColors.getBodyLarge(context, null),
          ),
          todayHighlightColor: CustomColors.getSecondaryText(context),
          monthCellStyle: DateRangePickerMonthCellStyle(
            textStyle: CustomColors.getBodyLarge(context, null),
            todayTextStyle: CustomColors.getBodyLarge(context, null),
            todayCellDecoration: BoxDecoration(
              // color: Colors.red,
              border: Border.all(
                color: CustomColors.getPrimary(context),
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
          ),
          selectionTextStyle: CustomColors.getBodyLarge(context, null),
          backgroundColor: CustomColors.getSecondaryBackground(context),
          selectionMode: DateRangePickerSelectionMode.single,
          rangeSelectionColor: CustomColors.getPrimary(context),
          selectionColor: CustomColors.getPrimary(context),
          startRangeSelectionColor: CustomColors.getPrimary(context),
          initialSelectedDate: initialSelectedDate,
          onSubmit: onSubmit,
          onCancel: onCancel,
        ),
      ),
      context,
    );
  }
}
