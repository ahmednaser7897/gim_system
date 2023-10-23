import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_colors.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/app_sized_box.dart';
import '../../../app/fuctions.dart';
import '../../../controller/coach/coach_cubit.dart';
import '../../../controller/user/user_cubit.dart';
import '../../../model/exercises_model.dart';
import '../../../model/user_model.dart';
import '../../coach/users/add_new_user_exercises.dart';
import 'exercise_details.dart';

class ShowAndEditUserExercises extends StatefulWidget {
  const ShowAndEditUserExercises(
      {super.key,
      required this.user,
      this.canEdit = true,
      this.canAdd = false});
  final UserModel user;
  final bool canEdit;
  final bool canAdd;

  @override
  State<ShowAndEditUserExercises> createState() =>
      _ShowAndEditUserExercisesState();
}

class _ShowAndEditUserExercisesState extends State<ShowAndEditUserExercises> {
  late UserModel user;
  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Show User Exercises'),
          actions: [
            if (widget.canAdd)
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNewUserExercisesScreen(
                          user: user,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add))
          ],
        ),
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {},
          builder: (context, state) {
            return BlocConsumer<CoachCubit, CoachState>(
              listener: (context, state) {},
              builder: (context, state) {
                return esercisesList();
              },
            );
          },
        ));
  }

  Widget esercisesList() {
    return ListView.separated(
        padding: EdgeInsets.all(5.w),
        itemBuilder: (context, index) =>
            userEsercisesWidget(user.userExercises.orEmpty()[index]),
        separatorBuilder: (context, index) => Column(
              children: [
                AppSizedBox.h1,
                const Divider(
                  color: AppColors.black,
                  height: 2,
                ),
                AppSizedBox.h2,
              ],
            ),
        itemCount: user.userExercises.orEmpty().length);
  }

  Widget userEsercisesWidget(UserExercises model) {
    return Builder(builder: (context) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExerciseDetails(
                  canEdit: widget.canEdit,
                  model: model,
                ),
              ));
        },
        child: FadeInUp(
          from: 20,
          delay: const Duration(milliseconds: 400),
          duration: const Duration(milliseconds: 500),
          child: Container(
            width: 100.w,
            margin: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: model.done.orFalse() ? Colors.white : Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSizedBox.w3,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Coach : ${model.coachModel!.name.orEmpty()}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.almarai(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      AppSizedBox.w1,
                      Text(
                        getDate(model.date.orEmpty()),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.almarai(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  AppSizedBox.h1,
                  Text(
                    "Exercise Status : ${model.done.orFalse() ? "Finished" : "Not Finish"}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppSizedBox.h1,
                  Text(
                    "Exercises count : ${model.exercises.orEmpty().length}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
