// import 'package:flutter/material.dart';
// import 'package:gim_system/app/app_colors.dart';
// import 'package:gim_system/app/extensions.dart';
// import 'package:intl/intl.dart';

// import '../../../app/app_sized_box.dart';
// import '../../../app/app_validation.dart';
// import '../../../model/exercises_model.dart';
// import '../../../model/user_model.dart';
// import '../../componnents/app_textformfiled_widget.dart';

// class ShowUserExercises extends StatefulWidget {
//   const ShowUserExercises({super.key, required this.user});
//   final UserModel user;

//   @override
//   State<ShowUserExercises> createState() => _ShowUserExercisesState();
// }

// class _ShowUserExercisesState extends State<ShowUserExercises> {
//   late UserModel user;
//   @override
//   void initState() {
//     user = widget.user;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Show User Exercises'),
//         ),
//         body: esercisesWidget());
//   }

//   Widget esercisesWidget() {
//     return ListView.separated(
//         padding: EdgeInsets.all(5.w),
//         itemBuilder: (context, index) =>
//             userEsercisesWidget(user.userExercises.orEmpty()[index]),
//         separatorBuilder: (context, index) => Column(
//               children: [
//                 AppSizedBox.h1,
//                 const Divider(
//                   color: AppColors.black,
//                   height: 2,
//                 ),
//                 AppSizedBox.h2,
//               ],
//             ),
//         itemCount: user.userExercises.orEmpty().length);
//   }

//   Widget userEsercisesWidget(UserExercises model) {
//     String date =
//         DateFormat('yMMMMEEEEd').format(DateTime.parse(model.date.orEmpty()));
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             if (model.coachModel != null)
//               Text(
//                 'Coach : ${model.coachModel!.name.orEmpty()}',
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//             Text(
//               date,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w900,
//               ),
//             ),
//           ],
//         ),
//         AppSizedBox.h1,
//         Text(
//           "Main Exercise Status : ${model.done.orFalse() ? "finished" : "not finish"}",
//           style: const TextStyle(
//             fontSize: 14,
//             color: AppColors.grey,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         AppSizedBox.h1,
//         ListView.separated(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               return eserciseItem(
//                 model.exercises.orEmpty()[index],
//               );
//             },
//             separatorBuilder: (context, index) => AppSizedBox.h1,
//             itemCount: model.exercises.orEmpty().length),
//       ],
//     );
//   }

//   Widget eserciseItem(
//     Exercise model,
//   ) {
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
//           Text(
//             "sub exercise Status : ${model.done.orFalse() ? "finished" : "not finish"}",
//             style: const TextStyle(
//               fontSize: 14,
//               color: AppColors.grey,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
