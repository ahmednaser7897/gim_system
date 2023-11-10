import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_assets.dart';
import 'package:gim_system/app/extensions.dart';

import '../../app/icon_broken.dart';
import '../../controller/admin/admin_cubit.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  void initState() {
    AdminCubit.get(context).getCurrentAdminData();
    AdminCubit.get(context).getHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {},
      builder: (context, state) {
        AdminCubit cubit = AdminCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            // unselectedItemColor: AppColors.grey,
            // selectedItemColor: AppColors.primaryColor,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.admin,
                  height: 7.w,
                  width: 7.w,
                ),
                label: 'Admins',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.gym,
                  height: 7.w,
                  width: 7.w,
                ),
                label: 'Gyms',
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
