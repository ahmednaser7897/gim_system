import 'dart:convert';
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
import 'package:gim_system/ui/coach/settings_screens/coach_settings.dart';
import 'package:http/http.dart' as http;
import '../../model/coach_model.dart';
import '../../model/gym_model.dart';
import '../../model/message_model.dart';
import '../../model/user_model.dart';
import '../../ui/coach/home_screens/coach_home.dart';
import '../../ui/coach/users/users_list.dart';
import '../admin/admin_cubit.dart';
part 'coach_state.dart';

class CoachCubit extends Cubit<CoachState> {
  CoachCubit() : super(CoachInitial());
  static CoachCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    const CochHome(),
    const UsersList(),
    const CoachSettingsScreen(),
  ];
  List titles = [
    'Coachs',
    'Trainees',
    'Settings',
  ];
  void changeBottomNavBar(int index) {
    emit(LoadingChangeHomeIndex());
    currentIndex = index;
    emit(ScChangeHomeIndex());
  }

  CoachModel? coachModel;
  Future<void> getCurrentCoachData() async {
    emit(LoadingGetCoach());
    try {
      var value = await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(Constants.coach)
          .doc(AppPreferences.uId)
          .get();
      coachModel = CoachModel.fromJson(value.data() ?? {});
      emit(ScGetCoach());
    } catch (e) {
      print('get Current Coach Data Error: $e');
      emit(ErorrGetCoach(e.toString()));
    }
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

  Future<void> editCoach(
      {required CoachModel model, required File? image}) async {
    try {
      emit(LoadingEditCoach());
      var value =
          await FirebaseFirestore.instance.collection('phoneNumbers').get();
      if (model.phone != coachModel!.phone) {
        if (checkPhone(model.phone ?? '', value.docs)) {
          emit(ErorrEditCoach('Phone number is already used'));
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
          .collection(Constants.coach)
          .doc(AppPreferences.uId)
          .update(model.toJson());
      if (image != null) {
        await addImageSub(
          type: Constants.coach,
          userId: AppPreferences.uId,
          parentImageFile: image,
        );
      }
      emit(ScEditCoach());
      await getCurrentCoachData();
    } catch (error) {
      print('Error: $error');
      if (error
          .toString()
          .contains('The email address is already in use by another account')) {
        emit(ErorrEditCoach(
            'The email address is already in use by another account'));
      }
      print('Error: $error');
      emit(ErorrEditCoach(error.toString()));
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

  List<UserModel> users = [];
  Future<void> getAllusers() async {
    try {
      var value = await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(Constants.user)
          .get();
      for (var element in value.docs) {
        var user = UserModel.fromJson(element.data());
        var dites = await element.reference
            .collection(Constants.dite)
            .orderBy('createdAt', descending: true)
            .get();
        user.dites = [];
        for (var element in dites.docs) {
          var dite = DietModel.fromJson(element.data());
          //get evrey users dites
          var value = await FirebaseFirestore.instance
              .collection(Constants.gym)
              .doc(AppPreferences.gymUid)
              .collection(Constants.coach)
              .doc(dite.coachId)
              .get();
          dite.coachModel = CoachModel.fromJson(value.data() ?? {});
          user.dites.orEmpty().add(dite);
        }

        var userExercise = await element.reference
            .collection(Constants.userExercise)
            .orderBy('date', descending: true)
            .get();
        user.userExercises = [];
        for (var element in userExercise.docs) {
          var userExercises = UserExercises.fromJson(element.data());
          //get evrey users exercises
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
          user.userExercises!.add(userExercises);
        }
        users.add(user);
      }
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
        if (element.id == AppPreferences.uId) {
          continue;
        }
        coachs.add(CoachModel.fromJson(element.data()));
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  List<ExerciseModel> esercises = [];
  Future<void> getAllesercises() async {
    try {
      var value = await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(Constants.exercise)
          .get();
      for (var element in value.docs) {
        esercises.add(ExerciseModel.fromJson(element.data()));
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getHomeData() async {
    users = [];
    coachs = [];
    esercises = [];
    emit(LoadingGetHomeData());
    try {
      await getAllusers();
      await getAllCoachs();
      await getAllesercises();
      emit(ScGetHomeData());
    } catch (e) {
      print('Get home Data Error: $e');
      emit(ErorrGetHomeData(e.toString()));
    }
  }

  Future<void> addDite({required DietModel model}) async {
    try {
      emit(LoadingAddDite());
      var value = FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(Constants.user)
          .doc(model.userId)
          .collection(Constants.dite)
          .doc();
      model.id = value.id;
      await value.set(model.toJson());
      var indxex = users.indexWhere((element) => element.id == model.userId);
      model.coachModel = coachModel;
      users[indxex].dites.orEmpty().insert(0, model);
      emit(ScAddDite());
    } catch (error) {
      emit(ErorrAddDite(error.toString()));
      print('Error: $error');
    }
  }

  Future<void> addExercise({required UserExercises model}) async {
    try {
      emit(LoadingAddExercise());
      var doc = FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(Constants.user)
          .doc(model.userId)
          .collection(Constants.userExercise)
          .doc();
      model.id = doc.id;
      await doc.set(model.toJson());
      var indxex = users.indexWhere((element) => element.id == model.userId);
      users[indxex].userExercises.orEmpty().insert(0, model);
      users[indxex].userExercises.orEmpty().forEach((element) async {
        element.coachModel = coachModel;
        element.exercises.orEmpty().forEach((element) async {
          var value2 = await FirebaseFirestore.instance
              .collection(Constants.gym)
              .doc(AppPreferences.gymUid)
              .collection(Constants.exercise)
              .doc(element.exerciseId)
              .get();
          var exerciseModel = ExerciseModel.fromJson(value2.data() ?? {});
          element.exerciseModel = exerciseModel;
        });
      });
      await sendNotificationsToUser(users[indxex]);
      emit(ScAddExercise());
    } catch (error) {
      emit(ErorrAddExercise(error.toString()));
      print('Error: $error');
    }
  }

  Future<void> updateUserFitnessInfo(
      {required UserModel newModel, required UserModel oldModel}) async {
    try {
      print(newModel.id);
      emit(LoadingUpdateUserFitnessInfo());
      await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(Constants.user)
          .doc(newModel.id)
          .update(newModel.toJson());
      oldModel.goal = newModel.goal;
      oldModel.fitnesLevel = newModel.fitnesLevel;
      oldModel.height = newModel.height;
      oldModel.weight = newModel.weight;
      oldModel.bodyFatPercentage = newModel.bodyFatPercentage;
      emit(ScUpdateUserFitnessInfo());
    } catch (error) {
      emit(ErorrUpdateUserFitnessInfo(error.toString()));
      print('Error: $error');
    }
  }

  Future<void> sendMessage(
      {required MessageModel messageModel, File? file}) async {
    try {
      emit(LoadingCoachSendMessage());
      if (file != null) {
        messageModel.file = await uploadFile(file);
      }
      var value = FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(Constants.coach)
          .doc(coachModel!.id)
          .collection(Constants.chats)
          .doc(messageModel.userId)
          .collection(Constants.messages)
          .doc();
      messageModel.id = value.id;
      await value.set(messageModel.toMap());
      var value1 = FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(Constants.user)
          .doc(messageModel.userId)
          .collection(Constants.chats)
          .doc(coachModel!.id)
          .collection(Constants.messages)
          .doc();
      messageModel.id = value1.id;
      await value1.set(messageModel.toMap());
      emit(ScCoachSendMessage());
    } catch (error) {
      emit(ErorrCoachSendMessage(error.toString()));
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
  Future<void> getMessages({required UserModel userModel}) async {
    try {
      messages = [];
      emit(LoadingCoachGetdMessages());
      FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.gymUid)
          .collection(Constants.coach)
          .doc(coachModel!.id)
          .collection(Constants.chats)
          .doc(userModel.id)
          .collection(Constants.messages)
          .orderBy('dateTime')
          .snapshots()
          .listen((event) {
        messages = [];
        for (var element in event.docs) {
          messages.add(MessageModel.fromJson(element.data()));
        }
        emit(ScCoachGetdMessages());
      });
      emit(ScCoachGetdMessages());
    } catch (error) {
      emit(ErorrCoachGetdMessages(error.toString()));
      print('Error: $error');
    }
  }

  Future<void> sendNotificationsToUser(UserModel userModel) async {
    try {
      var tokenDocs =
          await FirebaseFirestore.instance.collection('tokens').get();
      tokenDocs.docs.forEach((element) async {
        if (element.id == userModel.id) {
          print(element.data()['token']);
          await sendNotificationToUser(element.data()['token']);
        }
      });
    } catch (e) {
      print("erorr $e");
    }
  }

  String authorization =
      "key=AAAAd2vXNyY:APA91bGddOGr4r1Y9CAWFlT5onvbv6scxr_ouuGK7sv3AJNSYBvvdnz76-0kYcE3-FgoPvfYxX2yvvB-n4txf8CLrw1H31eF38Gh-ejEMVZZcXa5kKWe1XRP_g06j-6BT2hfcjKU_-PS";
  Future<void> sendNotificationToUser(String token) async {
    try {
      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          "content-type": "application/json",
          "Authorization": authorization,
        },
        body: jsonEncode({
          "to": token,
          "notification": {
            "body":
                "👋 A new exercise has been added. Log in to your account to view the details and participate.",
            "title": "New Exercise Added🎉"
          },
        }),
      );
    } catch (e) {
      print("erorr $e");
    }
  }
}
