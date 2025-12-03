import 'package:flutter/cupertino.dart';

import '../../../../theme/theme.dart';

class Tariff extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 3, 0, 3),
      child: ClipPath(
        clipper: SimCardClipper(),
        child: Container(
          width: 200,
          height: 120,
          decoration: BoxDecoration(
            color: CustomColors.getAccent1(context),
            // borderRadius: BorderRadius.all(), // Углы квадратные
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Тариф:',
                      style: CustomColors.getLabelMedium(
                        context,
                        CustomColors.getPrimaryBtnText(context),
                      ),
                    ),
                    Text(
                      'ТЕСТОВЫЙ',
                      style: CustomColors.getLabelLarge(
                        context,
                        CustomColors.getPrimaryBtnText(context),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'без ограничений',
                      style: CustomColors.getLabelSmall(
                        context,
                        CustomColors.getPrimaryBtnText(context),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 3, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Оплата:',
                        style: CustomColors.getLabelMedium(
                          context,
                          CustomColors.getPrimaryBtnText(context),
                        ),
                      ),
                      Text(
                        '0 ₽/мес.',
                        style: CustomColors.getLabelLarge(
                          context,
                          CustomColors.getPrimaryBtnText(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SimCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 10;

    Path path = Path()
      ..moveTo(radius, 0)
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(Offset(size.width, radius), radius: Radius.circular(radius))
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(
        Offset(size.width - radius, size.height),
        radius: Radius.circular(radius),
      )
      ..lineTo(radius * 4, size.height)
      ..arcToPoint(Offset(0, size.height - radius * 4))
      ..lineTo(0, radius)
      ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
