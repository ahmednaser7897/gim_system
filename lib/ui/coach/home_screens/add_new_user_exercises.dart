import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_prefs.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/app_validation.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/model/user_model.dart';

import '../../../controller/coach/coach_cubit.dart';
import '../../../model/exercises_model.dart';
import '../../auth/widgets/build_auth_bottom.dart';
import '../../componnents/app_textformfiled_widget.dart';
import '../../componnents/const_widget.dart';
import '../../componnents/image_picker/image_cubit/image_cubit.dart';
import '../../componnents/show_flutter_toast.dart';

class AddNewUserExercisesScreen extends StatefulWidget {
  const AddNewUserExercisesScreen({super.key, required this.user});
  final UserModel user;

  @override
  State<AddNewUserExercisesScreen> createState() =>
      _AddNewUserExercisesScreenState();
}

class _AddNewUserExercisesScreenState extends State<AddNewUserExercisesScreen> {
  // TextEditingController breakfastController = TextEditingController();
  // TextEditingController dinnerController = TextEditingController();
  // TextEditingController lunchController = TextEditingController();
  // TextEditingController notesController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  List<Exercise> exercises = [
    Exercise(count: 1, total: 1, exerciseId: 'dndn', done: false),
    Exercise(count: 1, total: 1, exerciseId: 'dnjsjsdn', done: false)
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageCubit(),
      child: BlocConsumer<CoachCubit, CoachState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add New Exercises'),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSizedBox.h1,
                        // const Text(
                        //   "Break fast",
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // ),
                        // AppSizedBox.h2,
                        // AppTextFormFiledWidget(
                        //   controller: breakfastController,
                        //   keyboardType: TextInputType.text,
                        //   hintText: "Enter Exercises Break fast",
                        //   prefix: Icons.sports_gymnastics,
                        //   validate: (value) {
                        //     return Validations.normalValidation(value,
                        //         name: 'Break fast');
                        //   },
                        // ),
                        // AppSizedBox.h3,
                        // const Text(
                        //   "Dinner",
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // ),
                        // AppSizedBox.h2,
                        // AppTextFormFiledWidget(
                        //   controller: dinnerController,
                        //   keyboardType: TextInputType.text,
                        //   hintText: "Enter Dinner",
                        //   prefix: Icons.sports_gymnastics,
                        //   validate: (value) {
                        //     return Validations.normalValidation(value,
                        //         name: 'Dinner');
                        //   },
                        // ),
                        // AppSizedBox.h3,
                        // const Text(
                        //   "Lunch",
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // ),
                        // AppSizedBox.h2,
                        // AppTextFormFiledWidget(
                        //   controller: lunchController,
                        //   keyboardType: TextInputType.text,
                        //   hintText: "Enter  Lunch",
                        //   prefix: Icons.sports_gymnastics,
                        //   validate: (value) {
                        //     return Validations.normalValidation(value,
                        //         name: 'Lunch');
                        //   },
                        // ),
                        // AppSizedBox.h3,
                        // const Text(
                        //   "Notes",
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // ),
                        // AppSizedBox.h2,
                        // AppTextFormFiledWidget(
                        //   maxLines: 3,
                        //   controller: notesController,
                        //   keyboardType: TextInputType.emailAddress,
                        //   hintText: "Enter Notes",
                        //   validate: (value) {
                        //     return Validations.normalValidation(value,
                        //         name: 'Notes');
                        //   },
                        // ),
                        // AppSizedBox.h3,
                        BlocConsumer<CoachCubit, CoachState>(
                          listener: (context, state) {
                            if (state is ScAddExercise) {
                              showFlutterToast(
                                message: "Exercises added",
                                toastColor: Colors.green,
                              );
                              // Navigator.pop(context);
                            }
                            if (state is ErorrAddExercise) {
                              showFlutterToast(
                                message: state.error,
                                toastColor: Colors.red,
                              );
                            }
                          },
                          builder: (context, state) {
                            CoachCubit cubit = CoachCubit.get(context);
                            return state is LoadingAddExercise
                                ? const CircularProgressComponent()
                                : BottomComponent(
                                    child: const Text(
                                      'Add New Exercises',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.addExercise(
                                            model: UserExercises(
                                          exercises: exercises,
                                          done: false,
                                          date: DateTime.now().toString(),
                                          coachId: AppPreferences.uId,
                                          userId: widget.user.id,
                                        ));
                                      }
                                    },
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
