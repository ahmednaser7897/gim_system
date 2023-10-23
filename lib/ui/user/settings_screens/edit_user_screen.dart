import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/app_validation.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/controller/user/user_cubit.dart';

import '../../../app/app_prefs.dart';
import '../../../model/user_model.dart';
import '../../auth/widgets/build_auth_bottom.dart';
import '../../componnents/app_textformfiled_widget.dart';
import '../../componnents/const_widget.dart';
import '../../componnents/image_picker/image_cubit/image_cubit.dart';
import '../../componnents/image_picker/image_widget.dart';
import '../../componnents/show_flutter_toast.dart';
import '../../componnents/widgets.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({
    super.key,
  });

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController genderController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    var cubit = UserCubit.get(context);
    genderController.text = cubit.userModel!.gender ?? '';
    phoneController.text = cubit.userModel!.phone ?? '';
    nameController.text = cubit.userModel!.name ?? '';
    agecontroller.text = cubit.userModel!.age ?? '';
    passwordController.text = cubit.userModel!.password ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    return BlocProvider(
      create: (context) => ImageCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit User'),
        ),
        body: SingleChildScrollView(
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
                        init: cubit.userModel!.image,
                      )),
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
                    hintText: "Enter your name",
                    prefix: Icons.person,
                    validate: (value) {
                      return Validations.normalValidation(value,
                          name: 'your name');
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
                      return Validations.normalValidation(value,
                          name: 'your password');
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
                      return Validations.numberValidation(value,
                          name: 'Age', isInt: true);
                    },
                  ),
                  AppSizedBox.h3,
                  BlocConsumer<UserCubit, UserState>(
                    listener: (context, state) {
                      if (state is ScEditUser) {
                        showFlutterToast(
                          message: "User Edited",
                          toastColor: Colors.green,
                        );
                        Navigator.pop(context);
                      }
                      if (state is ErorrEditUser) {
                        showFlutterToast(
                          message: state.error,
                          toastColor: Colors.red,
                        );
                      }
                    },
                    builder: (context, state) {
                      UserCubit cubit = UserCubit.get(context);
                      return state is LoadingEditUser
                          ? const CircularProgressComponent()
                          : BottomComponent(
                              child: const Text(
                                'Edit User',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.editUser(
                                      image: ImageCubit.get(context).image,
                                      model: UserModel(
                                        name: nameController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                        age: agecontroller.text,
                                        gender: genderController.text,
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
    );
  }
}
