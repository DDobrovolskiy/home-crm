import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';
import '../../../support/components/button/hovered_region.dart';
import 'organization_dialog.dart';

class OrganizationAdd extends StatefulWidget {
  const OrganizationAdd({super.key});

  @override
  _OrganizationAddState createState() => _OrganizationAddState();
}

class _OrganizationAddState extends State<OrganizationAdd> {
  @override
  Widget build(BuildContext context) {
    return HoveredRegion(
      onTap: () async {
        OrganizationDialog(organization: null).addOrganization(context);
      },
      child: (isHovered) {
        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 12, 12),
          child: Container(
            width: 220,
            decoration: BoxDecoration(
              color: CustomColors.getSecondaryBackground(context),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isHovered
                    ? CustomColors.getAlternate(context)
                    : CustomColors.getSecondaryText(context),
                width: 1.5,
              ),
            ),
            child: Center(
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: AlignmentDirectional(0, 0),
                child: Icon(
                  Icons.add_circle,
                  color: isHovered
                      ? CustomColors.getAlternate(context)
                      : CustomColors.getSecondaryText(context),
                  size: 36,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
