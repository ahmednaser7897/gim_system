import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_prefs.dart';
import 'package:gim_system/app/constants.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/model/diets_model.dart';
import 'package:gim_system/model/exercises_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:gim_system/model/gym_model.dart';

import '../../model/coach_model.dart';
import '../../model/message_model.dart';
import '../../model/user_model.dart';
import '../../ui/user/home_screens/user_home.dart';
import '../../ui/user/settings_screens/user_settings.dart';
import '../admin/admin_cubit.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    const UserHome(),
    const UserSettingsScreen(),
  ];
  List titles = [
    'Coachs',
    'Settings',
  ];
  void changeBottomNavBar(int index) {
    emit(LoadingChangeHomeIndex());
    currentIndex = index;
    emit(ScChangeHomeIndex());
  }

  GymModel? gymModel;
  Future<void> getCurrentGymData() async {
    emit(LoadingGetGym());
    try {
      var value = await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .get();
      gymModel = GymModel.fromJson(value.data() ?? {});
      //get  gym users
      var users = await value.reference.collection(Constants.user).get();
      gymModel!.users = [];
      for (var element in users.docs) {
        gymModel!.users!.add(UserModel.fromJson(element.data()));
      }
      //get  gym caochs
      var coachs = await value.reference.collection(Constants.coach).get();
      gymModel!.coachs = [];
      for (var element in coachs.docs) {
        gymModel!.coachs!.add(CoachModel.fromJson(element.data()));
      }
      emit(ScGetGym());
    } catch (e) {
      print('Error: $e');
      emit(ErorrGetGym(e.toString()));
    }
  }

  UserModel? userModel;
  Future<void> getCurrentUserData() async {
    emit(LoadingGetUser());
    try {
      var value = await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(Constants.user)
          .doc(AppPreferences.uId)
          .get();

      userModel = UserModel.fromJson(value.data() ?? {});

      var dites = await value.reference
          .collection(Constants.dite)
          .orderBy('createdAt', descending: true)
          .get();
      userModel!.dites = [];
      //get evrey users dites
      for (var element in dites.docs) {
        var dite = DietModel.fromJson(element.data());
        var value = await FirebaseFirestore.instance
            .collection(Constants.gym)
            .doc(AppPreferences.gymUid)
            .collection(Constants.user)
            .doc(dite.coachId)
            .get();
        dite.coachModel = CoachModel.fromJson(value.data() ?? {});
        userModel!.dites.orEmpty().add(dite);
      }

      var userExercise = await value.reference
          .collection(Constants.userExercise)
          .orderBy('date', descending: true)
          .get();
      userModel!.userExercises = [];
      //get evrey users exercises
      for (var element in userExercise.docs) {
        var userExercises = UserExercises.fromJson(element.data());
        var value = await FirebaseFirestore.instance
            .collection(Constants.gym)
            .doc(AppPreferences.gymUid)
            .collection(Constants.coach)
            .doc(userExercises.coachId)
            .get();
        userExercises.coachModel = CoachModel.fromJson(value.data() ?? {});
        userExercises.exercises.orEmpty().forEach((element) async {
          var value2 = await FirebaseFirestore.instance
              .collection(Constants.gym)
              .doc(AppPreferences.gymUid)
              .collection(Constants.exercise)
              .doc(element.exerciseId)
              .get();
          var exerciseModel = ExerciseModel.fromJson(value2.data() ?? {});
          element.exerciseModel = exerciseModel;
        });
        userModel!.userExercises!.add(userExercises);
      }
      emit(ScGetUser());
    } catch (e) {
      print('Error: $e');
      emit(ErorrGetUser(e.toString()));
    }
  }

  Future<void> editUser(
      {required UserModel model, required File? image}) async {
    try {
      emit(LoadingEditUser());
      var value =
          await FirebaseFirestore.instance.collection('phoneNumbers').get();
      if (model.phone != userModel!.phone) {
        if (checkPhone(model.phone ?? '', value.docs)) {
          emit(ErorrEditUser('Phone number is already used'));
          return;
        } else {
          await FirebaseFirestore.instance
              .collection('phoneNumbers')
              .doc(AppPreferences.uId)
              .update({
            'phone': model.phone,
          });
        }
      }
      User? currentUser = FirebaseAuth.instance.currentUser;
      await currentUser!.updatePassword(model.password.orEmpty());
      print(model.toJson());
      await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(Constants.user)
          .doc(AppPreferences.uId)
          .update(model.toJson());
      if (image != null) {
        await addImageSub(
          type: Constants.user,
          userId: AppPreferences.uId,
          parentImageFile: image,
        );
      }
      emit(ScEditUser());
      await getCurrentUserData();
    } catch (error) {
      print('Error: $error');
      if (error
          .toString()
          .contains('The email address is already in use by another account')) {
        emit(ErorrEditUser(
            'The email address is already in use by another account'));
      }
      emit(ErorrEditUser(error.toString()));
    }
  }

  Future<void> addImageSub(
      {required String type,
      required String userId,
      required File parentImageFile}) async {
    try {
      var parentImageUrl = parentImageFile.path;
      var value = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/$userId')
          .putFile(parentImageFile);
      var value2 = await value.ref.getDownloadURL();
      parentImageUrl = value2;
      print('addGuyImage image');
      print(parentImageUrl);
      await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(type)
          .doc(userId)
          .update({
        'image': parentImageUrl,
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  List<CoachModel> coachs = [];
  Future<void> getAllCoachs() async {
    try {
      var value = await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(Constants.coach)
          .get();
      for (var element in value.docs) {
        coachs.add(CoachModel.fromJson(element.data()));
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getHomeData() async {
    coachs = [];
    emit(LoadingGetHomeData());
    try {
      await getAllCoachs();
      emit(ScGetHomeData());
    } catch (e) {
      print('Get home Data Error: $e');
      emit(ErorrGetHomeData(e.toString()));
    }
  }

  Future<void> setExerciseAsDone({
    required UserExercises userExercises,
    required int index,
  }) async {
    try {
      emit(LoadingSetExerciseAsRead(
          userExercises.exercises.orEmpty()[index].exerciseId ?? '$index'));
      userExercises.exercises.orEmpty()[index].done = true;
      await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(Constants.user)
          .doc(userExercises.userId)
          .collection(Constants.userExercise)
          .doc(userExercises.id)
          .update(userExercises.toJson());
      bool isAllDone = true;
      userExercises.exercises.orEmpty().forEach((element) {
        if (!element.done.orFalse()) {
          isAllDone = false;
        }
      });
      if (isAllDone) {
        await setAllExerciseAsDone(userExercises: userExercises);
      }
      emit(ScSetExerciseAsRead());
    } catch (error) {
      userExercises.exercises.orEmpty()[index].done = false;
      emit(ErorrSetExerciseAsRead(error.toString()));
      print('Error: $error');
    }
  }

  Future<void> setAllExerciseAsDone({
    required UserExercises userExercises,
  }) async {
    try {
      emit(LoadingSetAllExerciseAsRead());
      await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(Constants.user)
          .doc(userExercises.userId)
          .collection(Constants.userExercise)
          .doc(userExercises.id)
          .update({'done': true});
      userExercises.done = true;
      emit(ScSetAllExerciseAsRead());
    } catch (error) {
      emit(ErorrSetAllExerciseAsRead(error.toString()));
      print('Error: $error');
    }
  }

  Future<void> sendMessage(
      {required MessageModel messageModel, File? file}) async {
    try {
      emit(LoadingUserSendMessage());
      if (file != null) {
        messageModel.file = await uploadFile(file);
      }
      var value = FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(Constants.user)
          .doc(userModel!.id)
          .collection(Constants.chats)
          .doc(messageModel.coachId)
          .collection(Constants.messages)
          .doc();
      messageModel.id = value.id;
      await value.set(messageModel.toMap());
      var value1 = FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(Constants.coach)
          .doc(messageModel.coachId)
          .collection(Constants.chats)
          .doc(userModel!.id)
          .collection(Constants.messages)
          .doc();
      messageModel.id = value1.id;
      await value1.set(messageModel.toMap());
      emit(ScUserSendMessage());
    } catch (error) {
      emit(ErorrUserSendMessage(error.toString()));
      print('Error: $error');
    }
  }

  Future<String?> uploadFile(File file) async {
    try {
      emit(LoadingUploadFile());
      var value = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('files/${file.path.split('/').last}')
          .putFile(file);
      emit(ScUploadFile());
      return value.ref.getDownloadURL();
    } catch (e) {
      emit(ErorrUploadFile(e.toString()));
      return null;
    }
  }

  List<MessageModel> messages = [];
  Future<void> getMessages({required CoachModel coachModel}) async {
    try {
      messages = [];
      emit(LoadingUserGetdMessages());
      FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(Constants.user)
          .doc(userModel!.id)
          .collection(Constants.chats)
          .doc(coachModel.id)
          .collection(Constants.messages)
          .orderBy('dateTime')
          .snapshots()
          .listen((event) {
        messages = [];
        for (var element in event.docs) {
          messages.add(MessageModel.fromJson(element.data()));
        }
        emit(ScUserGetdMessages());
      });
      emit(ScUserGetdMessages());
    } catch (error) {
      emit(ErorrUserGetdMessages(error.toString()));
      print('Error: $error');
    }
  }
}
