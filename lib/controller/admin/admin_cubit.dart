import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_prefs.dart';
import 'package:gim_system/app/constants.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/model/admin_model.dart';
import 'package:gim_system/model/coach_model.dart';
import 'package:gim_system/model/gym_model.dart';
import 'package:gim_system/model/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../ui/admin/admins/admins_home.dart';
import '../../ui/admin/gyms_screen/admin_gyms.dart';
import '../../ui/admin/settings_screens/admin_settings.dart';
part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
  static AdminCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    const AdminsHome(),
    const AdminGyms(),
    const AdminSettingsScreen(),
  ];
  List titles = [
    'Admins',
    'Gyms',
    'Settings',
  ];
  void changeBottomNavBar(int index) {
    emit(LoadingChangeHomeIndex());
    currentIndex = index;
    emit(ScChangeHomeIndex());
  }

  AdminModel? adminModel;
  Future<void> getCurrentAdninData() async {
    emit(LoadingGetAdmin());
    try {
      print("getCurrentParentData");
      print(AppPreferences.uId);
      var value = await FirebaseFirestore.instance
          .collection(Constants.admin)
          .doc(AppPreferences.uId)
          .get();
      adminModel = AdminModel.fromJson(value.data() ?? {});
      print("object2");
      print(value.data());
      print(adminModel);
      emit(ScGetAdmin());
      print("getCurrentParentData done");
    } catch (e) {
      print('Get Parent Data Error: $e');
      emit(ErorrGetAdmin(e.toString()));
    }
  }

  Future<void> addGym(
      {required GymModel gymModel, required File? image}) async {
    try {
      emit(LoadingAddGym());
      var value =
          await FirebaseFirestore.instance.collection('phoneNumbers').get();
      if (checkPhone(gymModel.phone ?? '', value.docs)) {
        emit(ErorrAddGym('Phone number is already used'));
        return;
      } else {
        var value1 = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: gymModel.email ?? '',
          password: gymModel.password ?? '',
        );
        FirebaseFirestore.instance
            .collection('phoneNumbers')
            .doc(value1.user!.uid)
            .set({
          'phone': gymModel.phone,
        });
        gymModel.id = value1.user!.uid;
        await FirebaseFirestore.instance
            .collection(Constants.gym)
            .doc(value1.user?.uid)
            .set(gymModel.toJson());
        print('User Register Success 😎');
        print('addGym userId');
        print(value1.user?.uid);
        if (image != null) {
          await addImage(
            type: Constants.gym,
            userId: value1.user!.uid,
            parentImageFile: image,
          );
        }
        emit(ScAddGym());
        await getHomeData();
      }
    } catch (error) {
      if (error
          .toString()
          .contains('The email address is already in use by another account')) {
        emit(ErorrAddGym(
            'The email address is already in use by another account'));
      } else {
        emit(ErorrAddGym(error.toString()));
      }
      print('Error: $error');
    }
  }

  Future<void> addAdmin(
      {required AdminModel model, required File? image}) async {
    try {
      emit(LoadingAddAdmin());
      var value =
          await FirebaseFirestore.instance.collection('phoneNumbers').get();
      if (checkPhone(model.phone ?? '', value.docs)) {
        emit(ErorrAddAdmin('Phone number is already used'));
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
            .collection(Constants.admin)
            .doc(value1.user?.uid)
            .set(model.toJson());
        print('admin Register Success 😎');
        print('addadmin userId');
        print(value1.user?.uid);
        if (image != null) {
          await addImage(
            type: Constants.admin,
            userId: value1.user!.uid,
            parentImageFile: image,
          );
        }
        emit(ScAddAdmin());
        await getHomeData();
      }
    } catch (error) {
      if (error
          .toString()
          .contains('The email address is already in use by another account')) {
        emit(ErorrAddAdmin(
            'The email address is already in use by another account'));
      } else {
        emit(ErorrAddAdmin(error.toString()));
      }
      print('Error: $error');
    }
  }

  Future<void> editAdmin(
      {required AdminModel model, required File? image}) async {
    try {
      emit(LoadingEditAdmin());
      var value =
          await FirebaseFirestore.instance.collection('phoneNumbers').get();
      if (model.phone != adminModel!.phone) {
        if (checkPhone(model.phone ?? '', value.docs)) {
          emit(ErorrEditAdmin('Phone number is already used'));
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
          .collection(Constants.admin)
          .doc(AppPreferences.uId)
          .update(model.toJson());
      if (image != null) {
        await addImage(
          type: Constants.admin,
          userId: AppPreferences.uId,
          parentImageFile: image,
        );
      }
      print('admin updated Success 😎');
      print('EditAdmin userId');
      print(AppPreferences.uId);
      emit(ScEditAdmin());
      await getCurrentAdninData();
    } catch (error) {
      print('Error: $error');
      if (error
          .toString()
          .contains('The email address is already in use by another account')) {
        emit(ErorrEditAdmin(
            'The email address is already in use by another account'));
      }
      print('Error: $error');
      emit(ErorrEditAdmin(error.toString()));
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

  List<AdminModel> admins = [];
  Future<void> getAllAdmins() async {
    try {
      print("getAllAdmins");
      var value =
          await FirebaseFirestore.instance.collection(Constants.admin).get();
      for (var element in value.docs) {
        if (element.id == AppPreferences.uId) {
          continue;
        }

        admins.add(AdminModel.fromJson(element.data()));
      }
      print("getAllAdmins done");
      print(admins.length);
    } catch (e) {
      print('Get Parent Data Error: $e');
    }
  }

  List<GymModel> gyms = [];
  Future<void> getAllGyms() async {
    emit(LoadingGetAdmin());
    try {
      print("getAllGyms");
      var value =
          await FirebaseFirestore.instance.collection(Constants.gym).get();

      for (var element in value.docs) {
        var gym = GymModel.fromJson(element.data());
        var users = await element.reference.collection(Constants.user).get();
        gym.users = [];
        for (var element in users.docs) {
          gym.users!.add(UserModel.fromJson(element.data()));
        }
        print('user l is ${gym.users.orEmpty().length}');
        var coachs = await element.reference.collection(Constants.coach).get();
        gym.coachs = [];
        for (var element in coachs.docs) {
          gym.coachs!.add(CoachModel.fromJson(element.data()));
        }
        print('coachs l is ${gym.coachs.orEmpty().length}');
        gyms.add(gym);
      }
      emit(ScGetAdmin());
    } catch (e) {
      print('Get Parent Data Error: $e');
      emit(ErorrGetAdmin(e.toString()));
    }
  }

  Future<void> getHomeData() async {
    admins = [];
    gyms = [];
    emit(LoadingGetHomeData());
    try {
      await getAllAdmins();
      await getAllGyms();
      emit(ScGetHomeData());
    } catch (e) {
      print('Get Parent Data Error: $e');
      emit(ErorrGetHomeData(e.toString()));
    }
  }

  Future<void> changeGymBan(String gymId, bool value) async {
    emit(LoadingChangeGymBan());
    print(changeGymBan);
    print(gymId);
    print(value);
    try {
      await FirebaseFirestore.instance
          .collection(Constants.gym)
          .doc(gymId)
          .update({
        'ban': value,
      });
      emit(ScChangeGymBan());
    } catch (e) {
      print('changeGymBan $e');
      emit(ErorrChangeGymBan(e.toString()));
    }
  }

  Future<void> changeAdminBan(String adminId, bool value) async {
    emit(LoadingChangeAdminBan());
    print(changeAdminBan);
    print(adminId);
    print(value);
    try {
      await FirebaseFirestore.instance
          .collection(Constants.admin)
          .doc(adminId)
          .update({
        'ban': value,
      });
      emit(ScChangeAdminBan());
    } catch (e) {
      print('changeAdminBan $e');
      emit(ErorrChangeAdminBan(e.toString()));
    }
  }
}

bool checkPhone(String phone, List<dynamic>? documents) {
  if (documents == null) {
    return false;
  }
  for (var doc in documents) {
    if (doc.data()?['phone'] == phone) {
      return true;
    }
  }
  return false;
}
