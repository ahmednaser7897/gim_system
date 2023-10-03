//import 'dart:io';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_prefs.dart';
import 'package:gim_system/app/constants.dart';
import 'package:gim_system/model/users_models.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../model/exercises_model.dart';
import '../../ui/gym/home_screens/gym_home.dart';
import '../../ui/gym/home_screens/gym_settings.dart';
import '../admin/admin_cubit.dart';
part 'gym_state.dart';

class GymCubit extends Cubit<GymState> {
  GymCubit() : super(GymInitial());
  static GymCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    const GymHome(),
    const GymSettingsScreen(),
  ];
  List titles = [
    'Home',
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
      print("getCurrentGymData");
      print(AppPreferences.uId);
      var value = await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.uId)
          .get();
      gymModel = GymModel.fromJson(value.data() ?? {});
      print("object2");
      print(value.data());
      emit(ScGetGym());
      print("getCurrentGymData done");
    } catch (e) {
      print('getCurrentGymData Error: $e');
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
      print('admin updated Success 😎');
      print('EditGym userId');
      print(AppPreferences.uId);
      emit(ScEditGym());
    } catch (error) {
      print('Error: $error');
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
        print('coach Register Success 😎');
        print('AddCoach userId');
        print(value1.user?.uid);
        if (image != null) {
          await addImageSub(
            type: Constants.coach,
            userId: value1.user!.uid,
            parentImageFile: image,
          );
        }
        emit(ScAddCoach());
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
        print('user Register Success 😎');
        print('Adduser userId');
        print(value1.user?.uid);
        if (image != null) {
          await addImageSub(
            type: Constants.user,
            userId: value1.user!.uid,
            parentImageFile: image,
          );
        }
        emit(ScAddUser());
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
          .add(model.toMap());

      await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.uId)
          .collection(Constants.exercise)
          .doc(value.id)
          .update({'id': value.id});

      print('Exercise added');
      emit(ScAddExercise());
    } catch (error) {
      emit(ErorrAddExercise(error.toString()));
      print('Error: $error');
    }
  }

  Future<void> addImage(
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
      print('addGuyImage image');
      print(parentImageUrl);
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
      print('addGuyImage image');
      print(parentImageUrl);
      await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.uId)
          .collection(type)
          .doc(userId)
          .update({
        'image': parentImageUrl,
      });
      print('addImage done');
    } catch (e) {
      print('Error: $e');
    }
  }

  List<CoachModel> coachs = [];
  Future<void> getAllCoachs() async {
    try {
      print("getAllcoachs");
      var value = await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.uId)
          .collection(Constants.coach)
          .get();
      for (var element in value.docs) {
        coachs.add(CoachModel.fromJson(element.data()));
      }
      print("getAllcoachs done");
      print(coachs.length);
    } catch (e) {
      print('Get Parent Data Error: $e');
    }
  }

  List<UserModel> users = [];
  Future<void> getAllusers() async {
    try {
      print("getAllusers");
      var value = await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.uId)
          .collection(Constants.user)
          .get();
      for (var element in value.docs) {
        users.add(UserModel.fromJson(element.data()));
      }
      print("getAllusers done");
      print(users.length);
    } catch (e) {
      print('Get Parent Data Error: $e');
    }
  }

  List<ExerciseModel> exercises = [];
  Future<void> getAllexercises() async {
    try {
      print("getAllexercises");
      var value = await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(AppPreferences.uId)
          .collection(Constants.exercise)
          .get();
      for (var element in value.docs) {
        exercises.add(ExerciseModel.fromMap(element.data()));
      }
      print("getAllexercises done");
      print(exercises.length);
    } catch (e) {
      print('Get Parent Data Error: $e');
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
      print('Get Parent Data Error: $e');
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
