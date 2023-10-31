import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/app_validation.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/controller/user/user_cubit.dart';
import 'package:gim_system/ui/componnents/show_flutter_toast.dart';

import '../../../app/app_assets.dart';
import '../../../app/icon_broken.dart';
import '../../../controller/gym/gym_cubit.dart';
import '../../../model/coach_model.dart';
import '../../componnents/app_textformfiled_widget.dart';
import '../../componnents/const_widget.dart';
import '../../user/user_chat/user_message_coach_screen.dart';

class CoachDetailsScreen extends StatefulWidget {
  const CoachDetailsScreen(
      {super.key,
      required this.coachModel,
      this.canEdit = true,
      this.isUser = false});
  final CoachModel coachModel;
  final bool canEdit;
  final bool isUser;
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
            if (coachModel.ban.orFalse()) {
              showFlutterToast(
                message: "Coach is banned",
                toastColor: Colors.green,
              );
            } else {
              showFlutterToast(
                message: "Coach is unbanned",
                toastColor: Colors.green,
              );
            }
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
                  //if (coachModel.image != null && coachModel.image!.isNotEmpty)
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Hero(
                          tag: coachModel.id.orEmpty(),
                          child: CircleAvatar(
                            radius: 15.w,
                            backgroundImage: (coachModel.image != null &&
                                    coachModel.image!.isNotEmpty)
                                ? NetworkImage(coachModel.image.orEmpty())
                                : AssetImage(
                                    AppAssets.uoach,
                                  ) as ImageProvider,
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
                      return Validations.numberValidation(value,
                          name: 'Age', isInt: true);
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
      floatingActionButton: widget.isUser
          ? FloatingActionButton(
              onPressed: () {
                UserCubit.get(context).getMessages(
                  coachModel: coachModel,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserMessageCoachScreen(
                      coach: coachModel,
                    ),
                  ),
                );
              },
              backgroundColor: Colors.teal.withOpacity(0.8),
              child: const Icon(
                IconBroken.Chat,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
