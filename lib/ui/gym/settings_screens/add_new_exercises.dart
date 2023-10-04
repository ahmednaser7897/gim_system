import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_prefs.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/app_validation.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/controller/gym/gym_cubit.dart';

import '../../../model/exercises_model.dart';
import '../../auth/widgets/build_auth_bottom.dart';
import '../../componnents/app_textformfiled_widget.dart';
import '../../componnents/const_widget.dart';
import '../../componnents/image_picker/image_cubit/image_cubit.dart';
import '../../componnents/show_flutter_toast.dart';

class AddNewExercisesScreen extends StatefulWidget {
  const AddNewExercisesScreen({super.key});

  @override
  State<AddNewExercisesScreen> createState() => _AddNewExercisesScreenState();
}

class _AddNewExercisesScreenState extends State<AddNewExercisesScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController videoLinkController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add New Exercise'),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSizedBox.h1,
                  const Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  AppSizedBox.h2,
                  AppTextFormFiledWidget(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    hintText: "Enter Exercise name",
                    prefix: Icons.sports_gymnastics,
                    validate: (value) {
                      return Validations.normalValidation(value,
                          name: 'Exercise name');
                    },
                  ),
                  AppSizedBox.h3,
                  const Text(
                    "Video Link",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  AppSizedBox.h2,
                  AppTextFormFiledWidget(
                    maxLines: 3,
                    controller: videoLinkController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Enter Exercise video Link",
                    validate: (value) {
                      return Validations.normalValidation(value,
                          name: 'Exercise video link');
                    },
                  ),
                  AppSizedBox.h3,
                  const Spacer(),
                  BlocConsumer<GymCubit, GymState>(
                    listener: (context, state) {
                      if (state is ScAddExercise) {
                        showFlutterToast(
                          message: "Exercise added",
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
                      GymCubit cubit = GymCubit.get(context);
                      return state is LoadingAddExercise
                          ? const CircularProgressComponent()
                          : BottomComponent(
                              child: const Text(
                                'Add New Exercise',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.addExercise(
                                      model: ExerciseModel(
                                    gymId: AppPreferences.uId,
                                    name: nameController.text,
                                    videoLink: videoLinkController.text,
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
  }
}
