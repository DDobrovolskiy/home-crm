import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/employee/store/employee_store.dart';
import 'package:home_crm_front/domain/sub/role/store/role_store.dart';
import 'package:home_crm_front/domain/support/components/load/custom_load.dart';

import '../../../../theme/theme.dart';
import '../../../support/components/skeleton/custom_skeleton.dart';

class EmployeeSelect extends StatefulWidget {
  final Pair? selected;
  final ValueChanged<Pair?>? onChanged;
  final FormFieldSetter<Pair>? onSaved;
  final Set<int>? excludeId;
  final String? text;
  final ButtonStyleData? buttonStyleData;
  final bool saveSelected;

  const EmployeeSelect({
    super.key,
    this.selected,
    this.onChanged,
    this.onSaved,
    this.excludeId,
    this.text,
    this.buttonStyleData,
    this.saveSelected = true,
  });

  @override
  _EmployeeSelectState createState() => _EmployeeSelectState();
}

class _EmployeeSelectState extends State<EmployeeSelect> {
  Pair? selected;

  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO
    return CustomLoadList.load(
      key: Key('null'),
      loader: GetIt.I.get<EmployeeStore>().getAllMap(),
      skeleton: CustomSkeleton(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              CustomSkeleton.panel(
                width: 100,
                height: 16,
              ),
              CustomSkeleton.panel(
                width: 80,
                height: 12,
              ),
            ],
          ),
        ),
        builder: (
      BuildContext context,
      employees,
    ) {
          //TODOurn CustomLoadList.load(
          key: Key('null'),
          loader: GetIt.I.get<RoleStore>().getAllMap(),
          skeskeleton: CustomSkeleton(
                child: CustomSkeleton.panel(
                  width: 80,
                  height: 12,
                ),
              ),
              builder: (
        BuildContext context,
        roles,
      ) {
        // https://pub.dev/documentation/dropdown_button2/latest/
        return DropdownButtonHideUnderline(
          child: DropdownButton2<Pair>(
            isExpanded: true,
            hint: Text(
              widget.text ?? 'Выбор сотрудника',
              style: CustomColors.getBodyLarge(context, null),
            ),
            items: employees.entries
                .where((e) =>
            !(widget.excludeId?.contains(e.key) ?? false) &&
                roles[e.value.roleId] != null)
                .map((empl) {
                  var pair = Pair(
                    id: empl.key,
                    name: empl.value.user.name,
                    role: roles[empl.value.roleId]!.name,
                  );
                  return DropdownMenuItem<Pair>(
                    value: pair,
                    child: CustomLoad.load(
                        key: empl.value.getKey(),
                        loader: empl.value.getRole(),
                        skeleton: CustomSkeleton(
                          child: CustomSkeleton.panel(
                            width: 80,
                            height: 12,
                          ),
                        ),
                        builder: (
                      BuildContext context,
                      role,
                    ) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pair.name,
                            style: CustomColors.getBodyLarge(context, null),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                            child: Text(
                              pair.role,
                              style: CustomColors.getLabelMedium(context, null),
                            ),
                          ),
                        ],
                      );
                    }),
                  );
                })
                .toList(),
            value: selected,
            onChanged: (value) {
              if (widget.saveSelected) {
                setState(() {
                  selected = value;
                });
              }
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            iconStyleData: IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: CustomColors.getSecondaryText(context),
              ),
              iconSize: 24,
            ),
            buttonStyleData: widget.buttonStyleData,
            dropdownSearchData: DropdownSearchData(
              searchController: textEditingController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Поиск сотрудника...',
                    hintStyle: CustomColors.getLabelMedium(context, null),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                bool searchName =
                    item.value?.name.toUpperCase().contains(
                      searchValue.toUpperCase(),
                    ) ??
                    false;
                bool searchRole =
                    item.value?.role.toUpperCase().contains(
                      searchValue.toUpperCase(),
                    ) ??
                    false;
                return searchName || searchRole;
              },
            ),

            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: CustomColors.getPrimaryBackground(context),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),

            //This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingController.clear();
              }
            },
          ),
        );
      });
    });
  }
}

class Pair {
  late int id;
  late String name;
  late String role;

  Pair({required this.id, required this.name, required this.role});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pair && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
