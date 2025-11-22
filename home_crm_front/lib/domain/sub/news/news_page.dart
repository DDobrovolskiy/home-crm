import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../support/router/roters.gr.dart';
import '../../support/widgets/stamp.dart';
import '../organization/bloc/organization_bloc.dart';
import '../organization/event/organization_event.dart';
import '../organization/state/organization_state.dart';
import '../user/bloc/user_bloc.dart';
import '../user/event/user_event.dart';

@RoutePage()
class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<StatefulWidget> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,);
  }
}
