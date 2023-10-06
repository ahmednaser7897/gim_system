import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_prefs.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/model/user_model.dart';

import '../../../app/app_validation.dart';
import '../../../controller/coach/coach_cubit.dart';
import '../../../model/exercises_model.dart';
import '../../auth/widgets/build_auth_bottom.dart';
import '../../componnents/app_textformfiled_widget.dart';
import '../../componnents/const_widget.dart';
import '../../componnents/custom_button.dart';
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
  List<TextEditingController> counts = [];
  List<TextEditingController> totals = [];
  List<String> names = [];
  final _formKey = GlobalKey<FormState>();
  List<Exercise> exercises = [];
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
          CoachCubit cubit = CoachCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add New Exercises'),
            ),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSizedBox.h1,
                    esercisesWidget(),
                    AppSizedBox.h3,
                    CustomButton(
                      text: 'Add Exercises from gym exercises',
                      width: 90,
                      fontsize: 12,
                      iconRight: const Icon(Icons.add),
                      onTap: () {
                        if (cubit.esercises.isEmpty) {
                          showFlutterToast(
                            message: 'your gym has no exercises',
                            toastColor: Colors.red,
                          );
                        } else {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => ListView.separated(
                                itemBuilder: (context, index) =>
                                    eserciseBottomSheetItem(
                                        cubit.esercises.orEmpty()[index]),
                                separatorBuilder: (context, index) =>
                                    AppSizedBox.h1,
                                itemCount: cubit.esercises.length),
                          );
                        }
                      },
                    ),
                    AppSizedBox.h3,
                    BlocConsumer<CoachCubit, CoachState>(
                      listener: (context, state) {
                        if (state is ScAddExercise) {
                          showFlutterToast(
                            message: "Exercises added",
                            toastColor: Colors.green,
                          );
                          Navigator.pop(context);
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
                                  'Add all exercises to user',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (exercises.isEmpty) {
                                      showFlutterToast(
                                        message: 'you must select 1 at least',
                                        toastColor: Colors.red,
                                      );
                                    } else {
                                      cubit.addExercise(
                                          model: UserExercises(
                                        exercises: exercises,
                                        done: false,
                                        date: DateTime.now().toString(),
                                        coachId: AppPreferences.uId,
                                        userId: widget.user.id,
                                      ));
                                    }
                                  }
                                },
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget esercisesWidget() {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) => eserciseItem(index),
          separatorBuilder: (context, index) => AppSizedBox.h1,
          itemCount: exercises.length),
    );
  }

  Column eserciseItem(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              names[index],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    exercises.removeAt(index);
                    names.removeAt(index);
                    counts.removeAt(index);
                    totals.removeAt(index);
                  });
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        AppSizedBox.h1,
        const Text(
          'count',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        AppSizedBox.h1,
        AppTextFormFiledWidget(
          controller: counts[index],
          onChanged: (p0) {
            exercises[index].count = double.tryParse(p0) ?? 0;
          },
          keyboardType: TextInputType.number,
          hintText: "Enter Exercises count",
          prefix: Icons.numbers,
          validate: (value) {
            return Validations.normalValidation(value, name: 'count');
          },
        ),
        AppSizedBox.h1,
        const Text(
          'total',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        AppSizedBox.h1,
        AppTextFormFiledWidget(
          controller: totals[index],
          onChanged: (p0) {
            exercises[index].total = double.tryParse(p0) ?? 0;
          },
          keyboardType: TextInputType.number,
          hintText: "Enter Exercises total",
          prefix: Icons.numbers,
          validate: (value) {
            return Validations.normalValidation(value, name: 'total');
          },
        ),
      ],
    );
  }

  Widget eserciseBottomSheetItem(ExerciseModel model) {
    return Builder(builder: (context) {
      return ListTile(
        onTap: () {
          if ((exercises.where(
            (element) => element.exerciseId == model.id,
          )).isEmpty) {
            setState(() {
              exercises.add(Exercise(
                  count: 0, total: 0, exerciseId: model.id, done: false));
              names.add(model.name.orEmpty());
              counts.add(TextEditingController(text: '0'));
              totals.add(TextEditingController(text: '0'));
            });
          } else {
            showFlutterToast(
              message: 'exercise is selected',
              toastColor: Colors.red,
            );
          }

          Navigator.pop(context);
        },
        title: Text(model.name.orEmpty()),
        subtitle: Text(model.videoLink.orEmpty()),
      );
    });
  }
}
