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
import '../../ui/admin/home_screens/admin_home_screen.dart';
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
  void getCurrentParentData() async {
    emit(LoadingGetAdmin());
    try {
      print("object1");
      print(AppPreferences.uId);
      await FirebaseFirestore.instance
          .collection(Constants.admin)
          .doc(AppPreferences.uId)
          .get()
          .then((value) {
        adminModel = AdminModel.fromJson(value.data() ?? {});
        print("object2");
        print(value.data());
        print(adminModel);
        emit(ScGetAdmin());
      });
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

  void editAdmin({required AdminModel model, required File? image}) {
    emit(LoadingEditAdmin());

    FirebaseFirestore.instance.collection('phoneNumbers').get().then((value) {
      if (model.phone != adminModel!.phone) {
        if (checkPhone(model.phone ?? '', value.docs)) {
          emit(ErorrEditAdmin('Phone number is already used'));
          return;
        } else {
          FirebaseFirestore.instance
              .collection('phoneNumbers')
              .doc(AppPreferences.uId)
              .set({
            'phone': model.phone,
          });
        }
      }
      print(model.toJson());
      FirebaseFirestore.instance
          .collection(Constants.admin)
          .doc(AppPreferences.uId)
          .set(model.toJson())
          .then((value) {
        print('admin Register Success 😎');
        print('EditAdmin userId');
        print(AppPreferences.uId);
        if (image != null) {
          addImage(
            type: Constants.admin,
            userId: AppPreferences.uId,
            parentImageFile: image,
          );
        }

        emit(ScEditAdmin());
        getCurrentParentData();
      }).catchError((error) {
        print('Error: $error');
        if (error.toString().contains(
            'The email address is already in use by another account')) {
          emit(ErorrEditAdmin(
              'The email address is already in use by another account'));
        } else {
          emit(ErorrEditAdmin(error.toString()));
        }
        print('Error: $error');
        emit(ErorrEditAdmin(error.toString()));
      });
    });
  }

  void addImage(
      {required String type,
      required String userId,
      required File parentImageFile}) async {
    //emit(LoadingAddImage());
    print('addGuyImage userId');
    print(userId);
    var parentImageUrl = parentImageFile.path;
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/$userId')
        .putFile(parentImageFile)
        .then((p0) => {
              p0.ref.getDownloadURL().then((value) {
                parentImageUrl = value;
                print('addGuyImage image');
                print(parentImageUrl);
                FirebaseFirestore.instance.collection(type).doc(userId).update({
                  'image': parentImageUrl,
                }).then((value) {
                  getCurrentParentData();
                  //emit(ScAddImage());
                }).catchError((error) {
                  print('Error: ${error.toString()}');
                  //emit(ErorrAddImage(error.toString()));
                });
              })
            })
        .catchError((error) {
      print('Error: $error');
      //emit(ErorrAddImage(error));
    });
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
