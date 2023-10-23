import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/app_validation.dart';
import 'package:gim_system/app/extensions.dart';

import '../../../controller/coach/coach_cubit.dart';
import '../../../model/user_model.dart';
import '../../auth/widgets/build_auth_bottom.dart';
import '../../componnents/app_textformfiled_widget.dart';
import '../../componnents/const_widget.dart';
import '../../componnents/show_flutter_toast.dart';
import '../../componnents/widgets.dart';

class UpdateUserFitnessInfo extends StatefulWidget {
  const UpdateUserFitnessInfo({
    super.key,
    required this.model,
  });
  final UserModel model;

  @override
  State<UpdateUserFitnessInfo> createState() => _UpdateUserFitnessInfoState();
}

class _UpdateUserFitnessInfoState extends State<UpdateUserFitnessInfo> {
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizedBox.h1,
                userData(),
                AppSizedBox.h2,
                BlocConsumer<CoachCubit, CoachState>(
                  listener: (context, state) {
                    if (state is ScUpdateUserFitnessInfo) {
                      showFlutterToast(
                        message: "Fitness Info added",
                        toastColor: Colors.green,
                      );
                      Navigator.pop(context);
                    }
                    if (state is ErorrUpdateUserFitnessInfo) {
                      showFlutterToast(
                        message: state.error,
                        toastColor: Colors.red,
                      );
                    }
                  },
                  builder: (context, state) {
                    CoachCubit cubit = CoachCubit.get(context);
                    return state is LoadingUpdateUserFitnessInfo
                        ? const CircularProgressComponent()
                        : BottomComponent(
                            child: const Text(
                              'update user Fitness Info',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.updateUserFitnessInfo(
                                    oldModel: model,
                                    newModel: UserModel(
                                        id: model.id,
                                        height: heightController.text,
                                        weight: weightController.text,
                                        fitnesLevel:
                                            fitnessLevelController.text,
                                        bodyFatPercentage:
                                            bodyFatPercentageController.text,
                                        goal: goalController.text));
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
    );
  }

  Column userData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }
}
