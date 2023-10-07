import 'package:flutter/material.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/app_validation.dart';
import 'package:gim_system/app/extensions.dart';

import '../../../model/user_model.dart';
import '../../componnents/app_textformfiled_widget.dart';

class ShowUserFitnessInfo extends StatefulWidget {
  const ShowUserFitnessInfo({
    super.key,
    required this.model,
  });
  final UserModel model;

  @override
  State<ShowUserFitnessInfo> createState() => _ShowUserFitnessInfoState();
}

class _ShowUserFitnessInfoState extends State<ShowUserFitnessInfo> {
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
