import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/controller/gym/gym_cubit.dart';

import '../../../app/app_sized_box.dart';
import '../../componnents/screen_builder.dart';
import '../../componnents/users_lists.dart';

class GymCoachsList extends StatefulWidget {
  const GymCoachsList({super.key});

  @override
  State<GymCoachsList> createState() => _GymCoachsListState();
}

class _GymCoachsListState extends State<GymCoachsList> {
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
                      AppSizedBox.h1,
                      buildCoachsList(coachs: cubit.coachs),
                      AppSizedBox.h2,
                    ],
                  ),
                ),
              ),
            ),
            isEmpty: false,
            isErorr: state is ErorrGetHomeData,
            isLoading: state is LoadingGetHomeData,
            isSc: state is ScGetHomeData || cubit.coachs.isNotEmpty);
      },
    );
  }

  // Widget buildCoachsList() {
  //   return Builder(builder: (context) {
  //     var cubit = GymCubit.get(context);
  //     return ListView.builder(
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       padding: const EdgeInsets.all(0),
  //       itemCount: cubit.coachs.length,
  //       itemBuilder: (context, index) {
  //         return BlocConsumer<GymCubit, GymState>(
  //           listener: (context, state) {},
  //           builder: (context, state) {
  //             return buildHomeItem(
  //               ban: cubit.coachs[index].ban.orFalse(),
  //               name: cubit.coachs[index].name.orEmpty(),
  //               des: cubit.coachs[index].email.orEmpty(),
  //               image: cubit.coachs[index].image,
  //               assetImage: AppAssets.uoach,
  //               ontap: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => CoachDetailsScreen(
  //                       coachModel: cubit.coachs[index],
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
