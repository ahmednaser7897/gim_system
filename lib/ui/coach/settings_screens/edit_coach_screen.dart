import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_prefs.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/app_validation.dart';
import 'package:gim_system/app/extensions.dart';

import '../../../controller/coach/coach_cubit.dart';
import '../../../model/coach_model.dart';
import '../../auth/widgets/build_auth_bottom.dart';
import '../../componnents/app_textformfiled_widget.dart';
import '../../componnents/const_widget.dart';
import '../../componnents/image_picker/image_cubit/image_cubit.dart';
import '../../componnents/image_picker/image_widget.dart';
import '../../componnents/show_flutter_toast.dart';
import '../../componnents/widgets.dart';

class EditCoachScreen extends StatefulWidget {
  const EditCoachScreen({super.key});

  @override
  State<EditCoachScreen> createState() => _EditCoachScreenState();
}

class _EditCoachScreenState extends State<EditCoachScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    CoachCubit cubit = CoachCubit.get(context);
    genderController.text = cubit.coachModel!.gender.orEmpty();
    nameController.text = cubit.coachModel!.name.orEmpty();
    bioController.text = cubit.coachModel!.bio.orEmpty();
    agecontroller.text = cubit.coachModel!.age.orEmpty();
    phoneController.text = cubit.coachModel!.phone.orEmpty();
    passwordController.text = cubit.coachModel!.password.orEmpty();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CoachCubit cubit = CoachCubit.get(context);
    return BlocProvider(
      create: (context) => ImageCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit New Coach'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSizedBox.h1,
                    Align(
                        alignment: Alignment.center,
                        child: ImageWidget(
                          init: cubit.coachModel!.image,
                        )),
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
                      hintText: "Enter coach name",
                      prefix: Icons.person,
                      validate: (value) {
                        return Validations.normalValidation(value,
                            name: 'coach name');
                        // if (value!.isEmpty) {
                        //   return "Please Enter coach name";
                        // }
                        // return null;
                      },
                    ),
                    AppSizedBox.h3,
                    const Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    AppSizedBox.h2,
                    AppTextFormFiledWidget(
                      controller: passwordController,
                      hintText: "Enter coach password",
                      prefix: Icons.lock,
                      suffix: Icons.visibility,
                      isPassword: true,
                      validate: (value) {
                        return Validations.passwordValidation(value,
                            name: 'coach password');
                      },
                    ),
                    AppSizedBox.h3,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                "Phone",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              AppSizedBox.h2,
                              AppTextFormFiledWidget(
                                keyboardType: TextInputType.phone,
                                controller: phoneController,
                                hintText: "Enter coach phone",
                                prefix: Icons.call,
                                validate: (value) {
                                  return Validations.mobileValidation(value,
                                      name: 'coach phone');
                                },
                              ),
                            ],
                          ),
                        ),
                        AppSizedBox.w5,
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                "Gender",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              AppSizedBox.h2,
                              genderWidget(genderController),
                            ],
                          ),
                        ),
                      ],
                    ),
                    AppSizedBox.h3,
                    const Text(
                      "age",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    AppSizedBox.h2,
                    AppTextFormFiledWidget(
                      controller: agecontroller,
                      prefix: Icons.timelapse,
                      keyboardType: TextInputType.number,
                      hintText: "Enter coach age",
                      validate: (value) {
                        return Validations.normalValidation(value,
                            name: 'coach age');
                      },
                    ),
                    AppSizedBox.h3,
                    const Text(
                      "bio",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    AppSizedBox.h2,
                    AppTextFormFiledWidget(
                      controller: bioController,
                      maxLines: 4,
                      keyboardType: TextInputType.text,
                      hintText: "Enter coach bio",
                      validate: (value) {
                        return Validations.normalValidation(value,
                            name: 'coach bio');
                      },
                    ),
                    AppSizedBox.h3,
                    BlocConsumer<CoachCubit, CoachState>(
                      listener: (context, state) {
                        if (state is ScEditCoach) {
                          showFlutterToast(
                            message: "Coach Edited",
                            toastColor: Colors.green,
                          );
                          Navigator.pop(context);
                        }
                        if (state is ErorrEditCoach) {
                          showFlutterToast(
                            message: state.error,
                            toastColor: Colors.red,
                          );
                        }
                      },
                      builder: (context, state) {
                        CoachCubit cubit = CoachCubit.get(context);
                        return state is LoadingEditCoach
                            ? const CircularProgressComponent()
                            : BottomComponent(
                                child: const Text(
                                  'Edit New Coach',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.editCoach(
                                        image: ImageCubit.get(context).image,
                                        model: CoachModel(
                                          name: nameController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                          age: agecontroller.text,
                                          gender: genderController.text,
                                          bio: bioController.text,
                                          gymId: AppPreferences.gymUid,
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
      ),
    );
  }
}
