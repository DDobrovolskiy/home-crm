import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../support/components/content/ContentList.dart';
import '../../support/components/navbar/NavBar.dart';
import '../../support/components/screen/Screen.dart';
import '../../support/widgets/stamp.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // BlocProvider.of<UserBloc>(context).add(UserLoadEvent());
    // BlocProvider.of<OrganizationBloc>(context).add(OrganizationRefreshEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        drawer: !Screen.isWeb(context) ? NavBar() : null,
        backgroundColor: CustomColors.getPrimaryBackground(context),
        appBar: !Screen.isWeb(context) ? getAppBar(context) : null,
        body: getContentBody(context),
      ),
    );
  }

  PreferredSizeWidget getAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.getPrimary(context),
      automaticallyImplyLeading: false,
      title: Text(
        'Dashboard',
        style: CustomColors.getDisplaySmall(
          context,
          CustomColors.getPrimaryBtnText(context),
        ),
      ),
      leading: !Screen.isWeb(context) ? Stamp.buttonMenuMain(context) : null,
    );
  }

  Widget getContentBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Screen.isWeb(context)) NavBar(),
              Expanded(child: ContentList()),
              // Flexible(
              //   child: SingleChildScrollView(
              //     primary: true,
              //     child: Column(
              //     children: [
              //       GetIt.I.get<SheetBar>(),
              //       const ContentList(),
              //     ],
              //     ),
              //         // flex: 10,
              //         // GetIt.I.get<SheetBar>(),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
