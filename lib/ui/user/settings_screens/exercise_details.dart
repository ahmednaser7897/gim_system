import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_sized_box.dart';
import '../../../app/fuctions.dart';
import '../../../app/luanch_url.dart';
import '../../../controller/user/user_cubit.dart';
import '../../../model/exercises_model.dart';
import '../../componnents/const_widget.dart';
import '../../componnents/custom_button.dart';
import '../../componnents/show_flutter_toast.dart';

class ExerciseDetails extends StatefulWidget {
  const ExerciseDetails(
      {super.key, required this.canEdit, required this.model});
  final bool canEdit;
  final UserExercises model;
  @override
  State<ExerciseDetails> createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Show Exercises Details'),
        ),
        body: ListView.separated(
            padding: EdgeInsets.all(5.w),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return eserciseItem(
                  widget.model.exercises.orEmpty()[index], widget.model, index);
            },
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
            itemCount: widget.model.exercises.orEmpty().length));
  }

  // Widget eserciseItem(Exercise model, UserExercises userExercises, int index) {
  //   return Builder(builder: (context) {
  //     bool isToday = false;
  //     if (DateTime.tryParse(userExercises.date.orEmpty()) != null) {
  //       if (DateTime.parse(userExercises.date.orEmpty())
  //               .difference(DateTime.now())
  //               .inDays ==
  //           0) {
  //         isToday = true;
  //       }
  //     }
  //     return InkWell(
  //       onTap: () {
  //         // Clipboard.setData(
  //         //     ClipboardData(text: model.exerciseModel!.videoLink.orEmpty()));
  //         // showFlutterToast(
  //         //   message: "Video link copied",
  //         //   toastColor: Colors.green,
  //         // );
  //       },
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           if (model.exerciseModel != null)
  //             Text(
  //               "Exercise name : ${model.exerciseModel!.name.orEmpty()}",
  //               style: const TextStyle(
  //                 fontSize: 16,
  //                 color: AppColors.grey,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //           AppSizedBox.h1,
  //           const Text(
  //             'Count :',
  //             style: TextStyle(
  //               fontSize: 14,
  //               color: AppColors.grey,
  //               fontWeight: FontWeight.w400,
  //             ),
  //           ),
  //           AppSizedBox.h1,
  //           AppTextFormFiledWidget(
  //             controller: TextEditingController(text: model.count.toString()),
  //             isEnable: false,
  //             keyboardType: TextInputType.number,
  //             hintText: "Enter Exercises count",
  //             prefix: Icons.numbers,
  //             validate: (value) {
  //               return Validations.normalValidation(value, name: 'count');
  //             },
  //           ),
  //           AppSizedBox.h1,
  //           const Text(
  //             'Total :',
  //             style: TextStyle(
  //               fontSize: 14,
  //               color: AppColors.grey,
  //               fontWeight: FontWeight.w400,
  //             ),
  //           ),
  //           AppSizedBox.h1,
  //           AppTextFormFiledWidget(
  //             controller: TextEditingController(text: model.total.toString()),
  //             isEnable: false,
  //             keyboardType: TextInputType.number,
  //             hintText: "Enter Exercises total",
  //             prefix: Icons.numbers,
  //             validate: (value) {
  //               return Validations.normalValidation(value, name: 'total');
  //             },
  //           ),
  //           AppSizedBox.h1,
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 "sub exercise Status : ${model.done.orFalse() ? "finished" : "not finish"}",
  //                 style: const TextStyle(
  //                   fontSize: 14,
  //                   color: AppColors.grey,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //               if (widget.canEdit && isToday && !(model.done ?? false))
  //                 BlocConsumer<UserCubit, UserState>(
  //                   listener: (context, state) {
  //                     if (state is ScSetExerciseAsRead) {
  //                       showFlutterToast(
  //                         message: "Sub Exercise Set As Done",
  //                         toastColor: Colors.green,
  //                       );
  //                     }
  //                     if (state is ScSetAllExerciseAsRead) {
  //                       showFlutterToast(
  //                         message: "All Exercise Set As Done",
  //                         toastColor: Colors.green,
  //                       );
  //                     }
  //                     if (state is ErorrSetExerciseAsRead) {
  //                       showFlutterToast(
  //                         message: state.error,
  //                         toastColor: Colors.red,
  //                       );
  //                     }
  //                   },
  //                   builder: (context, state) {
  //                     UserCubit cubit = UserCubit.get(context);
  //                     return state is LoadingSetExerciseAsRead &&
  //                             state.id ==
  //                                 userExercises.id.orEmpty() + index.toString()
  //                         ? const CircularProgressComponent()
  //                         : SizedBox(
  //                             width: 30.w,
  //                             height: 6.h,
  //                             child: CustomButton(
  //                               onTap: () {
  //                                 cubit.setExerciseAsDone(
  //                                     userExercises: userExercises,
  //                                     index: index);
  //                               },
  //                               fontsize: 10,
  //                               text: 'set as finished',
  //                             ),
  //                           );
  //                   },
  //                 ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  // }

  Widget eserciseItem(Exercise model, UserExercises userExercises, int index) {
    bool isToday = false;
    if (DateTime.tryParse(userExercises.date.orEmpty()) != null) {
      if (DateTime.parse(userExercises.date.orEmpty())
              .difference(DateTime.now())
              .inDays ==
          0) {
        isToday = true;
      }
    }
    return BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          return InkWell(
            onTap: () {
              launchURLFunction(model.exerciseModel!.videoLink.orEmpty());
            },
            child: FadeInUp(
              from: 20,
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 500),
              child: Container(
                width: 100.w,
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: model.done.orFalse() ? Colors.white : Colors.grey[200],
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
                              "Exercise name : ${model.exerciseModel!.name.orEmpty()}",
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
                            getDate(userExercises.date.orEmpty()),
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
                        "Count : ${model.count.orZero().toInt().toString()}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      AppSizedBox.h1,
                      Text(
                        "Total : ${model.total.orZero().toInt().toString()}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      AppSizedBox.h1,
                      Text(
                        "Exercise Status : ${model.done.orFalse() ? "Finished" : "Not Finish"}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      AppSizedBox.h1,
                      if (widget.canEdit && isToday && !(model.done ?? false))
                        BlocConsumer<UserCubit, UserState>(
                          listener: (context, state) {
                            if (state is ScSetExerciseAsRead) {
                              showFlutterToast(
                                message: "Sub Exercise Set As Done",
                                toastColor: Colors.green,
                              );
                            }
                            if (state is ScSetAllExerciseAsRead) {
                              showFlutterToast(
                                message: "All Exercise Set As Done",
                                toastColor: Colors.green,
                              );
                            }
                            if (state is ErorrSetExerciseAsRead) {
                              showFlutterToast(
                                message: state.error,
                                toastColor: Colors.red,
                              );
                            }
                          },
                          builder: (context, state) {
                            UserCubit cubit = UserCubit.get(context);
                            return state is LoadingSetExerciseAsRead &&
                                    state.id ==
                                        userExercises.id.orEmpty() +
                                            index.toString()
                                ? const CircularProgressComponent()
                                : Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      width: 30.w,
                                      height: 6.h,
                                      child: CustomButton(
                                        onTap: () {
                                          cubit.setExerciseAsDone(
                                              userExercises: userExercises,
                                              index: index);
                                        },
                                        fontsize: 10,
                                        text: 'set as finished',
                                      ),
                                    ),
                                  );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
