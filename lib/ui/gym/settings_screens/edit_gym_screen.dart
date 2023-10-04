import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/app_validation.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/controller/gym/gym_cubit.dart';

import '../../../model/gym_model.dart';
import '../../auth/widgets/build_auth_bottom.dart';
import '../../componnents/app_textformfiled_widget.dart';
import '../../componnents/const_widget.dart';
import '../../componnents/image_picker/image_cubit/image_cubit.dart';
import '../../componnents/image_picker/image_widget.dart';
import '../../componnents/show_flutter_toast.dart';
import '../../componnents/widgets.dart';

class EditGymScreen extends StatefulWidget {
  const EditGymScreen({super.key});

  @override
  State<EditGymScreen> createState() => _EditGymScreenState();
}

class _EditGymScreenState extends State<EditGymScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController openDateController = TextEditingController();
  TextEditingController closeDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    GymCubit cubit = GymCubit.get(context);
    if (cubit.gymModel != null) {
      phoneController.text = cubit.gymModel!.phone ?? '';
      nameController.text = cubit.gymModel!.name ?? '';
      passwordController.text = cubit.gymModel!.password ?? '';
      openDateController.text = cubit.gymModel!.openDate ?? '';
      closeDateController.text = cubit.gymModel!.closeDate ?? '';
      descriptionController.text = cubit.gymModel!.description ?? '';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GymCubit cubit = GymCubit.get(context);
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
                    Align(
                        alignment: Alignment.center,
                        child: ImageWidget(
                          init: cubit.gymModel!.image,
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
                    timesRow(
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
                    BlocConsumer<GymCubit, GymState>(
                      listener: (context, state) {
                        if (state is ScEditGym) {
                          showFlutterToast(
                            message: "Gym Edited",
                            toastColor: Colors.green,
                          );
                          Navigator.pop(context, 'edit');
                        }
                        if (state is ErorrEditGym) {
                          showFlutterToast(
                            message: state.error,
                            toastColor: Colors.red,
                          );
                        }
                      },
                      builder: (context, state) {
                        GymCubit cubit = GymCubit.get(context);
                        return state is LoadingEditGym
                            ? const CircularProgressComponent()
                            : BottomComponent(
                                child: const Text(
                                  'Edit Gym',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  print("object1");
                                  if (_formKey.currentState!.validate()) {
                                    print("object2");
                                    cubit.editGym(
                                        image: ImageCubit.get(context).image,
                                        model: GymModel(
                                          closeDate: closeDateController.text,
                                          description:
                                              descriptionController.text,
                                          image: cubit.gymModel?.image,
                                          name: nameController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                          openDate: openDateController.text,
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
