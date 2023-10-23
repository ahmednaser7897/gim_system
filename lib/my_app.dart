import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_prefs.dart';
import 'package:gim_system/app/constants.dart';
import 'package:gim_system/ui/admin/admin_main_screen.dart';
import 'package:gim_system/ui/coach/coach_main_screen.dart';

import 'app/notification/firebase_notification.dart';
import 'app/notification/local_notification.dart';
import 'app/style.dart';
import 'controller/admin/admin_cubit.dart';
import 'controller/coach/coach_cubit.dart';
import 'controller/gym/gym_cubit.dart';
import 'controller/user/user_cubit.dart';
import 'ui/auth/login_screen.dart';
import 'ui/gym/gym_main_screen.dart';
import 'ui/user/user_main_screen.dart';

class MyApp extends StatelessWidget {
  static late bool isDark;
  static late BuildContext appContext;
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HandleFirebaseNotification.handleNotifications(context);
    HandleLocalNotification notification = HandleLocalNotification();
    notification.initializeFlutterNotification(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AdminCubit(),
        ),
        BlocProvider(
          create: (context) => GymCubit(),
        ),
        BlocProvider(
          create: (context) => CoachCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: ThemeMode.light,
          onGenerateTitle: (context) {
            appContext = context;
            return '';
          },
          home: getInitialRoute()),
    );
  }

  Widget getInitialRoute() {
    Widget widget = const LoginScreen();

    if (AppPreferences.userType == Constants.admin) {
      return const AdminHomeScreen();
    }
    if (AppPreferences.userType == Constants.user) {
      return const UserHomeScreen();
    }
    if (AppPreferences.userType == Constants.coach) {
      return const CoachHomeScreen();
    }
    if (AppPreferences.userType == Constants.gym) {
      return const GymHomeScreen();
    }
    return widget;
  }
}
