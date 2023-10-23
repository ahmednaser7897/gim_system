import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/controller/gym/gym_cubit.dart';
import 'package:gim_system/ui/gym/exercises/edit_exercise_screen.dart';

import '../../../app/app_assets.dart';
import '../../../app/app_sized_box.dart';
import '../../../app/luanch_url.dart';
import '../../componnents/screen_builder.dart';
import '../../componnents/widgets.dart';

class GymExercisesList extends StatefulWidget {
  const GymExercisesList({super.key});

  @override
  State<GymExercisesList> createState() => _GymExercisesListState();
}

class _GymExercisesListState extends State<GymExercisesList> {
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
                    buildexercisesList(),
                    AppSizedBox.h2,
                  ],
                ),
              ),
            ),
          ),
          isEmpty: false,
          isErorr: state is ErorrGetHomeData,
          isLoading: state is LoadingGetHomeData,
          isSc: state is ScGetHomeData || cubit.exercises.isNotEmpty,
        );
      },
    );
  }

  Widget buildexercisesList() {
    return Builder(builder: (context) {
      var cubit = GymCubit.get(context);
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        itemCount: cubit.exercises.length,
        itemBuilder: (context, index) {
          return BlocConsumer<GymCubit, GymState>(
            listener: (context, state) {},
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  launchURLFunction(cubit.exercises[index].videoLink.orEmpty());
                  // Clipboard.setData(ClipboardData(
                  //     text: cubit.exercises[index].videoLink.orEmpty()));
                  // showFlutterToast(
                  //   message: "Video link copied",
                  //   toastColor: Colors.green,
                  // );
                },
                child: buildHomeItem(
                  ban: false,
                  name: cubit.exercises[index].name.orEmpty(),
                  des: cubit.exercises[index].videoLink.orEmpty(),
                  image: null,
                  icon: Icons.edit,
                  id: cubit.exercises[index].id.orEmpty(),
                  assetImage: AppAssets.exercise,
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditExercisesScreen(
                          exerciseModel: cubit.exercises[index],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      );
    });
  }
}
