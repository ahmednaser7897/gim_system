import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/app_validation.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/controller/admin/admin_cubit.dart';
import 'package:gim_system/ui/componnents/const_widget.dart';

import '../../model/users_models.dart';
import '../componnents/app_textformfiled_widget.dart';
import '../componnents/widgets.dart';

class GymDetailsScreen extends StatefulWidget {
  const GymDetailsScreen({super.key, required this.gymModel});
  final GymModel gymModel;

  @override
  State<GymDetailsScreen> createState() => _GymDetailsScreenState();
}

class _GymDetailsScreenState extends State<GymDetailsScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  TextEditingController openDateController = TextEditingController();
  TextEditingController closeDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late GymModel gymModel;
  @override
  void initState() {
    gymModel = widget.gymModel;
    phoneController.text = gymModel.phone ?? '';
    emailController.text = gymModel.email ?? '';
    nameController.text = gymModel.name ?? '';
    passwordController.text = gymModel.password ?? '';
    closeDateController.text = gymModel.closeDate.orEmpty();
    openDateController.text = gymModel.openDate.orEmpty();
    descriptionController.text = gymModel.description.orEmpty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym Details'),
      ),
      body: BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is ScChangeGymBan) {
            setState(() {
              gymModel.ban = !gymModel.ban.orFalse();
            });
          }
        },
        builder: (context, state) => Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (gymModel.image != null && gymModel.image!.isNotEmpty)
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Hero(
                              tag: gymModel.email.orEmpty(),
                              child: CircleAvatar(
                                radius: 15.w,
                                backgroundImage:
                                    NetworkImage(gymModel.image.orEmpty()),
                              ),
                            ),
                            AppSizedBox.h2,
                            (state is LoadingChangeGymBan)
                                ? const CircularProgressComponent()
                                : Center(
                                    child: Switch(
                                      value: gymModel.ban.orFalse(),
                                      activeColor: Colors.red,
                                      splashRadius: 18.0,
                                      onChanged: (value) async {
                                        await AdminCubit.get(context)
                                            .changeGymBan(gymModel.id.orEmpty(),
                                                !gymModel.ban.orFalse());
                                      },
                                    ),
                                  ),
                          ],
                        ),
                      ),
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
                        return Validations.normalValidation(value,
                            name: 'your name');
                        // if (value!.isEmpty) {
                        //   return "Please Enter your name";
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
                      isEnable: false,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Enter your email",
                      prefix: Icons.email_rounded,
                      validate: (value) {
                        return Validations.emailValidation(value,
                            name: 'your email');
                        // if (value!.isEmpty) {
                        //   return "Please Enter Email";
                        // }
                        // return null;
                      },
                    ),
                    // AppSizedBox.h3,
                    // const Text(
                    //   "Password",
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                    // AppSizedBox.h2,
                    // AppTextFormFiledWidget(
                    //   controller: passwordController,
                    //   hintText: "Enter your password",
                    //   prefix: Icons.lock,
                    //   suffix: Icons.visibility,
                    //   isPassword: true,
                    //   validate: (value) {
                    //     return Validations.passwordValidation(value,
                    //         name: 'your password');
                    //     // if (value!.isEmpty) {
                    //     //   return 'Please enter a password';
                    //     // }
                    //     // return null;
                    //   },
                    // ),
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
                        return Validations.mobileValidation(value,
                            name: 'your phone');
                      },
                    ),
                    AppSizedBox.h3,
                    timesRow(
                        isEnable: false,
                        closeDateController: closeDateController,
                        openDateController: openDateController),
                    AppSizedBox.h3,
                    const Text(
                      "description",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    AppSizedBox.h2,
                    AppTextFormFiledWidget(
                      isEnable: false,
                      controller: descriptionController,
                      maxLines: 4,
                      keyboardType: TextInputType.text,
                      hintText: "Enter gym description",
                      validate: (value) {
                        return Validations.normalValidation(value,
                            name: 'your description');
                      },
                    ),
                    AppSizedBox.h1,
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
