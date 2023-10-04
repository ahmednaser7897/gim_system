import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_prefs.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/app_validation.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/controller/gym/gym_cubit.dart';

import '../../../model/users_models.dart';
import '../../auth/widgets/build_auth_bottom.dart';
import '../../componnents/app_textformfiled_widget.dart';
import '../../componnents/const_widget.dart';
import '../../componnents/image_picker/image_cubit/image_cubit.dart';
import '../../componnents/image_picker/image_widget.dart';
import '../../componnents/show_flutter_toast.dart';
import '../../componnents/widgets.dart';

class AddNewUserScreen extends StatefulWidget {
  const AddNewUserScreen({super.key});

  @override
  State<AddNewUserScreen> createState() => _AddNewUserScreenState();
}

class _AddNewUserScreenState extends State<AddNewUserScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController genderController = TextEditingController();

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController bodyFatPercentageController = TextEditingController();
  TextEditingController goalController = TextEditingController();
  TextEditingController fitnessLevelController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    genderController.text = 'male';
    goalController.text = 'Weight loss';
    fitnessLevelController.text = 'beginner';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add New User'),
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
                      hintText: "Enter User name",
                      prefix: Icons.person,
                      validate: (value) {
                        return Validations.normalValidation(value,
                            name: 'User name');
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
                      hintText: "Enter User email",
                      prefix: Icons.email_rounded,
                      validate: (value) {
                        return Validations.emailValidation(value,
                            name: 'User email');
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
                      hintText: "Enter User password",
                      prefix: Icons.lock,
                      suffix: Icons.visibility,
                      isPassword: true,
                      validate: (value) {
                        return Validations.passwordValidation(value,
                            name: 'User password');
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
                                hintText: "Enter User phone",
                                prefix: Icons.call,
                                validate: (value) {
                                  return Validations.mobileValidation(value,
                                      name: 'User phone');
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
                      "Age",
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
                      hintText: "Enter User age",
                      validate: (value) {
                        return Validations.normalValidation(value,
                            name: 'User age');
                      },
                    ),
                    AppSizedBox.h3,
                    const Text(
                      "Height",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    AppSizedBox.h2,
                    AppTextFormFiledWidget(
                      controller: heightController,
                      prefix: Icons.height,
                      keyboardType: TextInputType.number,
                      hintText: "Enter User height",
                      validate: (value) {
                        return Validations.normalValidation(value,
                            name: 'User height');
                      },
                    ),
                    AppSizedBox.h3,
                    const Text(
                      "Weight",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    AppSizedBox.h2,
                    AppTextFormFiledWidget(
                      controller: weightController,
                      prefix: Icons.monitor_weight_sharp,
                      keyboardType: TextInputType.number,
                      hintText: "Enter User weight",
                      validate: (value) {
                        return Validations.normalValidation(value,
                            name: 'User weight');
                      },
                    ),
                    AppSizedBox.h3,
                    const Text(
                      "Body Fat Percentage",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    AppSizedBox.h2,
                    AppTextFormFiledWidget(
                      controller: bodyFatPercentageController,
                      prefix: Icons.percent,
                      keyboardType: TextInputType.number,
                      hintText: "Enter User body Fat Percentage",
                      validate: (value) {
                        return Validations.normalValidation(value,
                            name: 'User body Fat Percentage');
                      },
                    ),
                    AppSizedBox.h3,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                "Goal",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              AppSizedBox.h2,
                              userGoalWidget(goalController)
                            ],
                          ),
                        ),
                        AppSizedBox.w5,
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                "Fitness Level",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              AppSizedBox.h2,
                              fitnessLevelWidget(fitnessLevelController),
                            ],
                          ),
                        ),
                      ],
                    ),
                    AppSizedBox.h3,
                    BlocConsumer<GymCubit, GymState>(
                      listener: (context, state) {
                        if (state is ScAddUser) {
                          showFlutterToast(
                            message: "User added",
                            toastColor: Colors.green,
                          );
                          Navigator.pop(context);
                        }
                        if (state is ErorrAddUser) {
                          showFlutterToast(
                            message: state.error,
                            toastColor: Colors.red,
                          );
                        }
                      },
                      builder: (context, state) {
                        GymCubit cubit = GymCubit.get(context);
                        return state is LoadingAddUser
                            ? const CircularProgressComponent()
                            : BottomComponent(
                                child: const Text(
                                  'Add New User',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.addUser(
                                        image: ImageCubit.get(context).image,
                                        model: UserModel(
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
                                          gymId: AppPreferences.uId,
                                          bodyFatPercentage:
                                              bodyFatPercentageController.text,
                                          height: heightController.text,
                                          goal: genderController.text,
                                          fitnesLevel:
                                              fitnessLevelController.text,
                                          weight: weightController.text,
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
