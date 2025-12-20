import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/support/components/logo/Logo.dart';
import 'package:home_crm_front/domain/support/components/navbar/NavProfile.dart';
import 'package:home_crm_front/domain/support/components/navbar/NavSubElement.dart';
import 'package:home_crm_front/domain/support/components/screen/Screen.dart';
import 'package:home_crm_front/domain/support/components/search/Search.dart';

import '../../../../theme/theme.dart';
import '../../../sub/education/tests_page.dart';
import '../../../sub/organization/organization_employees_page.dart';
import '../../../sub/organization/organization_role_page.dart';
import '../../../sub/organization/service/organization_service.dart';
import '../../../sub/organization/widgets/organization_select.dart';
import '../../../sub/scope/scope.dart';
import '../callback/NavBarCallBack.dart';
import '../divided/divider.dart';
import 'NavElementList.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var organizationCurrentService = GetIt.instance.get<OrganizationService>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 1, 0),
      child: Container(
        width: Screen.getNavBarWidth(),
        height: double.infinity,
        constraints: BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: CustomColors.getSecondaryBackground(context),
          boxShadow: [
            BoxShadow(
              color: CustomColors.getAlternate(context),
              offset: Offset(1, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //LOGO
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: Logo(),
                      ),
                      //SEARCH
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                        child: Search(),
                      ),
                      //ELEMENTS
                      NavElementList()
                          .add(
                            Item(
                              label: 'Отчеты',
                              icon: Icons.dashboard_rounded,
                              onTap: () {
                              },
                              subElements: [
                                NavSubElement(
                                  label: 'Личный',
                                  onTap: () {
                                    // GetIt.I.get<SheetElementAddCallback>().call(
                                    //   'Личный',
                                    //   () => CounterWrap().build(context),
                                    // );
                                  },
                                ),
                                NavSubElement(
                                  label: 'Тестирование',
                                  onTap: () {
                                    // GetIt.I.get<SheetElementAddCallback>().call(
                                    //   'Тестирование',
                                    //   () => Text('TEST'),
                                    // );
                                  },
                                ),
                              ],
                            ),
                          )
                          .add(
                            Item(
                              label: 'Организация',
                              icon: Icons.business_rounded,
                              onTap: () {
                                print('Организация');
                              },
                              subElements: [
                                NavSubElement(
                                  label: OrganizationRolesPage.name,
                                  onTap: () {
                                    GetIt.I.get<SheetElementAddCallback>().call(
                                      const OrganizationRolesPage(),
                                    );
                                  },
                                ),
                                NavSubElement(
                                  label: OrganizationEmployeesPage.name,
                                  onTap: () {
                                    GetIt.I.get<SheetElementAddCallback>().call(
                                      const OrganizationEmployeesPage(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                          .add(
                            Item(
                              label: 'Обучение',
                              icon: Icons.book,
                              onTap: () {},
                              subElements: [
                                if (organizationCurrentService.isEditor(
                                  ScopeType.TEST_CREATE,
                                ))
                                  NavSubElement(
                                    label: OrganizationTestsPage.name,
                                    onTap: () {
                                      GetIt.I
                                          .get<SheetElementAddCallback>()
                                          .call(const OrganizationTestsPage());
                                    },
                                  ),
                              ],
                            ),
                          ),
                      //MY PROFILE
                    ],
                  ),
                ),
              ),
            ),
            if (Screen.isHeight(context, 220))
              Padding(
                padding: EdgeInsets.all(16),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      getHorizontalDivider(context),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: OrganizationSelect(),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: NavProfile(),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
