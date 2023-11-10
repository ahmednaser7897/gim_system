import 'dart:io';
import 'package:gim_system/app/extensions.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_prefs.dart';
import 'package:gim_system/app/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:gim_system/model/coach_model.dart';

import '../../model/diets_model.dart';
import '../../model/exercises_model.dart';
import '../../model/gym_model.dart';
import '../../model/user_model.dart';
import '../../ui/gym/coachs/gym_coacts_home.dart';
import '../../ui/gym/exercises/gym_exercises_home.dart';
import '../../ui/gym/usres/gym_users_home.dart';
import '../../ui/gym/settings_screens/gym_settings.dart';
import '../admin/admin_cubit.dart';
part 'gym_state.dart';

class GymCubit extends Cubit<GymState> {
  GymCubit() : super(GymInitial());
  static GymCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    const GymUsersList(),
    const GymCoachsList(),
    const GymExercisesList(),
    const GymSettingsScreen(),
  ];
  List titles = [
    'Trainees',
    'Coachs',
    'Exercises',
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
          .doc(AppPreferences.uId)
          .get();
      gymModel = GymModel.fromJson(value.data() ?? {});
      emit(ScGetGym());
    } catch (e) {
      print('Error: $e');
      emit(ErorrGetGym(e.toString()));
    }
  }

  Future<void> editGym({required GymModel model, required File? image}) async {
    try {
      emit(LoadingEditGym());
      var value =
          await FirebaseFirestore.instance.collection('phoneNumbers').get();
      if (model.phone != gymModel!.phone) {
        if (checkPhone(model.phone ?? '', value.docs)) {
          emit(ErorrEditGym('Phone number is already used'));
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
          .doc(AppPreferences.uId)
          .update(model.toJson());
      if (image != null) {
        await addImage(
          type: Constants.gym,
          userId: AppPreferences.uId,
          parentImageFile: image,
        );
      }
      print(AppPreferences.uId);
      emit(ScEditGym());
      await getCurrentGymData();
    } catch (error) {
      if (error
          .toString()
          .contains('The email address is already in use by another account')) {
        emit(ErorrEditGym(
            'The email address is already in use by another account'));
      }
      print('Error: $error');
      emit(ErorrEditGym(error.toString()));
    }
  }

  Future<void> addCoach(
      {required CoachModel model, required File? image}) async {
    try {
      emit(LoadingAddCoach());
      var value =
          await FirebaseFirestore.instance.collection('phoneNumbers').get();
      if (checkPhone(model.phone ?? '', value.docs)) {
        emit(ErorrAddCoach('Phone number is already used'));
        return;
      } else {
        var value1 = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: model.email ?? '',
          password: model.password ?? '',
        );
        await FirebaseFirestore.instance
            .collection('phoneNumbers')
            .doc(value1.user!.uid)
            .set({
          'phone': model.phone,
        });
        model.id = value1.user!.uid;
        await FirebaseFirestore.instance
            .collection(Constants.gym)
            .doc(AppPreferences.uId)
            .collection(Constants.coach)
            .doc(value1.user?.uid)
            .set(model.toJson());
        if (image != null) {
          await addImageSub(
            type: Constants.coach,
            userId: value1.user!.uid,
            parentImageFile: image,
          );
        }
        emit(ScAddCoach());
        await getHomeData();
      }
    } catch (error) {
      if (error
          .toString()
          .contains('The email address is already in use by another account')) {
        emit(ErorrAddCoach(
            'The email address is already in use by another account'));
      } else {
        emit(ErorrAddCoach(error.toString()));
      }
      print('Error: $error');
    }
  }

  Future<void> addUser({required UserModel model, required File? image}) async {
    try {
      emit(LoadingAddUser());
      var value =
          await FirebaseFirestore.instance.collection('phoneNumbers').get();
      if (checkPhone(model.phone ?? '', value.docs)) {
        emit(ErorrAddUser('Phone number is already used'));
        return;
      } else {
        var value1 = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: model.email ?? '',
          password: model.password ?? '',
        );
        await FirebaseFirestore.instance
            .collection('phoneNumbers')
            .doc(value1.user!.uid)
            .set({
          'phone': model.phone,
        });
        model.id = value1.user!.uid;
        await FirebaseFirestore.instance
            .collection(Constants.gym)
            .doc(AppPreferences.uId)
            .collection(Constants.user)
            .doc(value1.user?.uid)
            .set(model.toJson());
        if (image != null) {
          await addImageSub(
            type: Constants.user,
            userId: value1.user!.uid,
            parentImageFile: image,
          );
        }
        emit(ScAddUser());
        await getHomeData();
      }
    } catch (error) {
      if (error
          .toString()
          .contains('The email address is already in use by another account')) {
        emit(ErorrAddUser(
            'The email address is already in use by another account'));
      } else {
        emit(ErorrAddUser(error.toString()));
      }
      print('Error: $error');
    }
  }

  Future<void> addExercise({required ExerciseModel model}) async {
    try {
      emit(LoadingAddExercise());
      var value = await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.uId)
          .collection(Constants.exercise)
          .add(model.toJson());

      await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.uId)
          .collection(Constants.exercise)
          .doc(value.id)
          .update({'id': value.id});
      emit(ScAddExercise());
      await getHomeData();
    } catch (error) {
      emit(ErorrAddExercise(error.toString()));
      print('Error: $error');
    }
  }

  Future<void> editExercise({required ExerciseModel model}) async {
    try {
      emit(LoadingEditExercise());
      await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.uId)
          .collection(Constants.exercise)
          .doc(model.id)
          .update(model.toJson());
      var indxex = exercises.indexWhere((element) => element.id == model.id);
      exercises[indxex] = model;
      print('Exercise Edited');
      emit(ScEditExercise());
    } catch (error) {
      emit(ErorrEditExercise(error.toString()));
      print('Error: $error');
    }
  }

  Future<void> addImage(
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
      await FirebaseFirestore.instance.collection(type).doc(userId).update({
        'image': parentImageUrl,
      });
      print('addImage done');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> addImageSub(
      {required String type,
      required String userId,
      required File parentImageFile}) async {
    try {
      print('addGuyImage userId');
      print(userId);
      var parentImageUrl = parentImageFile.path;
      var value = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/$userId')
          .putFile(parentImageFile);
      var value2 = await value.ref.getDownloadURL();
      parentImageUrl = value2;
      await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.uId)
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
          .doc(AppPreferences.uId)
          .collection(Constants.coach)
          .get();
      for (var element in value.docs) {
        if (element.id == AppPreferences.uId) {
          continue;
        }
        coachs.add(CoachModel.fromJson(element.data()));
      }
      print(coachs.length);
    } catch (e) {
      print('Error: $e');
    }
  }

  List<UserModel> users = [];
  Future<void> getAllusers() async {
    try {
      var value = await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.uId)
          .collection(Constants.user)
          .get();
      for (var element in value.docs) {
        var user = UserModel.fromJson(element.data());
        var dites = await element.reference
            .collection(Constants.dite)
            .orderBy('createdAt', descending: true)
            .get();
        user.dites = [];
        //get evrey users dites
        for (var element in dites.docs) {
          var dite = DietModel.fromJson(element.data());
          var value = await FirebaseFirestore.instance
              .collection(Constants.gym)
              .doc(AppPreferences.uId)
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
        //get evrey users exercises
        for (var element in userExercise.docs) {
          var userExercises = UserExercises.fromJson(element.data());
          var value = await FirebaseFirestore.instance
              .collection(Constants.gym)
              .doc(AppPreferences.uId)
              .collection(Constants.coach)
              .doc(userExercises.coachId)
              .get();
          userExercises.coachModel = CoachModel.fromJson(value.data() ?? {});
          userExercises.exercises.orEmpty().forEach((element) async {
            var value2 = await FirebaseFirestore.instance
                .collection(Constants.gym)
                .doc(AppPreferences.uId)
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

  List<ExerciseModel> exercises = [];
  Future<void> getAllexercises() async {
    try {
      var value = await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.uId)
          .collection(Constants.exercise)
          .get();
      for (var element in value.docs) {
        exercises.add(ExerciseModel.fromJson(element.data()));
      }
      print(exercises.length);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getHomeData() async {
    coachs = [];
    users = [];
    exercises = [];
    emit(LoadingGetHomeData());
    try {
      await getAllCoachs();
      await getAllusers();
      await getAllexercises();
      emit(ScGetHomeData());
    } catch (e) {
      print('Get home Data Error: $e');
      emit(ErorrGetHomeData(e.toString()));
    }
  }

  Future<void> changeCoachBan(String id, bool value) async {
    emit(LoadingChangeCoachBan());
    print(changeCoachBan);
    try {
      await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.uId)
          .collection(Constants.coach)
          .doc(id)
          .update({
        'ban': value,
      });
      emit(ScChangeCoachBan());
    } catch (e) {
      print('changeCoachBan $e');
      emit(ErorrChangeCoachBan(e.toString()));
    }
  }

  Future<void> changeUserBan(String id, bool value) async {
    emit(LoadingChangeUserBan());
    print(changeUserBan);
    try {
      await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.uId)
          .collection(Constants.user)
          .doc(id)
          .update({
        'ban': value,
      });
      emit(ScChangeUserBan());
    } catch (e) {
      print('changeUserBan $e');
      emit(ErorrChangeUserBan(e.toString()));
    }
  }
}
