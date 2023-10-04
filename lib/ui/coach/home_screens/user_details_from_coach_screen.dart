import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/app_validation.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/controller/gym/gym_cubit.dart';
import 'package:gim_system/ui/coach/home_screens/add_new_dite.dart';
import 'package:gim_system/ui/componnents/custom_button.dart';

import '../../../model/user_model.dart';
import '../../componnents/app_textformfiled_widget.dart';
import 'add_new_user_exercises.dart';

class UserDetailsFromCoachScreen extends StatefulWidget {
  const UserDetailsFromCoachScreen({
    super.key,
    required this.model,
  });
  final UserModel model;

  @override
  State<UserDetailsFromCoachScreen> createState() =>
      _UserDetailsFromCoachScreenState();
}

class _UserDetailsFromCoachScreenState
    extends State<UserDetailsFromCoachScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController genderController = TextEditingController();

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController bodyFatPercentageController = TextEditingController();
  TextEditingController goalController = TextEditingController();
  TextEditingController fitnessLevelController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late UserModel model;
  @override
  void initState() {
    model = widget.model;
    genderController.text = model.gender ?? 'male';
    phoneController.text = model.phone ?? '';
    emailController.text = model.email ?? '';
    nameController.text = model.name ?? '';
    agecontroller.text = model.age ?? '';

    weightController.text = model.weight ?? '';
    heightController.text = model.height ?? '';
    bodyFatPercentageController.text = model.bodyFatPercentage ?? '';
    goalController.text = model.goal ?? '';
    fitnessLevelController.text = model.fitnesLevel ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: BlocConsumer<GymCubit, GymState>(
        listener: (context, state) {
          if (state is ScChangeUserBan) {
            setState(() {
              model.ban = !model.ban.orFalse();
            });
          }
        },
        builder: (context, state) => SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSizedBox.h1,
                  if (model.image != null && model.image!.isNotEmpty)
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Hero(
                            tag: model.email.orEmpty(),
                            child: CircleAvatar(
                              radius: 15.w,
                              backgroundImage:
                                  NetworkImage(model.image.orEmpty()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  AppSizedBox.h1,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                        text: 'Add Dite',
                        width: 40,
                        fontsize: 12,
                        iconRight: const Icon(Icons.add),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddNewDiteScreen(
                                user: model,
                              ),
                            ),
                          );
                        },
                      ),
                      CustomButton(
                        text: 'Add Exercises',
                        width: 40,
                        fontsize: 12,
                        iconRight: const Icon(Icons.add),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddNewUserExercisesScreen(
                                user: model,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  AppSizedBox.h2,
                  userData(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column userData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Name",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        AppSizedBox.h2,
        AppTextFormFiledWidget(
          isEnable: false,
          controller: nameController,
          keyboardType: TextInputType.text,
          hintText: "Enter your name",
          prefix: Icons.person,
          validate: (value) {
            return Validations.normalValidation(value, name: 'your name');
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
          isEnable: false,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          hintText: "Enter your email",
          prefix: Icons.email_rounded,
          validate: (value) {
            return Validations.emailValidation(value, name: 'your email');
          },
        ),
        AppSizedBox.h3,
        const Text(
          "Phone",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        AppSizedBox.h2,
        AppTextFormFiledWidget(
          isEnable: false,
          keyboardType: TextInputType.phone,
          controller: phoneController,
          hintText: "Enter your phone",
          prefix: Icons.call,
          validate: (value) {
            return Validations.mobileValidation(value, name: 'your phone');
          },
        ),
        AppSizedBox.h3,
        const Text(
          "Gender",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        AppSizedBox.h2,
        AppTextFormFiledWidget(
          isEnable: false,
          keyboardType: TextInputType.phone,
          controller: genderController,
          hintText: "Enter your phone",
          prefix: Icons.person,
          validate: (value) {
            return Validations.mobileValidation(value, name: 'your phone');
          },
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
          isEnable: false,
          controller: agecontroller,
          prefix: Icons.timelapse,
          keyboardType: TextInputType.number,
          hintText: "Enter User age",
          validate: (value) {
            return Validations.normalValidation(value, name: 'your age');
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
          isEnable: false,
          controller: heightController,
          prefix: Icons.height,
          keyboardType: TextInputType.number,
          hintText: "Enter User height",
          validate: (value) {
            return Validations.normalValidation(value, name: 'User height');
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
          isEnable: false,
          controller: weightController,
          prefix: Icons.monitor_weight_sharp,
          keyboardType: TextInputType.number,
          hintText: "Enter User weight",
          validate: (value) {
            return Validations.normalValidation(value, name: 'User weight');
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
          isEnable: false,
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
        const Text(
          "Goal",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        AppSizedBox.h2,
        AppTextFormFiledWidget(
          isEnable: false,
          controller: goalController,
          prefix: Icons.star,
          keyboardType: TextInputType.number,
          hintText: "Enter User goal",
          validate: (value) {
            return Validations.normalValidation(value, name: 'User goal');
          },
        ),
        AppSizedBox.h3,
        const Text(
          "Fitness Level",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        AppSizedBox.h2,
        AppTextFormFiledWidget(
          isEnable: false,
          controller: fitnessLevelController,
          prefix: Icons.percent,
          keyboardType: TextInputType.number,
          hintText: "Enter User Fitness Level",
          validate: (value) {
            return Validations.normalValidation(value,
                name: 'User Fitness Level');
          },
        ),
        AppSizedBox.h3,
      ],
    );
  }
}
