import 'package:flutter/material.dart';
import 'package:gim_system/app/app_colors.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/model/diets_model.dart';
import 'package:intl/intl.dart';

import '../../../app/app_sized_box.dart';
import '../../../app/app_validation.dart';
import '../../../model/user_model.dart';
import '../../componnents/app_textformfiled_widget.dart';

class ShowUserDites extends StatefulWidget {
  const ShowUserDites({super.key, required this.user});
  final UserModel user;

  @override
  State<ShowUserDites> createState() => _ShowUserDitesState();
}

class _ShowUserDitesState extends State<ShowUserDites> {
  late UserModel user;
  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Show User Dites'),
        ),
        body: ListView.separated(
            padding: EdgeInsets.all(5.w),
            itemBuilder: (context, index) =>
                userDitesWidget(user.dites.orEmpty()[index]),
            separatorBuilder: (context, index) => Column(
                  children: [
                    AppSizedBox.h1,
                    const Divider(
                      color: AppColors.black,
                      height: 2,
                    ),
                    AppSizedBox.h2,
                  ],
                ),
            itemCount: user.dites.orEmpty().length));
  }

  Widget userDitesWidget(DietModel model) {
    String date = DateFormat('yMMMMEEEEd')
        .format(DateTime.parse(model.createdAt.orEmpty()));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (model.coachModel != null)
              Text(
                model.coachModel!.name.orEmpty(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            Text(
              date,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        AppSizedBox.h1,
        const Text(
          "Break fast",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        AppSizedBox.h2,
        AppTextFormFiledWidget(
          controller: TextEditingController(text: model.breakfast),
          isEnable: false,
          keyboardType: TextInputType.text,
          hintText: "Enter Dite Break fast",
          prefix: Icons.food_bank,
          validate: (value) {
            return Validations.normalValidation(value, name: 'Break fast');
          },
        ),
        AppSizedBox.h3,
        const Text(
          "Dinner",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        AppSizedBox.h2,
        AppTextFormFiledWidget(
          controller: TextEditingController(text: model.dinner),
          isEnable: false,
          keyboardType: TextInputType.text,
          hintText: "Enter Dinner",
          prefix: Icons.food_bank,
          validate: (value) {
            return Validations.normalValidation(value, name: 'Dinner');
          },
        ),
        AppSizedBox.h3,
        const Text(
          "Lunch",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        AppSizedBox.h2,
        AppTextFormFiledWidget(
          controller: TextEditingController(text: model.lunch),
          isEnable: false,
          keyboardType: TextInputType.text,
          hintText: "Enter  Lunch",
          prefix: Icons.food_bank,
          validate: (value) {
            return Validations.normalValidation(value, name: 'Lunch');
          },
        ),
        AppSizedBox.h3,
        const Text(
          "Notes",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        AppSizedBox.h2,
        AppTextFormFiledWidget(
          maxLines: 3,
          controller: TextEditingController(text: model.notes),
          isEnable: false,
          keyboardType: TextInputType.emailAddress,
          hintText: "Enter Notes",
          validate: (value) {
            return Validations.normalValidation(value, name: 'Notes');
          },
        ),
      ],
    );
  }
}
