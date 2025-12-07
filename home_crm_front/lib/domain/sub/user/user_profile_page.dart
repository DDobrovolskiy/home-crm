import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_event.dart';
import 'package:home_crm_front/domain/sub/user/event/user_employee_event.dart';
import 'package:home_crm_front/domain/sub/user/event/user_event.dart';
import 'package:home_crm_front/domain/sub/user/user_state/user_employee_state.dart';
import 'package:home_crm_front/domain/sub/user/user_state/user_state.dart';
import 'package:home_crm_front/domain/support/components/divided/divider.dart';
import 'package:home_crm_front/domain/support/router/roters.gr.dart';
import 'package:home_crm_front/domain/support/widgets/stamp.dart';
import 'package:home_crm_front/theme/theme.dart';

import '../../../home_crm_app.dart';
import '../../support/components/button/button.dart';
import '../../support/components/screen/Screen.dart';
import '../../support/components/status/user.dart';
import '../../support/components/tariff/tariff.dart';
import '../authentication/bloc/auth_bloc.dart';
import '../authentication/event/auth_event.dart';
import '../organization/bloc/organization_bloc.dart';
import '../organization/widgets/organization_list.dart';
import '../organization/widgets/organization_select.dart';
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
    BlocProvider.of<UserEmployeeBloc>(context).add(UserEmployeeLoadEvent());
    BlocProvider.of<OrganizationCurrentBloc>(context).add(
        OrganizationRefreshEvent());
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
            text: 'Выйти со всех устройств',
            onPressed: () async {
              BlocProvider.of<AuthBloc>(context).add(AuthLogoutAllEvent());
              var bool = await resetBlocs();
              AutoRouter.of(context).replace(AuthLoginRoute());
            },
          ),
          CustomButton(
            text: 'Выйти',
            onPressed: () async {
              BlocProvider.of<AuthBloc>(context).add(AuthLogoutEvent());
              var bool = await resetBlocs();
              AutoRouter.of(context).replace(AuthLoginRoute());
            },
          ),
          CustomButton(
            text: 'Продолжить',
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
                    createLabelRow('Ваш ID', state.user?.id.toString()),
                  ],
                ),
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
            'Доступные организации:',
            style: CustomColors.getLabelMedium(context, null),
          ),
          // _userEmployee(context),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
            child: Container(
              child: scrollOrganization(),
            ),
          ),
        ],
      ),
    );
  }

  Widget scrollOrganization() {
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
          return OrganizationList(employees: state.employee!.employees,);
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

}

