import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/controller/gym/gym_cubit.dart';

import '../../../app/icon_broken.dart';
import '../../app/app_assets.dart';

class GymHomeScreen extends StatefulWidget {
  const GymHomeScreen({super.key});

  @override
  State<GymHomeScreen> createState() => _GymHomeScreenState();
}

class _GymHomeScreenState extends State<GymHomeScreen> {
  @override
  void initState() {
    GymCubit.get(context).getCurrentGymData();
    GymCubit.get(context).getHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit, GymState>(
      listener: (context, state) {},
      builder: (context, state) {
        GymCubit cubit = GymCubit.get(context);
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
                  AppAssets.user,
                  height: 7.w,
                  width: 7.w,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.uoach,
                  height: 7.w,
                  width: 7.w,
                ),
                label: 'Coachs',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.exercise,
                  height: 7.w,
                  width: 7.w,
                ),
                label: 'Exercises',
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
