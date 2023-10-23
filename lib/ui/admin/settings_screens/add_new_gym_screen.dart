import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/app_validation.dart';
import 'package:gim_system/app/extensions.dart';

import '../../../controller/admin/admin_cubit.dart';
import '../../../model/gym_model.dart';
import '../../auth/widgets/build_auth_bottom.dart';
import '../../componnents/app_textformfiled_widget.dart';
import '../../componnents/const_widget.dart';
import '../../componnents/image_picker/image_cubit/image_cubit.dart';
import '../../componnents/image_picker/image_widget.dart';
import '../../componnents/show_flutter_toast.dart';
import '../../componnents/widgets.dart';

class AddNewGymScreen extends StatefulWidget {
  const AddNewGymScreen({super.key});

  @override
  State<AddNewGymScreen> createState() => _AddNewGymScreenState();
}

class _AddNewGymScreenState extends State<AddNewGymScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  TextEditingController openDateController = TextEditingController();
  TextEditingController closeDateController = TextEditingController();

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
          title: const Text('Add New Gym'),
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
                      hintText: "Enter your password",
                      prefix: Icons.lock,
                      suffix: Icons.visibility,
                      isPassword: true,
                      validate: (value) {
                        return Validations.passwordValidation(value,
                            name: 'your password');
                        // if (value!.isEmpty) {
                        //   return 'Please enter a password';
                        // }
                        // return null;
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
                    TimesRow(
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
                      controller: descriptionController,
                      maxLines: 4,
                      keyboardType: TextInputType.text,
                      hintText: "Enter gym description",
                      validate: (value) {
                        return Validations.normalValidation(value,
                            name: 'your description');
                      },
                    ),
                    AppSizedBox.h3,
                    BlocConsumer<AdminCubit, AdminState>(
                      listener: (context, state) {
                        if (state is ScAddGym) {
                          showFlutterToast(
                            message: "gym added",
                            toastColor: Colors.green,
                          );
                          Navigator.pop(context);
                        }
                        if (state is ErorrAddGym) {
                          showFlutterToast(
                            message: state.error,
                            toastColor: Colors.red,
                          );
                        }
                      },
                      builder: (context, state) {
                        AdminCubit adminCubit = AdminCubit.get(context);
                        return state is LoadingAddGym
                            ? const CircularProgressComponent()
                            : BottomComponent(
                                child: const Text(
                                  'Add New Gym',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    emailController.text = emailController.text
                                        .replaceAll(' ', '')
                                        .toLowerCase();
                                    adminCubit.addGym(
                                        image: ImageCubit.get(context).image,
                                        gymModel: GymModel(
                                          ban: false,
                                          closeDate: closeDateController.text,
                                          coachs: null,
                                          description:
                                              descriptionController.text,
                                          email: emailController.text,
                                          id: null,
                                          image: null,
                                          name: nameController.text,
                                          openDate: openDateController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                          rate: 0,
                                          users: null,
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
