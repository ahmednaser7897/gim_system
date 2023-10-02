import 'package:flutter/material.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/extensions.dart';

import '../../app/app_assets.dart';
import '../componnents/app_textformfiled_widget.dart';

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

  TextEditingController genderController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    genderController.text = 'male';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Gym'),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    hintText: "Enter your name",
                    prefix: Icons.person,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter your name";
                      }
                      return null;
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
                      if (value!.isEmpty) {
                        return "Please Enter Email";
                      }
                      return null;
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
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  AppSizedBox.h3,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              hintText: "Enter your phone",
                              prefix: Icons.call,
                              validate: (value) {
                                if (!startsWith05(value!)) {
                                  return 'Phone number must start with 05';
                                }
                                if (!contains8Digits(value)) {
                                  return 'Phone number must contain 8 digits';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      AppSizedBox.w5,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Gender",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            AppSizedBox.h2,
                            Container(
                              width: 40.w,
                              height: 6.5.h,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  hint: const Text(
                                    "Select status",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  value: genderController.text,
                                  onChanged: (value) {
                                    setState(() {
                                      genderController.text = value.toString();
                                    });
                                  },
                                  items: ['male', 'female'].map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  AppSizedBox.h3,
                  // BlocConsumer<AuthCubit, AuthState>(
                  //   listener: (context, state) {
                  //     if (state is AuthRegisterUserSuccessState) {
                  //       showFlutterToast(
                  //         message: "Register Success",
                  //         toastColor: Colors.green,
                  //       );
                  //       Navigator.pushNamedAndRemoveUntil(
                  //         context,
                  //         Routers.PARENTS_LAYOUT_SCREEN,
                  //         (route) => false,
                  //       );
                  //     }
                  //     if (state is AuthRegisterUserErrorState) {
                  //       showFlutterToast(
                  //         message: state.error,
                  //         toastColor: Colors.red,
                  //       );
                  //     }
                  //   },
                  //   builder: (context, state) {
                  //     AuthCubit authCubit = AuthCubit.get(context);
                  //     return state is AuthRegisterUserLoadingState
                  //         ? CircularProgressComponent()
                  //         : SaveChangesBottom(
                  //             textBottom: "Register",
                  //             onPressed: () {
                  //               if (_formKey.currentState!.validate()) {
                  //                 authCubit.registerUser(
                  //                   name: nameController.text,
                  //                   email: emailController.text,
                  //                   password: passwordController.text,
                  //                   gender: genderController.text,
                  //                   phone: phoneController.text,
                  //                 );
                  //               }
                  //             },
                  //           );
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool startsWith05(String number) {
    if (number.isEmpty) {
      return false;
    }
    return number.startsWith('05');
  }

  bool contains8Digits(String number) {
    if (number.isEmpty) {
      return false;
    }
    return RegExp(r'^\d{8}$').hasMatch(number.substring(2));
  }
}
