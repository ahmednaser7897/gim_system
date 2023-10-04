import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/ui/admin/home_screens/admin_details_screen.dart';
import 'package:gim_system/ui/admin/home_screens/gym_details_screen.dart';

import '../../../app/app_sized_box.dart';
import '../../../controller/admin/admin_cubit.dart';
import '../../componnents/screen_builder.dart';
import '../../componnents/widgets.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      buildWhen: (previous, current) =>
          current is LoadingGetHomeData ||
          current is ScGetHomeData ||
          current is ErorrGetHomeData,
      listener: (context, state) {},
      builder: (context, state) {
        AdminCubit cubit = AdminCubit.get(context);
        return screenBuilder(
          contant: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSizedBox.h1,
                    const Text(
                      "Gyms :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    AppSizedBox.h2,
                    buildgymList(),
                    AppSizedBox.h2,
                    const Text(
                      "Admins :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    AppSizedBox.h2,
                    buildAdminList(),
                    AppSizedBox.h2,
                  ],
                ),
              ),
            ),
          ),
          isEmpty: false,
          isErorr: state is ErorrGetHomeData,
          isLoading: state is LoadingGetHomeData,
          isSc: state is ScGetHomeData ||
              cubit.gyms.isNotEmpty ||
              cubit.admins.isNotEmpty,
        );
      },
    );
  }

  Widget buildAdminList() {
    return Builder(builder: (context) {
      var cubit = AdminCubit.get(context);
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        itemCount: cubit.admins.length,
        itemBuilder: (context, index) {
          return BlocConsumer<AdminCubit, AdminState>(
            listener: (context, state) {},
            builder: (context, state) {
              return buildHomeItem(
                ban: cubit.admins[index].ban.orFalse(),
                name: cubit.admins[index].name.orEmpty(),
                des: cubit.admins[index].email.orEmpty(),
                image: cubit.admins[index].image,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminDetailsScreen(
                        adminModel: cubit.admins[index],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      );
    });
  }

  Widget buildgymList() {
    return Builder(builder: (context) {
      var cubit = AdminCubit.get(context);
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        itemCount: cubit.gyms.length,
        itemBuilder: (context, index) {
          return BlocConsumer<AdminCubit, AdminState>(
            listener: (context, state) {},
            builder: (context, state) {
              return buildHomeItem(
                ban: cubit.gyms[index].ban.orFalse(),
                name: cubit.gyms[index].name.orEmpty(),
                des: cubit.gyms[index].email.orEmpty(),
                image: cubit.gyms[index].image,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GymDetailsScreen(
                        gymModel: cubit.gyms[index],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      );
    });
  }
}
