import 'package:flutter/material.dart';
import 'package:gim_system/app/extensions.dart';

import '../../app/app_colors.dart';
import '../../app/app_sized_box.dart';
import '../../app/app_validation.dart';
import 'app_textformfiled_widget.dart';

Widget timesRow({
  required TextEditingController openDateController,
  required TextEditingController closeDateController,
  bool isEnable = true,
}) {
  TimeOfDay open = TimeOfDay.now();
  TimeOfDay close = TimeOfDay.now();

  return Builder(builder: (context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Open Time",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              AppSizedBox.h2,
              InkWell(
                onTap: isEnable
                    ? () async {
                        TimeOfDay? value = await showPicker(context);

                        if (value != null) {
                          open = value;
                          openDateController.text = open.format(context);
                        }
                      }
                    : null,
                child: AppTextFormFiledWidget(
                  isEnable: false,
                  controller: openDateController,
                  keyboardType: TextInputType.text,
                  hintText: "Enter open Time",
                  prefix: Icons.date_range,
                  validate: (value) {
                    return Validations.normalValidation(value,
                        name: 'your open time');
                  },
                ),
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
                "Close Time",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              AppSizedBox.h2,
              InkWell(
                onTap: isEnable
                    ? () async {
                        TimeOfDay? value = await showPicker(context);
                        if (value != null) {
                          close = value;
                          closeDateController.text = close.format(context);
                        }
                      }
                    : null,
                child: AppTextFormFiledWidget(
                  isEnable: false,
                  controller: closeDateController,
                  keyboardType: TextInputType.text,
                  hintText: "Enter close Time",
                  prefix: Icons.date_range,
                  validate: (value) {
                    // print('object33');
                    // print(open.isAfter(close));
                    // if ((open.isAfter(close) ?? false)) {
                    //   print('object33');
                    //   print(open.isAfter(close));
                    //   return 'open time must be befor close tome';
                    // }
                    return Validations.normalValidation(value,
                        name: 'your close time');
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  });
}

extension TimeOfDayExtension on TimeOfDay {
  bool? isAfter(TimeOfDay other) {
    if (hour < other.hour) return false;
    if (hour > other.hour) return true;
    if (minute < other.minute) return false;
    if (minute > other.minute) return true;
    return null;
  }
}

Widget genderWidget(TextEditingController genderController,
    {String init = 'male'}) {
  var list = ['male', 'female'];
  if (init == 'female') {
    list = ['female', 'male'];
  }
  return StatefulBuilder(builder: (context, setState) {
    return Container(
      width: 40.w,
      height: 6.5.h,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
          items: list.map((value) {
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
    );
  });
}

Widget userGoalWidget(TextEditingController golaController,
    {String init = 'Weight loss'}) {
  // var list = ['male', 'female'];
  // if (init == 'female') {
  //   list = ['female', 'male'];
  // }
  var list = ['Weight loss', 'Get muscles', 'both of them'];
  return StatefulBuilder(builder: (context, setState) {
    return Container(
      width: 40.w,
      height: 6.5.h,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
            "Select goal",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          value: golaController.text,
          onChanged: (value) {
            setState(() {
              golaController.text = value.toString();
            });
          },
          items: list.map((value) {
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
    );
  });
}

Widget fitnessLevelWidget(TextEditingController golaController,
    {String init = 'beginner'}) {
  // var list = ['male', 'female'];
  // if (init == 'female') {
  //   list = ['female', 'male'];
  // }
  var list = ['beginner', 'intermediate', 'advanced'];
  return StatefulBuilder(builder: (context, setState) {
    return Container(
      width: 40.w,
      height: 6.5.h,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
            "Select goal",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          value: golaController.text,
          onChanged: (value) {
            setState(() {
              golaController.text = value.toString();
            });
          },
          items: list.map((value) {
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
    );
  });
}

Future<TimeOfDay?> showPicker(BuildContext context) async {
  TimeOfDay? pickedDate = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primerColor,
            onPrimary: Colors.white,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primerColor,
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  if (pickedDate != null) {
    return pickedDate;
  } else {
    return null;
  }
}

// var a = Expanded(
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         "Gender",
//         style: TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w400,
//         ),
//       ),
//       AppSizedBox.h2,
//       genderWidget(genderController),
//     ],
//   ),
// );
