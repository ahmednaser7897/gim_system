import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_colors.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/model/diets_model.dart';
import 'package:gim_system/ui/coach/users/add_new_dite.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/app_sized_box.dart';
import '../../../app/fuctions.dart';
import '../../../controller/coach/coach_cubit.dart';
import '../../../model/user_model.dart';

class ShowUserDites extends StatefulWidget {
  const ShowUserDites({super.key, required this.user, this.canAdd = false});
  final UserModel user;
  final bool canAdd;

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
          actions: [
            if (widget.canAdd)
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNewDiteScreen(
                          user: user,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add))
          ],
        ),
        body: BlocConsumer<CoachCubit, CoachState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ListView.separated(
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
                itemCount: user.dites.orEmpty().length);
          },
        ));
  }

  // Widget userDitesWidget(DietModel model) {
  //   String date = DateFormat('yMMMMEEEEd')
  //       .format(DateTime.parse(model.createdAt.orEmpty()));
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           if (model.coachModel != null)
  //             Text(
  //               model.coachModel!.name.orEmpty(),
  //               style: const TextStyle(
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w900,
  //               ),
  //             ),
  //           Text(
  //             date,
  //             style: const TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.w900,
  //             ),
  //           ),
  //         ],
  //       ),
  //       AppSizedBox.h1,
  //       const Text(
  //         "Break fast",
  //         style: TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.w400,
  //         ),
  //       ),
  //       AppSizedBox.h2,
  //       AppTextFormFiledWidget(
  //         controller: TextEditingController(text: model.breakfast),
  //         isEnable: false,
  //         keyboardType: TextInputType.text,
  //         hintText: "Enter Dite Break fast",
  //         prefix: Icons.food_bank,
  //         validate: (value) {
  //           return Validations.normalValidation(value, name: 'Break fast');
  //         },
  //       ),
  //       AppSizedBox.h3,
  //       const Text(
  //         "Dinner",
  //         style: TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.w400,
  //         ),
  //       ),
  //       AppSizedBox.h2,
  //       AppTextFormFiledWidget(
  //         controller: TextEditingController(text: model.dinner),
  //         isEnable: false,
  //         keyboardType: TextInputType.text,
  //         hintText: "Enter Dinner",
  //         prefix: Icons.food_bank,
  //         validate: (value) {
  //           return Validations.normalValidation(value, name: 'Dinner');
  //         },
  //       ),
  //       AppSizedBox.h3,
  //       const Text(
  //         "Lunch",
  //         style: TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.w400,
  //         ),
  //       ),
  //       AppSizedBox.h2,
  //       AppTextFormFiledWidget(
  //         controller: TextEditingController(text: model.lunch),
  //         isEnable: false,
  //         keyboardType: TextInputType.text,
  //         hintText: "Enter  Lunch",
  //         prefix: Icons.food_bank,
  //         validate: (value) {
  //           return Validations.normalValidation(value, name: 'Lunch');
  //         },
  //       ),
  //       AppSizedBox.h3,
  //       const Text(
  //         "Notes",
  //         style: TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.w400,
  //         ),
  //       ),
  //       AppSizedBox.h2,
  //       AppTextFormFiledWidget(
  //         maxLines: 3,
  //         controller: TextEditingController(text: model.notes),
  //         isEnable: false,
  //         keyboardType: TextInputType.emailAddress,
  //         hintText: "Enter Notes",
  //         validate: (value) {
  //           return Validations.normalValidation(value, name: 'Notes');
  //         },
  //       ),
  //     ],
  //   );
  // }

  Widget userDitesWidget(DietModel model) {
    return Builder(builder: (context) {
      return FadeInUp(
        from: 20,
        delay: const Duration(milliseconds: 400),
        duration: const Duration(milliseconds: 500),
        child: Container(
          width: 100.w,
          margin: const EdgeInsets.symmetric(
            vertical: 5,
          ),
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizedBox.w3,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Coach : ${model.coachModel!.name.orEmpty()}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.almarai(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    AppSizedBox.w1,
                    Text(
                      getDate(model.createdAt.orEmpty()),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.almarai(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                AppSizedBox.h1,
                Text(
                  "Break fast : ${model.breakfast.orEmpty()}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.almarai(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppSizedBox.h1,
                Text(
                  "Dinner : ${model.dinner.orEmpty()}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.almarai(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppSizedBox.h1,
                Text(
                  "Lunch : ${model.lunch.orEmpty()}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.almarai(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppSizedBox.h1,
                Text(
                  "Notes : ${model.notes.orEmpty()}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.almarai(
                    color: Colors.black45,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
