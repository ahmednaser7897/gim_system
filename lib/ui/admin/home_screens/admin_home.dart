import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app_sized_box.dart';
import '../../../controller/admin/admin_cubit.dart';
import '../../auth/widgets/build_auth_bottom.dart';
import '../../componnents/log_out_button.dart';
import '../../componnents/screen_builder.dart';
import '../add_new_admin_screen.dart';
import '../add_new_gym_screen.dart';

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
          current is LoadingGetAdmin ||
          current is ScGetAdmin ||
          current is ErorrGetAdmin,
      listener: (context, state) {},
      builder: (context, state) {
        return screenBuilder(
          contant: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('AdminHome'),
                AppSizedBox.h10,
                BottomComponent(
                  child: const Text(
                    'Add New Gym',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddNewGymScreen(),
                        ));
                  },
                ),
                AppSizedBox.h10,
                BottomComponent(
                  child: const Text(
                    'Add New Admin',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddNewAdminScreen(),
                        ));
                  },
                ),
                AppSizedBox.h10,
                const LogOutButton(),
              ],
            ),
          ),
          isEmpty: false,
          isErorr: state is ErorrGetAdmin,
          isLoading: state is LoadingGetAdmin,
          isSc: state is ScGetAdmin,
        );
        // if (state is LoadingGetAdmin) {
        //   return const CircularProgressComponent();
        // } else if (state is ScGetAdmin) {
        //   return SizedBox(
        //     width: double.infinity,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         const Text('AdminHome'),
        //         AppSizedBox.h10,
        //         const LogOutButton(),
        //       ],
        //     ),
        //   );
        // } else {
        //   return const Center(
        //     child: LogOutButton(),
        //   );
        // }
      },
    );
  }
}
