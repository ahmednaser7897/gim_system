import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/app_colors.dart';
import '../../app/app_sized_box.dart';
import '../../app/app_validation.dart';
import 'app_textformfiled_widget.dart';
import 'show_flutter_toast.dart';

class TimesRow extends StatefulWidget {
  const TimesRow(
      {super.key,
      required this.openDateController,
      required this.closeDateController,
      this.isEnable = true});
  final TextEditingController openDateController;
  final TextEditingController closeDateController;
  final bool isEnable;

  @override
  State<TimesRow> createState() => _TimesRowState();
}

class _TimesRowState extends State<TimesRow> {
  late TextEditingController openDateController;
  late TextEditingController closeDateController;
  late bool isEnable;
  TimeOfDay open = TimeOfDay.now();
  TimeOfDay close = TimeOfDay.now();
  @override
  void initState() {
    openDateController = widget.openDateController;
    closeDateController = widget.closeDateController;
    isEnable = widget.isEnable;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          print('open');
                          print(open);
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
                          print('close');
                          print(close);
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
                    print('object33');
                    print(open);
                    print(close);
                    double openVal = toDouble(open);
                    double closeVal = toDouble(close);
                    if (openVal > closeVal) {
                      print('open time must be befor close tome');
                      showFlutterToast(
                        message: 'open time must be befor close time',
                        toastColor: Colors.red,
                      );
                      return 'open time must be befor close time';
                    }
                    print('object44');
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Widget timesRow({
//   required TextEditingController openDateController,
//   required TextEditingController closeDateController,
//   bool isEnable = true,
// }) {
//   TimeOfDay open = TimeOfDay.now();
//   TimeOfDay close = TimeOfDay.now();

//   return Builder(builder: (context) {
//     return
//     Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Open Time",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               AppSizedBox.h2,
//               InkWell(
//                 onTap: isEnable
//                     ? () async {
//                         TimeOfDay? value = await showPicker(context);
//                         if (value != null) {
//                           open = value;
//                           print('open');
//                           print(open);
//                           openDateController.text = open.format(context);
//                         }
//                       }
//                     : null,
//                 child: AppTextFormFiledWidget(
//                   isEnable: false,
//                   controller: openDateController,
//                   keyboardType: TextInputType.text,
//                   hintText: "Enter open Time",
//                   prefix: Icons.date_range,
//                   validate: (value) {
//                     return Validations.normalValidation(value,
//                         name: 'your open time');
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         AppSizedBox.w5,
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Close Time",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               AppSizedBox.h2,
//               InkWell(
//                 onTap: isEnable
//                     ? () async {
//                         TimeOfDay? value = await showPicker(context);
//                         if (value != null) {
//                           close = value;
//                           print('close');
//                           print(close);
//                           closeDateController.text = close.format(context);
//                         }
//                       }
//                     : null,
//                 child: AppTextFormFiledWidget(
//                   isEnable: false,
//                   controller: closeDateController,
//                   keyboardType: TextInputType.text,
//                   hintText: "Enter close Time",
//                   prefix: Icons.date_range,
//                   validate: (value) {
//                     print('object33');
//                     print(open);
//                     print(close);
//                     double openVal = toDouble(open);
//                     double closeVal = toDouble(close);
//                     if (openVal == closeVal) {
//                       print('open time must be befor close tome');
//                       return Validations.normalValidation(value,
//                           name: 'your close time');
//                     }
//                     print('object44');
//                     return null;
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );

//   });
// }

double toDouble(TimeOfDay timeOfDay) {
  print('time');
  print(timeOfDay);
  return timeOfDay.hour + timeOfDay.minute / 60.0;
}
// extension TimeOfDayExtension on TimeOfDay {
//   bool? isAfter(TimeOfDay other) {
//     if (hour < other.hour) return false;
//     if (hour > other.hour) return true;
//     if (minute < other.minute) return false;
//     if (minute > other.minute) return true;
//     return null;
//   }
// }

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

var goals = ['Weight loss', 'Get muscles', 'both of them'];
Widget userGoalWidget(TextEditingController golaController,
    {String init = 'Weight loss'}) {
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
          items: goals.map((value) {
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

Widget settingbuildListItem(BuildContext context,
    {required String title,
    required IconData leadingIcon,
    IconData? tailIcon,
    String? subtitle,
    Function()? onTap}) {
  return ListTile(
    onTap: onTap,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    dense: true,
    splashColor: AppColors.primerColor.withOpacity(0.2),
    style: ListTileStyle.list,
    leading: Icon(
      leadingIcon,
      color: AppColors.primerColor,
    ),
    title: Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge,
    ),
    subtitle: Text(subtitle ?? ''),
    trailing: Icon(tailIcon),
  );
}

Widget buildHomeItem(
    {required Function ontap,
    required String? image,
    required String assetImage,
    required String name,
    required bool ban,
    required String des,
    required String id,
    IconData icon = Icons.info_outline,
    bool showOnly = false}) {
  return Builder(builder: (context) {
    return FadeInUp(
      from: 20,
      delay: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 500),
      child: Container(
        width: 100.w,
        height: 16.h,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              width: 100.w,
              height: 15.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: id,
                      child: CircleAvatar(
                        radius: 33,
                        backgroundImage: (image != null && image.isNotEmpty)
                            ? NetworkImage(image.orEmpty())
                            : AssetImage(
                                assetImage,
                              ) as ImageProvider,
                      ),
                    ),
                    AppSizedBox.w3,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name.orEmpty(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.almarai(
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          AppSizedBox.h2,
                          Text(
                            des.orEmpty(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.almarai(
                              color: Colors.black45,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          AppSizedBox.h1,
                          Text(
                            ban.orFalse() ? 'Banned' : '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.almarai(
                              color: ban.orFalse() ? Colors.red : Colors.green,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSizedBox.w5,
                    InkWell(
                      onTap: () {
                        ontap();
                      },
                      child: Container(
                        width: 14.w,
                        height: 6.5.h,
                        decoration: BoxDecoration(
                          color: Colors.teal.shade300,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Icon(
                          icon,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  });
}
