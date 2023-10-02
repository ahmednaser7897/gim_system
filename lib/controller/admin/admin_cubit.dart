import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_prefs.dart';
import 'package:gim_system/app/constants.dart';
import 'package:gim_system/model/users_models.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../ui/admin/home_screens/admin_home.dart';
import '../../ui/admin/home_screens/admin_settings.dart';
part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
  static AdminCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    const AdminHome(),
    const AdminSettingsScreen(),
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

  AdminModel? adminModel;
  Future<void> getCurrentParentData() async {
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

  void addGym({required GymModel gymModel, required File? image}) {
    emit(LoadingAddGym());
    FirebaseFirestore.instance.collection('phoneNumbers').get().then((value) {
      if (checkPhone(gymModel.phone ?? '', value.docs)) {
        emit(ErorrAddGym('Phone number is already used'));
        return;
      } else {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: gymModel.email ?? '',
          password: gymModel.password ?? '',
        )
            .then((value1) {
          FirebaseFirestore.instance
              .collection('phoneNumbers')
              .doc(value1.user!.uid)
              .set({
            'phone': gymModel.phone,
          });
          gymModel.id = value1.user!.uid;
          FirebaseFirestore.instance
              .collection(Constants.gym)
              .doc(value1.user?.uid)
              .set(gymModel.toJson())
              .then((value) {
            print('User Register Success 😎');
            print('addGym userId');
            print(value1.user?.uid);
            if (image != null) {
              addImage(
                type: Constants.gym,
                userId: value1.user!.uid,
                parentImageFile: image,
              );
            }

            emit(ScAddGym());
          }).catchError((error) {
            print('Error: $error');
            emit(ErorrAddGym(error.toString()));
          });
        }).catchError((error) {
          emit(ErorrAddGym(error.toString()));
        });
      }
    });
  }

  void addAdmin({required AdminModel model, required File? image}) {
    emit(LoadingAddAdmin());
    FirebaseFirestore.instance.collection('phoneNumbers').get().then((value) {
      if (checkPhone(model.phone ?? '', value.docs)) {
        emit(ErorrAddAdmin('Phone number is already used'));
        return;
      } else {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: model.email ?? '',
          password: model.password ?? '',
        )
            .then((value1) {
          FirebaseFirestore.instance
              .collection('phoneNumbers')
              .doc(value1.user!.uid)
              .set({
            'phone': model.phone,
          });
          model.id = value1.user!.uid;
          FirebaseFirestore.instance
              .collection(Constants.admin)
              .doc(value1.user?.uid)
              .set(model.toJson())
              .then((value) {
            print('admin Register Success 😎');
            print('addadmin userId');
            print(value1.user?.uid);
            if (image != null) {
              addImage(
                type: Constants.admin,
                userId: value1.user!.uid,
                parentImageFile: image,
              );
            }

            emit(ScAddAdmin());
          }).catchError((error) {
            print('Error: $error');
            emit(ErorrAddAdmin(error.toString()));
          });
        }).catchError((error) {
          if (error.toString().contains(
              'The email address is already in use by another account')) {
            emit(ErorrAddAdmin(
                'The email address is already in use by another account'));
          } else {
            emit(ErorrAddAdmin(error.toString()));
          }
          print('Error: $error');
        });
      }
    });
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
        element.data().addAll({'id': element.id});
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
        element.data().addAll({'id': element.id});
        gyms.add(GymModel.fromJson(element.data()));
      }
      print("getAllGyms done");
      print(gyms.length);
      emit(ScGetAdmin());
    } catch (e) {
      print('Get Parent Data Error: $e');
      emit(ErorrGetAdmin(e.toString()));
    }
  }

  Future<void> getHomeData() async {
    emit(LoadingGetHomeData());
    admins = [];
    gyms = [];
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
