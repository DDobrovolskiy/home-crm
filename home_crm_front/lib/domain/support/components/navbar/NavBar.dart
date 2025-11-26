import 'package:flutter/material.dart';
import 'package:home_crm_front/domain/support/components/logo/Logo.dart';
import 'package:home_crm_front/domain/support/components/navbar/NavProfile.dart';
import 'package:home_crm_front/domain/support/components/navbar/NavSubElement.dart';
import 'package:home_crm_front/domain/support/components/screen/Screen.dart';
import 'package:home_crm_front/domain/support/components/search/Search.dart';

import '../../../../theme/theme.dart';
import 'NavElementList.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 1, 0),
      child: Container(
        width: 270,
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
                              label: 'Dashboard',
                              icon: Icons.dashboard_rounded,
                              onTap: () {
                                print('Dashboard');
                              },
                              subElements: [
                                NavSubElement(label: 'Point', onTap: () {}),
                              ],
                            ),
                          )
                          .add(
                            Item(
                              label: 'Customers',
                              icon: Icons.business_rounded,
                              onTap: () {
                                print('Customers');
                              },
                              subElements: [
                                NavSubElement(label: 'My team', onTap: () {}),
                                NavSubElement(label: 'Employee', onTap: () {}),
                              ],
                            ),
                          ),
                      //MY PROFILE
                    ],
                  ),
                ),
              ),
            ),
            if (Screen.isHeight(context, 200))
              Padding(
                padding: EdgeInsets.all(16),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                  child: NavProfile(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
