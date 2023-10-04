import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/constants.dart';

import '../../app/app_prefs.dart';
import '../../model/tokens_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  TokensModel? tokenModel;
  String userId = '';
  void userMakLogin({required String email, required String password}) async {
    emit(AuthGetUserAfterLoginLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userId = value.user!.uid;
      print('on log in');
      print(AppPreferences.uId);
      print(AppPreferences.userType);
    }).catchError((error) {
      catchError(error);
      return;
    });
    await getUserType(userId);
  }

  Future<void> getUserType(String userId) async {
    try {
      if (userId != '') {
        var token = await FirebaseMessaging.instance.getToken();
        tokenModel = TokensModel(id: userId, token: token!);
        await FirebaseFirestore.instance.collection('tokens').doc(userId).set(
              tokenModel!.toMap(),
            );
        if (await isAdmin(userId)) {
          userId = '';
          print('User is an admin😎');
          emit(AuthGetUserAfterLoginSuccessState(message: Constants.admin));
        } else if (await isGym(userId)) {
          userId = '';
          print('User is a gym');
          emit(AuthGetUserAfterLoginSuccessState(message: Constants.gym));
        } else if (await isCoach(userId)) {
          userId = '';
          print('User is a coach');
          emit(AuthGetUserAfterLoginSuccessState(message: Constants.coach));
        } else if (await isUser(userId)) {
          emit(AuthGetUserAfterLoginSuccessState(message: Constants.user));
          userId = '';
          print('User is a user');
        }
      } else {
        emit(AuthGetUserAfterLoginErrorState(error: 'User is not found'));
        userId = '';
        print('User is not found😎');
      }
    } catch (e) {
      print('erorr getUserType $e');
    }
  }

  void catchError(error) {
    if (error.code == 'user-not-found') {
      emit(AuthGetUserAfterLoginErrorState(
          error: 'No user found for that email.'));
      return;
    } else if (error.code == 'wrong-password') {
      emit(AuthGetUserAfterLoginErrorState(error: 'Invalid Account'));
      return;
    } else if (error.code == 'invalid-email') {
      emit(AuthGetUserAfterLoginErrorState(error: 'Invalid Email'));
      return;
    } else if (error.code == 'user-disabled') {
      emit(AuthGetUserAfterLoginErrorState(error: 'User is disabled'));
      return;
    } else if (error.code == 'too-many-requests') {
      emit(AuthGetUserAfterLoginErrorState(
          error: 'Too many requests. Try again later.'));
      return;
    } else {
      emit(AuthGetUserAfterLoginErrorState(error: error.message));
      return;
    }
  }

  Future<bool> isAdmin(String userId) async {
    print('check if user admin');
    final adminRef = await FirebaseFirestore.instance
        .collection(Constants.admin)
        .doc(userId);
    final adminDocExit = await adminRef.get().then((value) => value.exists);
    final adminDoc = await adminRef.get();
    if (adminDocExit == true) {
      if (adminDoc.data()!['ban']) {
        emit(AuthGetUserAfterLoginErrorState(error: 'Admin is banned'));
        return false;
      } else {
        AppPreferences.userType = Constants.admin;
        AppPreferences.uId = userId;
        return true;
      }
    } else {
      return false;
    }
  }

  Future<bool> isGym(String userId) async {
    print('check if user gym');
    final parentRef =
        FirebaseFirestore.instance.collection(Constants.gym).doc(userId);
    final parentDocExit = await parentRef.get().then((value) => value.exists);
    final parentDoc = await parentRef.get();
    if (parentDocExit) {
      print('check if  gym ban');
      if (parentDoc.data()!['ban']) {
        print('gym is ban');
        emit(AuthGetUserAfterLoginErrorState(error: 'Gym is banned'));
        return false;
      } else {
        AppPreferences.userType = Constants.gym;
        AppPreferences.uId = userId;
        return true;
      }
    } else {
      return false;
    }
  }

  Future<bool> isCoach(String userId) async {
    print('check if user coach');
    final gymsQuerySnapshot =
        await FirebaseFirestore.instance.collection(Constants.gym).get();
    for (final gyms in gymsQuerySnapshot.docs) {
      final coachRef = gyms.reference.collection(Constants.coach).doc(userId);
      final coachDocExit = await coachRef.get().then((value) => value.exists);
      final coachDoc = await coachRef.get();
      if (coachDocExit == true) {
        if (coachDoc.data()!['ban']) {
          emit(AuthGetUserAfterLoginErrorState(error: 'Coach is banned'));
          return false;
        } else {
          if (gyms.data()['ban']) {
            emit(AuthGetUserAfterLoginErrorState(error: 'Gym is banned'));
            return false;
          } else {
            AppPreferences.userType = Constants.coach;
            AppPreferences.uId = userId;
            AppPreferences.gymUid = gyms.id;
            return true;
          }
        }
      }
    }
    return false;
  }

  Future<bool> isUser(String userId) async {
    print('check if user coach');
    final gymsQuerySnapshot =
        await FirebaseFirestore.instance.collection(Constants.gym).get();
    for (final gyms in gymsQuerySnapshot.docs) {
      final userRef = gyms.reference.collection(Constants.user).doc(userId);
      final userDocExit = await userRef.get().then((value) => value.exists);
      final userDoc = await userRef.get();
      if (userDocExit == true) {
        if (userDoc.data()!['ban']) {
          emit(AuthGetUserAfterLoginErrorState(error: 'user is banned'));
          return false;
        } else {
          if (gyms.data()['ban']) {
            emit(AuthGetUserAfterLoginErrorState(error: 'Gym is banned'));
            return false;
          } else {
            AppPreferences.userType = Constants.user;
            AppPreferences.uId = userId;
            AppPreferences.gymUid = gyms.id;
            return true;
          }
        }
      }
    }
    return false;
  }
}
