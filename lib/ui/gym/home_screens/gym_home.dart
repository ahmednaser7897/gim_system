import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/controller/gym/gym_cubit.dart';
import 'package:gim_system/ui/gym/home_screens/coach_details_screen.dart';
import 'package:gim_system/ui/gym/home_screens/edit_exercise_screen.dart';

import '../../../app/app_sized_box.dart';
import '../../componnents/screen_builder.dart';
import '../../componnents/show_flutter_toast.dart';
import '../../componnents/widgets.dart';
import 'user_details_screen.dart';

class GymHome extends StatefulWidget {
  const GymHome({super.key});

  @override
  State<GymHome> createState() => _GymHomeState();
}

class _GymHomeState extends State<GymHome> {
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
                    const Text(
                      "Coachs :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    AppSizedBox.h2,
                    buildCoachsList(),
                    AppSizedBox.h2,
                    const Text(
                      "Users :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    AppSizedBox.h2,
                    buildUserList(),
                    AppSizedBox.h2,
                    const Text(
                      "Exercises :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    AppSizedBox.h2,
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
          isSc: state is ScGetHomeData ||
              cubit.coachs.isNotEmpty ||
              cubit.users.isNotEmpty ||
              cubit.exercises.isNotEmpty,
        );
      },
    );
  }

  Widget buildCoachsList() {
    return Builder(builder: (context) {
      var cubit = GymCubit.get(context);
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        itemCount: cubit.coachs.length,
        itemBuilder: (context, index) {
          return BlocConsumer<GymCubit, GymState>(
            listener: (context, state) {},
            builder: (context, state) {
              return buildHomeItem(
                ban: cubit.coachs[index].ban.orFalse(),
                name: cubit.coachs[index].name.orEmpty(),
                des: cubit.coachs[index].email.orEmpty(),
                image: cubit.coachs[index].image,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoachDetailsScreen(
                        coachModel: cubit.coachs[index],
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

  Widget buildUserList() {
    return Builder(builder: (context) {
      var cubit = GymCubit.get(context);
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        itemCount: cubit.users.length,
        itemBuilder: (context, index) {
          return BlocConsumer<GymCubit, GymState>(
            listener: (context, state) {},
            builder: (context, state) {
              return buildHomeItem(
                ban: cubit.users[index].ban.orFalse(),
                name: cubit.users[index].name.orEmpty(),
                des: cubit.users[index].email.orEmpty(),
                image: cubit.users[index].image,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsScreen(
                        model: cubit.users[index],
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
                  Clipboard.setData(ClipboardData(
                      text: cubit.exercises[index].videoLink.orEmpty()));
                  showFlutterToast(
                    message: "Video link copied",
                    toastColor: Colors.green,
                  );
                },
                child: buildHomeItem(
                  ban: false,
                  name: cubit.exercises[index].name.orEmpty(),
                  des: cubit.exercises[index].videoLink.orEmpty(),
                  image: null,
                  icon: Icons.edit,
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
