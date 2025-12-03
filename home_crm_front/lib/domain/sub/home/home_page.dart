import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../support/widgets/stamp.dart';
import '../organization/bloc/organization_bloc.dart';
import '../organization/event/organization_event.dart';
import '../organization/state/organization_state.dart';
import '../user/bloc/user_bloc.dart';
import '../user/event/user_event.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(UserLoadEvent());
    BlocProvider.of<OrganizationBloc>(context).add(OrganizationRefreshEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 800) {
      return Scaffold(
        body: Row(
          children: [
            Stamp.menuMain(context), // Открытое меню
            Expanded(
              child: Scaffold(
                endDrawer: Stamp.menuSupplier(context),
                appBar: AppBar(
                  title: BlocBuilder<OrganizationBloc, OrganizationState>(
                    builder: (context, state) {
                      if (state is OrganizationSelectedState) {
                        return Text(
                          state.selected.organization.name,
                          // style: Theme.of(context).textTheme.titleLarge,
                        );
                      }
                      return Stamp.loadWidget(context);
                    },
                  ),
                  actions: [Stamp.buttonMenuSupplier(context)],
                ),
                body: Text('AutoRouter()'),
              ),
            ), // Основная область
          ],
        ),
      );
    } else {
      return Scaffold(
        drawer: Stamp.menuMain(context),
        endDrawer: Stamp.menuSupplier(context),
        appBar: AppBar(
          title: BlocBuilder<OrganizationBloc, OrganizationState>(
            builder: (context, state) {
              if (state is OrganizationSelectedState) {
                return Text(state.selected.organization.name);
              }
              return Stamp.loadWidget(context);
            },
          ),
          actions: [Stamp.buttonMenuSupplier(context)],
          leading: Stamp.buttonMenuMain(context),
        ),
        body: Text('AutoRouter()'),
      );
    }
  }
}

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: []));
  }
}
