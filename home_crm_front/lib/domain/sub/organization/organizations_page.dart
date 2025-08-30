import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_edit_event.dart';
import 'package:home_crm_front/domain/sub/organization/state/organization_edit_state.dart';

import '../../support/widgets/stamp.dart';
import 'bloc/organization_edit_bloc.dart';
import 'event/organization_event.dart';

@RoutePage()
class OrganizationPage extends StatefulWidget {
  const OrganizationPage({super.key, required this.organization});

  final OrganizationDto? organization;

  @override
  _OrganizationPageState createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  final _formKey = GlobalKey<FormState>();
  String? _organizationName;
  bool load = false;

  @override
  void initState() {
    BlocProvider.of<OrganizationBloc>(context).add(OrganizationRefreshEvent());
    BlocProvider.of<OrganizationEditBloc>(
      context,
    ).add(OrganizationEditLoadEvent(organization: widget.organization));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationEditBloc, OrganizationEditState>(
      listener: (context, state) {
        if (state is OrganizationEditSuccessState) {
          context.router.back();
        }
      },
      builder: (context, state) {
        if (state is OrganizationEditCreateState) {
          return SafeArea(
            child: MaterialApp(
              home: Scaffold(
                appBar: AppBar(title: Text('Создание организации')),
                body: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Название организации',
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Необходимо ввести название';
                              }
                              return null;
                            },
                            onChanged: (value) => _organizationName = value,
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            child: Text('Создать организацию'),
                            onPressed: () {
                              BlocProvider.of<OrganizationEditBloc>(
                                context,
                              ).add(
                                OrganizationEditCreateEvent(
                                  name: _organizationName!,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (state is OrganizationEditUpdateState) {
          return SafeArea(
            child: MaterialApp(
              home: Scaffold(
                appBar: AppBar(title: Text('Обновление организации')),
                body: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Название организации',
                            ),
                            initialValue: state.organization.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Необходимо ввести название';
                              }
                              return null;
                            },
                            onChanged: (value) => _organizationName = value,
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            child: Text('Обновить организацию'),
                            onPressed: () {
                              BlocProvider.of<OrganizationEditBloc>(
                                context,
                              ).add(
                                OrganizationEditUpdateEvent(
                                  id: state.organization.id,
                                  name:
                                      _organizationName ??
                                      state.organization.name,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (state is OrganizationEditOnlyWatchState) {
          return SafeArea(
            child: MaterialApp(
              home: Scaffold(
                appBar: AppBar(title: Text('Создание организации')),
                body: Column(
                  children: [
                    Text('Название организации ${state.organization.name}'),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      child: Text('Назад'),
                      onPressed: () {
                        AutoRouter.of(context).back();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Stamp.errorWidget(context);
        }
      },
    );
  }
}
