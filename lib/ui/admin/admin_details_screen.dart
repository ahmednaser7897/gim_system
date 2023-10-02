import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/app_validation.dart';
import 'package:gim_system/app/extensions.dart';

import '../../controller/admin/admin_cubit.dart';
import '../../model/users_models.dart';
import '../componnents/app_textformfiled_widget.dart';
import '../componnents/const_widget.dart';

class AdminDetailsScreen extends StatefulWidget {
  const AdminDetailsScreen({super.key, required this.adminModel});
  final AdminModel adminModel;
  @override
  State<AdminDetailsScreen> createState() => _AdminDetailsScreenState();
}

class _AdminDetailsScreenState extends State<AdminDetailsScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController agecontroller = TextEditingController();

  TextEditingController genderController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late AdminModel adminModel;
  @override
  void initState() {
    adminModel = widget.adminModel;

    genderController.text = adminModel.gender ?? 'male';
    phoneController.text = adminModel.phone ?? '';
    emailController.text = adminModel.email ?? '';
    nameController.text = adminModel.name ?? '';
    //passwordController.text = adminModel.password ?? '';
    agecontroller.text = adminModel.age ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Details'),
      ),
      body: BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is ScChangeAdminBan) {
            setState(() {
              adminModel.ban = !adminModel.ban.orFalse();
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
                  if (adminModel.image != null && adminModel.image!.isNotEmpty)
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Hero(
                            tag: adminModel.email.orEmpty(),
                            child: CircleAvatar(
                              radius: 15.w,
                              backgroundImage:
                                  NetworkImage(adminModel.image.orEmpty()),
                            ),
                          ),
                          AppSizedBox.h2,
                          (state is LoadingChangeAdminBan)
                              ? const CircularProgressComponent()
                              : Center(
                                  child: Switch(
                                    value: adminModel.ban.orFalse(),
                                    activeColor: Colors.red,
                                    splashRadius: 18.0,
                                    onChanged: (value) async {
                                      await AdminCubit.get(context)
                                          .changeAdminBan(
                                              adminModel.id.orEmpty(),
                                              !adminModel.ban.orFalse());
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
                      return Validations.mobileValidation(value,
                          name: 'your phone');
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
                      return Validations.mobileValidation(value,
                          name: 'your phone');
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
                    hintText: "Enter Admin age",
                    validate: (value) {
                      return Validations.normalValidation(value,
                          name: 'your age');
                    },
                  ),
                  AppSizedBox.h3,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
