import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class NavProfile extends StatefulWidget {
  @override
  _NavProfileState createState() => _NavProfileState();
}

class _NavProfileState extends State<NavProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Divider(
          height: 12,
          thickness: 2,
          color: CustomColors.getAlternate(context),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: CustomColors.getAccent1(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: CustomColors.getPrimary(context)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Icon(Icons.face, size: 44),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Andrew D.',
                        style: CustomColors.getBodyLarge(context, null),
                      ),
                      Text(
                        'admin@gmail.com',
                        style: CustomColors.getLabelMedium(context, null),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'View Profile',
                          style: CustomColors.getBodySmall(
                            context,
                            CustomColors.getPrimary(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
