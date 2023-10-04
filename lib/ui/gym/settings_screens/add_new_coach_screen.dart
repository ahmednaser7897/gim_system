import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_prefs.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/app_validation.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/controller/gym/gym_cubit.dart';

import '../../../model/coach_model.dart';
import '../../auth/widgets/build_auth_bottom.dart';
import '../../componnents/app_textformfiled_widget.dart';
import '../../componnents/const_widget.dart';
import '../../componnents/image_picker/image_cubit/image_cubit.dart';
import '../../componnents/image_picker/image_widget.dart';
import '../../componnents/show_flutter_toast.dart';
import '../../componnents/widgets.dart';

class AddNewCoachScreen extends StatefulWidget {
  const AddNewCoachScreen({super.key});

  @override
  State<AddNewCoachScreen> createState() => _AddNewCoachScreenState();
}

class _AddNewCoachScreenState extends State<AddNewCoachScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController agecontroller = TextEditingController();

  TextEditingController genderController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    genderController.text = 'male';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add New Coach'),
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
                    const Align(
                        alignment: Alignment.center, child: ImageWidget()),
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
                      "Email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    AppSizedBox.h2,
                    AppTextFormFiledWidget(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Enter coach email",
                      prefix: Icons.email_rounded,
                      validate: (value) {
                        return Validations.emailValidation(value,
                            name: 'coach email');
                        // if (value!.isEmpty) {
                        //   return "Please Enter Email";
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
                    BlocConsumer<GymCubit, GymState>(
                      listener: (context, state) {
                        if (state is ScAddCoach) {
                          showFlutterToast(
                            message: "Coach added",
                            toastColor: Colors.green,
                          );
                          Navigator.pop(context);
                        }
                        if (state is ErorrAddCoach) {
                          showFlutterToast(
                            message: state.error,
                            toastColor: Colors.red,
                          );
                        }
                      },
                      builder: (context, state) {
                        GymCubit cubit = GymCubit.get(context);
                        return state is LoadingAddCoach
                            ? const CircularProgressComponent()
                            : BottomComponent(
                                child: const Text(
                                  'Add New Coach',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.addCoach(
                                        image: ImageCubit.get(context).image,
                                        model: CoachModel(
                                          ban: false,
                                          email: emailController.text,
                                          id: null,
                                          image: null,
                                          name: nameController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                          age: agecontroller.text,
                                          gender: genderController.text,
                                          createdAt: DateTime.now().toString(),
                                          bio: bioController.text,
                                          gymId: AppPreferences.uId,
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
