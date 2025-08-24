import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../support/redux/state/app_state.dart';
import 'actions/organization_actions.dart';

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
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      builder: (context, store) {
        var orgUpdate = store.state.userState?.organizationInitUpdate;
        return SafeArea(
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(title: Text(orgUpdate == null
                  ? 'Создание организации'
                  : 'Обновление организации')),
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
                          initialValue: orgUpdate?.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          child: load
                              ? CircularProgressIndicator(color: Colors.white)
                              : orgUpdate == null
                              ? Text('Создать организацию')
                              : Text('Обновить организацию'),
                          onPressed: () {
                            load = true;
                            orgUpdate == null ?
                            store.dispatch(
                              OrganizationCreateAction(
                                name: _organizationName!,
                              ),
                            ) : store.dispatch(
                              OrganizationUpdateAction(
                                id: orgUpdate.id,
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
      },
    );
  }
}
