import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/app_validation.dart';
import 'package:gim_system/app/extensions.dart';

import '../../../controller/gym/gym_cubit.dart';
import '../../../model/coach_model.dart';
import '../../componnents/app_textformfiled_widget.dart';
import '../../componnents/const_widget.dart';

class CoachDetailsScreen extends StatefulWidget {
  const CoachDetailsScreen(
      {super.key, required this.coachModel, this.canEdit = true});
  final CoachModel coachModel;
  final bool canEdit;
  @override
  State<CoachDetailsScreen> createState() => _CoachDetailsScreenState();
}

class _CoachDetailsScreenState extends State<CoachDetailsScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late CoachModel coachModel;
  @override
  void initState() {
    coachModel = widget.coachModel;
    genderController.text = coachModel.gender ?? 'male';
    phoneController.text = coachModel.phone ?? '';
    emailController.text = coachModel.email ?? '';
    nameController.text = coachModel.name ?? '';
    agecontroller.text = coachModel.age ?? '';
    bioController.text = coachModel.bio ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coach Details'),
      ),
      body: BlocConsumer<GymCubit, GymState>(
        listener: (context, state) {
          if (state is ScChangeCoachBan) {
            setState(() {
              coachModel.ban = !coachModel.ban.orFalse();
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
                  if (coachModel.image != null && coachModel.image!.isNotEmpty)
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Hero(
                            tag: coachModel.email.orEmpty(),
                            child: CircleAvatar(
                              radius: 15.w,
                              backgroundImage:
                                  NetworkImage(coachModel.image.orEmpty()),
                            ),
                          ),
                          if (widget.canEdit) AppSizedBox.h2,
                          if (widget.canEdit)
                            (state is LoadingChangeCoachBan)
                                ? const CircularProgressComponent()
                                : Center(
                                    child: Switch(
                                      value: coachModel.ban.orFalse(),
                                      activeColor: Colors.red,
                                      splashRadius: 18.0,
                                      onChanged: (value) async {
                                        await GymCubit.get(context)
                                            .changeCoachBan(
                                                coachModel.id.orEmpty(),
                                                !coachModel.ban.orFalse());
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
                    hintText: "Enter Coach age",
                    validate: (value) {
                      return Validations.normalValidation(value,
                          name: 'your age');
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
                    isEnable: false,
                    controller: bioController,
                    maxLines: 4,
                    keyboardType: TextInputType.text,
                    hintText: "Enter coach bio",
                    validate: (value) {
                      return Validations.normalValidation(value,
                          name: 'coach bio');
                    },
                  ),
                  AppSizedBox.h2,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
