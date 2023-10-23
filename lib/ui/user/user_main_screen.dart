import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/extensions.dart';

import '../../../app/icon_broken.dart';
import '../../app/app_assets.dart';
import '../../controller/user/user_cubit.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  void initState() {
    UserCubit.get(context).getCurrentUserData();
    UserCubit.get(context).getCurrentGymData();
    UserCubit.get(context).getHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        UserCubit cubit = UserCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.uoach,
                  height: 7.w,
                  width: 7.w,
                ),
                label: 'Coachs',
              ),
              const BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
