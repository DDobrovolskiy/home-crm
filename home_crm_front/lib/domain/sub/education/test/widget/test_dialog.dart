import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/support/components/label/label_page.dart';
import 'package:home_crm_front/domain/support/components/sheetbar/sheet_bar_page.dart';

import '../../../../../theme/theme.dart';
import '../../../../support/components/callback/NavBarCallBack.dart';
import '../../../../support/components/dialog/custom_dialog.dart';
import '../../../../support/phone.dart';
import '../dto/response/test_dto.dart';

class TestDialog extends SheetPage {
  static Future<TestDto?> show(BuildContext context, TestDto? test) async {
    return CustomDialog.showDialog<TestDto?>(TestDialog(test: test), context);
  }

  @override
  String getName() {
    return test == null ? 'Новый тест' : 'Тест Т-${test?.id.toString()}';
  }

  final TestDto? test;

  const TestDialog({super.key, this.test});

  @override
  _TestDialogState createState() => _TestDialogState();
}

class _TestDialogState extends State<TestDialog>
    with AutomaticKeepAliveClientMixin<TestDialog> {
  final _formKey = GlobalKey<FormState>();
  int? _id;
  String? _name;
  String? _phone;
  String? _password;

  bool isCreate() {
    return widget.test == null;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        LabelPage(
          text: widget.getName(),
          onButton: () async {
            if (_formKey.currentState!.validate()) {
              if (isCreate()) {
                // var resul = await GetIt.I
                //     .get<EmployeeService>()
                //     .addEmployee(
                //   EmployeeCreateDto(
                //     name: _name!,
                //     phone: _phone!,
                //     password: _password!,
                //     roleId: _selectedRole!,
                //   ),
                // );
              } else {
                // var resul = await GetIt.I
                //     .get<EmployeeService>()
                //     .updateEmployee(
                //   EmployeeUpdateDto(
                //     id: _id!,
                //     roleId: _selectedRole!,
                //   ),
                // );
              }
              GetIt.I.get<SheetElementDeleteCallback>().call(widget.getName());
            }
          },
          buttonText: 'Сохранить и закрыть',
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsetsGeometry.fromLTRB(12, 12, 12, 12),
            child: CustomTab(
              contents: [
                CustomTabView(name: 'Основное', child: main()),
                CustomTabView(
                  name: 'Тест3',
                  child: Container(
                    color: Colors.green,
                    height: 150,
                    width: 150,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget main() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          if (isCreate())
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
              child: TextFormField(
                decoration: CustomColors.getTextFormInputDecoration(
                  'Имя сотрудника',
                  null,
                  context,
                ),
                style: CustomColors.getBodyMedium(context, null),
                maxLines: null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _name,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Необходимо ввести имя сотрудника';
                  }
                  return null;
                },
                onChanged: (value) => _name = value,
              ),
            ),
          if (isCreate())
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
              child: TextFormField(
                inputFormatters: [Phone.phoneFormatter],
                decoration: CustomColors.getTextFormInputDecoration(
                  'Телефон',
                  '+7 (___) ___-__-__',
                  context,
                ),
                style: CustomColors.getBodyMedium(context, null),
                maxLines: null,
                keyboardType: TextInputType.phone,
                initialValue: _phone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (Phone.isValidPhoneNumber(value)) {
                    return null;
                  }
                  return 'Необходимо ввести номер телефона сотрудника';
                },
                onChanged: (value) => _phone = value,
              ),
            ),
          if (isCreate())
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
              child: TextFormField(
                decoration: CustomColors.getTextFormInputDecoration(
                  'Транспортный пароль',
                  null,
                  context,
                ),
                style: CustomColors.getBodyMedium(context, null),
                maxLines: null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _password,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Необходимо ввести транспортный пароль';
                  }
                  return null;
                },
                onChanged: (value) => _password = value,
              ),
            ),
        ],
      ),
    );
  }
}

class CustomTab extends StatefulWidget {
  final List<CustomTabView> contents;

  const CustomTab({super.key, required this.contents});

  @override
  _CustomTabState createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Инициализируем контроллер с начальной длиной списка
    _tabController = TabController(length: widget.contents.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. Наш динамический TabBar
        Container(
          decoration: BoxDecoration(
            color: CustomColors.getSecondaryBackground(context),
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: TabBar(
            tabAlignment: TabAlignment.startOffset,
            controller: _tabController,
            isScrollable: true,
            labelColor: CustomColors.getPrimaryText(context),
            unselectedLabelColor: CustomColors.getSecondaryText(context),
            labelStyle: CustomColors.getTitleMedium(context, null),
            indicatorColor: CustomColors.getPrimary(context),
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: CustomColors.getAlternate(context),
            dividerHeight: 2,
            splashBorderRadius: BorderRadius.circular(12),
            overlayColor: WidgetStateProperty.all(
              CustomColors.getPrimaryBackground(context),
            ),
            tabs: widget.contents
                .map((title) => Tab(text: title.name))
                .toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.contents.map((page) {
              // Создаем контент для каждой вкладки динамически
              return Container(
                color: CustomColors.getSecondaryBackground(context),
                child: SingleChildScrollView(primary: true, child: page),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class CustomTabView extends StatelessWidget {
  final String name;
  final Widget child;

  const CustomTabView({super.key, required this.name, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
