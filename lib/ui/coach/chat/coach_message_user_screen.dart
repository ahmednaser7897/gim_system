import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_prefs.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/constants.dart';
import 'package:gim_system/app/document_picker.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/controller/coach/coach_cubit.dart';
import 'package:gim_system/model/user_model.dart';

import '../../../app/app_colors.dart';
import '../../../app/icon_broken.dart';
import '../../../model/message_model.dart';
import '../../user/user_chat/build_my_message.dart';

class CoachMessageUserScreen extends StatefulWidget {
  final UserModel user;
  const CoachMessageUserScreen({super.key, required this.user});

  @override
  State<CoachMessageUserScreen> createState() => _CoachMessageUserScreenState();
}

class _CoachMessageUserScreenState extends State<CoachMessageUserScreen> {
  TextEditingController messageController = TextEditingController();
  File? file;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoachCubit, CoachState>(
      listener: (context, state) {},
      builder: (context, state) {
        CoachCubit cubit = CoachCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('${widget.user.name}'),
          ),
          body: state is LoadingCoachGetdMessages
              ? const CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: cubit.messages.isNotEmpty
                            ? ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  MessageModel message = cubit.messages[index];
                                  if (message.type == Constants.coach) {
                                    return BuildMyMessageWidget(
                                        model: message,
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        backgroundColor:
                                            AppColors.primer.withOpacity(0.2));
                                  }
                                  return BuildMyMessageWidget(
                                    model: message,
                                    alignment: AlignmentDirectional.centerStart,
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.2),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return AppSizedBox.h1;
                                },
                                itemCount: cubit.messages.length,
                              )
                            : const Center(
                                child: Text('No messages yet'),
                              ),
                      ),
                      if (file != null) ...[
                        ListTile(
                          title: Text(
                              'Selected file : ${file!.path.split('/').last}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.highlight_remove_outlined),
                            onPressed: () {
                              setState(() {
                                file = null;
                              });
                            },
                          ),
                        ),
                        AppSizedBox.h1
                      ],
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: 50,
                          padding: const EdgeInsetsDirectional.only(
                            start: 15,
                            end: 0,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: TextFormField(
                            controller: messageController,
                            maxLines: 999,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type your message here...',
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  (state is LoadingUploadFile)
                                      ? const Padding(
                                          padding: EdgeInsets.all(8),
                                          child: CircularProgressIndicator(),
                                        )
                                      : IconButton(
                                          onPressed: () async {
                                            var documentHelper =
                                                DocumentHelper();
                                            var value =
                                                await documentHelper.pickFile();
                                            if (value != null) {
                                              print(value.path);
                                              setState(() {
                                                file = value;
                                              });
                                            }
                                          },
                                          icon: const Icon(
                                              Icons.attachment_sharp)),
                                  MaterialButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () async {
                                      if (messageController.text.isNotEmpty) {
                                        await cubit.sendMessage(
                                          file: file,
                                          messageModel: MessageModel(
                                            userId: widget.user.id,
                                            coachId: AppPreferences.uId,
                                            message: messageController.text,
                                            dateTime: DateTime.now().toString(),
                                            type: Constants.coach,
                                          ),
                                        );
                                        file = null;
                                        messageController.clear();
                                      }
                                    },
                                    color: AppColors.primer,
                                    elevation: 2,
                                    height: 10.h,
                                    minWidth: 15.w,
                                    child: const Icon(
                                      IconBroken.Send,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
