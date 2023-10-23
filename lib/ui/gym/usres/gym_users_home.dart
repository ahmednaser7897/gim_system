import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/controller/gym/gym_cubit.dart';

import '../../../app/app_sized_box.dart';
import '../../componnents/screen_builder.dart';
import '../../componnents/users_lists.dart';

class GymUsersList extends StatefulWidget {
  const GymUsersList({super.key});

  @override
  State<GymUsersList> createState() => _GymUsersListState();
}

class _GymUsersListState extends State<GymUsersList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit, GymState>(
      buildWhen: (previous, current) =>
          current is LoadingGetHomeData ||
          current is ScGetHomeData ||
          current is ErorrGetHomeData,
      listener: (context, state) {},
      builder: (context, state) {
        GymCubit cubit = GymCubit.get(context);
        return screenBuilder(
            contant: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildusersList(users: cubit.users),
                      AppSizedBox.h2,
                    ],
                  ),
                ),
              ),
            ),
            isEmpty: false,
            isErorr: state is ErorrGetHomeData,
            isLoading: state is LoadingGetHomeData,
            isSc: state is ScGetHomeData || cubit.users.isNotEmpty);
      },
    );
  }

  // Widget buildUserList() {
  //   return Builder(builder: (context) {
  //     var cubit = GymCubit.get(context);
  //     return ListView.builder(
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       padding: const EdgeInsets.all(0),
  //       itemCount: cubit.users.length,
  //       itemBuilder: (context, index) {
  //         return BlocConsumer<GymCubit, GymState>(
  //           listener: (context, state) {},
  //           builder: (context, state) {
  //             return buildHomeItem(
  //               ban: cubit.users[index].ban.orFalse(),
  //               name: cubit.users[index].name.orEmpty(),
  //               des: cubit.users[index].email.orEmpty(),
  //               image: cubit.users[index].image,
  //               assetImage: AppAssets.user,
  //               ontap: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => UserDetailsScreen(
  //                       model: cubit.users[index],
  //                     ),
  //                   ),
  //                 );
  //               },
  //             );
  //           },
  //         );
  //       },
  //     );
  //   });
  // }
}
