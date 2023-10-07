part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class LoadingChangeHomeIndex extends UserState {}

class ScChangeHomeIndex extends UserState {}

class LoadingGetUser extends UserState {}

class ScGetUser extends UserState {}

class ErorrGetUser extends UserState {
  final String error;
  ErorrGetUser(this.error);
}

class LoadingGetGym extends UserState {}

class ScGetGym extends UserState {}

class ErorrGetGym extends UserState {
  final String error;
  ErorrGetGym(this.error);
}

class LoadingGetHomeData extends UserState {}

class ScGetHomeData extends UserState {}

class ErorrGetHomeData extends UserState {
  final String error;
  ErorrGetHomeData(this.error);
}

class LoadingEditUser extends UserState {}

class ScEditUser extends UserState {}

class ErorrEditUser extends UserState {
  final String error;
  ErorrEditUser(this.error);
}

class LoadingSetExerciseAsRead extends UserState {
  final String id;
  LoadingSetExerciseAsRead(this.id);
}

class ScSetExerciseAsRead extends UserState {}

class ErorrSetExerciseAsRead extends UserState {
  final String error;
  ErorrSetExerciseAsRead(this.error);
}

class LoadingSetAllExerciseAsRead extends UserState {}

class ScSetAllExerciseAsRead extends UserState {}

class ErorrSetAllExerciseAsRead extends UserState {
  final String error;
  ErorrSetAllExerciseAsRead(this.error);
}
