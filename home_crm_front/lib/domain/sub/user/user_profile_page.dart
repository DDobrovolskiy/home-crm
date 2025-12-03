import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_edit_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_edit_event.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_event.dart';
import 'package:home_crm_front/domain/sub/user/bloc/user_organization_bloc.dart';
import 'package:home_crm_front/domain/sub/user/event/user_employee_event.dart';
import 'package:home_crm_front/domain/sub/user/event/user_event.dart';
import 'package:home_crm_front/domain/sub/user/event/user_organization_event.dart';
import 'package:home_crm_front/domain/sub/user/user_state/user_employee_state.dart';
import 'package:home_crm_front/domain/sub/user/user_state/user_organization_state.dart';
import 'package:home_crm_front/domain/sub/user/user_state/user_state.dart';
import 'package:home_crm_front/domain/support/components/divided/divider.dart';
import 'package:home_crm_front/domain/support/router/roters.gr.dart';
import 'package:home_crm_front/domain/support/widgets/stamp.dart';
import 'package:home_crm_front/theme/theme.dart';

import '../../support/components/button/button.dart';
import '../../support/components/screen/Screen.dart';
import '../../support/components/status/user.dart';
import '../../support/components/tariff/tariff.dart';
import '../organization/bloc/organization_bloc.dart';
import '../organization/state/organization_state.dart';
import '../organization/widgets/organization_select.dart';
import '../organization/widgets/orgnization_add.dart';
import '../role/bloc/role_current.dart';
import '../role/state/role_current_state.dart';
import 'bloc/user_bloc.dart';
import 'bloc/user_employee_bloc.dart';

@RoutePage()
class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final ScrollController _controller = ScrollController();

  bool isHoveredAddOrganization = false;

  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(UserLoadEvent());
    BlocProvider.of<UserOrganizationBloc>(
      context,
    ).add(UserOrganizationRefreshEvent());
    BlocProvider.of<UserEmployeeBloc>(context).add(UserEmployeeLoadEvent());
    BlocProvider.of<OrganizationBloc>(context).add(OrganizationRefreshEvent());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose(); // Уничтожаем контроллер при завершении
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.getSecondaryBackground(context),
        appBar: !Screen.isWeb(context) ? getAppBar(context) : null,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Align(
                alignment: AlignmentDirectional(0, -1),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(maxWidth: Screen.getMaxWidth()),
                  decoration: BoxDecoration(
                    color: CustomColors.getSecondaryBackground(context),
                  ),
                  child: SingleChildScrollView(child: getContent()),
                ),
              ),
            ),
            //Button
            if (Screen.isHeight(context, 220))
              Container(
                width: double.infinity,
                height: 120,
                constraints: BoxConstraints(maxWidth: Screen.getMaxWidth()),
                child: getButton(),
              ),
          ],
        ),
      ),
    );
  }

  Widget getButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 34),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButton(
            text: 'Продолжить',
            height: 50,
            width: 150,
            onPressed: () => AutoRouter.of(context).push(HomeRoute()),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget getAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.getPrimary(context),
      automaticallyImplyLeading: false,
      title: Text(
        'Личный кабинет',
        style: CustomColors.getDisplaySmall(
          context,
          CustomColors.getPrimaryBtnText(context),
        ),
      ),
      leading: null,
    );
    //+add animation
  }

  Widget getContent() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getPhoto(),
        getUserInfo(),
        getHorizontalDivider(context),
        UserStatus(),
        getHorizontalDivider(context),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
              child: Container(
                width: Screen.getNavBarWidth(),
                constraints: BoxConstraints(maxWidth: 250),
                child: OrganizationSelect(),
              ),
            ),
            getVerticalDivider(context),
            Expanded(child: Center(child: Tariff())),
          ],
        ),

        getHorizontalDivider(context),
        outOrganization(),
        getHorizontalDivider(context),
        //организацияя на выбор
        //кнопки редактировать профиль и продолжить
      ],
    );
  }

  Widget getPhoto() {
    return Container(
      height: 240,
      child: Stack(
        alignment: AlignmentDirectional(-0.95, -0.7),
        children: [
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Image.asset(
              'assets/common/blank-profile.jpg',
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.95, -0.95),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                Stamp.showTemporarySnackbar(
                  context,
                  'Функционал не реализован',
                );
              },
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color(0xFFF5F5F5),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.edit,
                    color: CustomColors.getPrimary(context),
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.95, -0.95),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                AutoRouter.of(context).back();
              },
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color(0xFFF5F5F5),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: CustomColors.getPrimary(context),
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getUserInfo() {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        if (state is UserInitState) {
          return Stamp.loadWidget(context);
        } else if (state is UserLoadedState) {
          return Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    createLabelRow('Фамилия', null),
                    createLabelRow('Имя', state.user?.name),
                    createLabelRow('Отчество', null),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    createLabelRow('Телефон', state.user?.phone),
                    createLabelRow('@telegram', null),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Stamp.errorWidget(context);
        }
      },
    );
  }

  Widget createLabelRow(String label, String? value) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: CustomColors.getLabelMedium(context, null)),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
          child: Text(
            value ?? '-',
            textAlign: TextAlign.start,
            style: CustomColors.getHeadLineMedium(context, null),
          ),
        ),
      ],
    );
  }

  Widget outOrganization() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 3, 0, 3),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Выбирете организацию, с которой будете работать:',
            style: CustomColors.getLabelMedium(context, null),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
            child: Container(
              height: 230,
              child: Row(children: [Expanded(child: scrollOrganization())]),
            ),
          ),
        ],
      ),
    );
  }

  Widget scrollOrganization() {
    return Listener(
      // onPointerSignal: handleScroll,
      child: ListView(
        // controller: _controller,
        // padding: EdgeInsets.zero,
        // primary: false,
        // shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        children: [OrganizationAdd()],
      ),
    );
  }

  Widget selectedOrganizationRole() {
    return BlocConsumer<RoleCurrentBloc, RoleCurrentState>(
      listener: (context, state) {
        if (state is RoleCurrentErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        if (state is RoleCurrentInitState) {
          return Stamp.loadWidget(context);
        } else if (state is RoleCurrentLoadedState) {
          return Text('${state.role?.name}');
        } else {
          return Stamp.errorWidget(context);
        }
      },
    );
  }

  Widget organizationEmptyCard() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
      child: Container(
        width: 220,
        height: 220,
        decoration: BoxDecoration(
          color: CustomColors.getSecondaryBackground(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: CustomColors.getAlternate(context),
            width: 1.5,
          ),
        ),
        child: Center(
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            alignment: AlignmentDirectional(0, 0),
            child: Icon(
              Icons.question_mark,
              color: CustomColors.getPrimaryText(context),
              size: 36,
            ),
          ),
        ),
      ),
    );
  }

  Widget organizationCard(String name, String role, bool owner, bool selected) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          color: selected
              ? CustomColors.getPrimary(context)
              : CustomColors.getSecondaryBackground(context),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x34090F13),
              offset: Offset(0.0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: CustomColors.getAlternate(context),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: CustomColors.getPrimary(context),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Color(0x98FFFFFF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Icon(
                          owner ? Icons.workspace_premium : Icons.work,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      Text(
                        name,
                        style: CustomColors.getTitleMedium(context, null),
                      ),
                      Text(
                        role,
                        style: CustomColors.getTitleSmall(context, null),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150,
                      child: Row(children: [Icon(Icons.account_box, size: 20)]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _user(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        if (state is UserInitState) {
          return Stamp.loadWidget(context);
        } else if (state is UserLoadedState) {
          return Column(
            children: [
              Text(
                'Имя: ${state.user?.name}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text('Телефон: ${state.user?.phone}'),
            ],
          );
        } else {
          return Stamp.errorWidget(context);
        }
      },
    );
  }

  Widget _organization(BuildContext context) {
    return BlocConsumer<OrganizationBloc, OrganizationState>(
      listener: (context, state) {
        if (state is OrganizationErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        if (state is OrganizationUnSelectedState) {
          return Text('Выбирете организацию, с которой будете работать');
        } else if (state is OrganizationSelectedState) {
          return Card(
            color: Colors.blue.shade100,
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Icon(Icons.workspace_premium),
              title: Text('Выбранная организация'),
              subtitle: Text(
                'Организация: ${state.selected.organization.name}',
              ),
              trailing: OutlinedButton.icon(
                // Добавили кнопку с иконкой
                icon: Icon(Icons.keyboard_arrow_right),
                label: Text("Продолжить"),
                onPressed: () {
                  AutoRouter.of(context).push(HomeRoute());
                },
              ),
            ),
          );
        } else {
          return Stamp.errorWidget(context);
        }
      },
    );
  }

  Widget _userEmployee(BuildContext context) {
    return BlocConsumer<UserEmployeeBloc, UserEmployeeState>(
      listener: (context, state) {
        if (state is UserEmployeeErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        if (state is UserEmployeeInitState) {
          return Stamp.loadWidget(context);
        } else if (state is UserEmployeeLoadedState) {
          return Column(
            children: [
              const Divider(),
              const Text(
                'Вы работник в организациях:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              for (final empOrg in state.employee!.employees)
                Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Icon(Icons.work),
                    title: Text(empOrg.organization.name),
                    subtitle: Text('Роль: ${empOrg.role.name}'),
                    trailing: OutlinedButton.icon(
                      // Добавили кнопку с иконкой
                      icon: Icon(Icons.keyboard_arrow_right),
                      label: Text("Выбрать"),
                      onPressed: () {
                        BlocProvider.of<OrganizationBloc>(context).add(
                          OrganizationSelectedEvent(id: empOrg.organization.id),
                        );
                        AutoRouter.of(context).push(HomeRoute());
                      },
                    ),
                  ),
                ),
            ],
          );
        } else {
          return Stamp.errorWidget(context);
        }
      },
    );
  }

  Widget _userOrganization(BuildContext context) {
    return BlocConsumer<UserOrganizationBloc, UserOrganizationState>(
      listener: (BuildContext context, UserOrganizationState state) {
        if (state is UserOrganizationErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        if (state is UserOrganizationInitState) {
          return Stamp.loadWidget(context);
        } else if (state is UserOrganizationLoadedState) {
          return Column(
            children: [
              const Divider(),
              const Text(
                'Ваши организации:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              if (state.organization?.organizations != null)
                for (final org in state.organization!.organizations)
                  Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: Icon(Icons.business),
                      title: Row(
                        children: [
                          TextButton(
                            style: Stamp.giperLink(),
                            onPressed: () {
                              BlocProvider.of<OrganizationBloc>(
                                context,
                              ).add(OrganizationSelectedEvent(id: org.id));
                              AutoRouter.of(context).push(OrganizationRoute());
                            },
                            child: Text(org.name),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              BlocProvider.of<OrganizationEditBloc>(
                                context,
                              ).add(OrganizationEditDeleteEvent(id: org.id));
                            },
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [Text('Владелец: ${org.owner.name}')],
                      ),
                      trailing: // Кнопка выбора
                      OutlinedButton.icon(
                        icon: Icon(Icons.keyboard_arrow_right),
                        label: Text("Выбрать"),
                        onPressed: () {
                          BlocProvider.of<OrganizationBloc>(
                            context,
                          ).add(OrganizationSelectedEvent(id: org.id));
                          AutoRouter.of(context).push(HomeRoute());
                        },
                      ),
                    ),
                  ),
              // Кнопка добавления новой организации-владельца
              Card(
                color: Colors.blue.shade100,
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Icon(Icons.add_circle_outline),
                  title: Text("Добавить организацию"),
                  onTap: () {
                    BlocProvider.of<OrganizationBloc>(
                      context,
                    ).add(OrganizationUnSelectedEvent());
                    AutoRouter.of(context).push(OrganizationRoute());
                  }, // Обработчик нажатия
                ),
              ),
            ],
          );
        } else {
          return Stamp.errorWidget(context);
        }
      },
    );
  }
}

enum MenuItem { itemOne, itemTwo }
