import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_event.dart';
import 'package:home_crm_front/domain/sub/organization/state/organization_state.dart';

import '../../support/widgets/stamp.dart';
import 'bloc/organization_bloc.dart';

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
  OrganizationBloc _organizationBloc = OrganizationBloc();

  @override
  void initState() {
    _organizationBloc.add(
        OrganizationLoadEvent(organization: widget.organization));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizationBloc, OrganizationState>(
      bloc: _organizationBloc,
      builder: (context, state) {
        if (state is OrganizationCreateState) {
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
                              _organizationBloc.add(OrganizationCreateEvent(
                                  name: _organizationName!));
                              context.router.back();
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
        }
        if (state is OrganizationUpdateState) {
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
                              if (value == null || value
                                  .trim()
                                  .isEmpty) {
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
                              _organizationBloc.add(OrganizationUpdateEvent(
                                  id: state.organization.id,
                                  name: _organizationName ??
                                      state.organization.name));
                              context.router.back();
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
        } else if (state is OrganizationAuthState) {
          return Stamp.authErrorWidget(context);
        } else {
          return Stamp.errorWidget(context);
        }
      },
    );
  }
}
