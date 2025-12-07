import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_edit_event.dart';
import 'package:home_crm_front/domain/sub/organization/state/organization_edit_state.dart';

import '../../support/widgets/stamp.dart';
import 'bloc/organization_bloc.dart';
import 'bloc/organization_edit_bloc.dart';
import 'event/organization_event.dart';

@RoutePage()
class OrganizationPage extends StatefulWidget {
  const OrganizationPage({super.key});

  @override
  _OrganizationPageState createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  final _formKey = GlobalKey<FormState>();
  String? _organizationName;
  bool load = false;

  @override
  void initState() {
    BlocProvider.of<OrganizationEditBloc>(
      context,
    ).add(OrganizationEditLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationEditBloc, OrganizationEditState>(
      listener: (context, state) {
        if (state.success) {
          BlocProvider.of<OrganizationCurrentBloc>(
            context,
          ).add(OrganizationSelectedEvent(id: state.organization!.id));
          context.router.back();
        } else if (state.error != null) {
          Stamp.showTemporarySnackbar(context, state.error!.message);
        }
      },
      builder: (context, state) {
        return getContent(context, state);
      },
    );
  }

  Widget getContent(BuildContext context, OrganizationEditState state) {
    if (state.loaded) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Stamp.loadWidget(context)),
          body: Stamp.loadWidget(context),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: state.organization == null
                ? Text('Создание организации')
                : Text('Обновление организации'),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    state.isCan
                        ? TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Название организации',
                            ),
                            initialValue: state.organization?.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Необходимо ввести название';
                              }
                              return null;
                            },
                            onChanged: (value) => _organizationName = value,
                          )
                        : Text(
                            'Название организации: ${state.organization?.name}',
                          ),
                    const SizedBox(height: 32),
                    if (state.isCan)
                      ElevatedButton(
                        child: state.organization == null
                            ? Text('Создать организацию')
                            : Text('Обновить организацию'),
                        onPressed: () {
                          if (state.organization == null) {
                            BlocProvider.of<OrganizationEditBloc>(context).add(
                              OrganizationEditCreateEvent(
                                name: _organizationName!,
                              ),
                            );
                          } else {
                            BlocProvider.of<OrganizationEditBloc>(context).add(
                              OrganizationEditUpdateEvent(
                                id: state.organization!.id,
                                name:
                                    _organizationName ??
                                    state.organization!.name,
                              ),
                            );
                          }
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
