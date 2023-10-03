part of 'gym_cubit.dart';

abstract class GymState {}

class GymInitial extends GymState {}

class LoadingChangeHomeIndex extends GymState {}

class ScChangeHomeIndex extends GymState {}

class LoadingGetGym extends GymState {}

class ScGetGym extends GymState {}

class ErorrGetGym extends GymState {
  final String error;
  ErorrGetGym(this.error);
}

class LoadingAddUser extends GymState {}

class ScAddUser extends GymState {}

class ErorrAddUser extends GymState {
  final String error;
  ErorrAddUser(this.error);
}

class LoadingAddCoach extends GymState {}

class ScAddCoach extends GymState {}

class ErorrAddCoach extends GymState {
  final String error;
  ErorrAddCoach(this.error);
}

class LoadingAddExercise extends GymState {}

class ScAddExercise extends GymState {}

class ErorrAddExercise extends GymState {
  final String error;
  ErorrAddExercise(this.error);
}

class LoadingGetHomeData extends GymState {}

class ScGetHomeData extends GymState {}

class ErorrGetHomeData extends GymState {
  final String error;
  ErorrGetHomeData(this.error);
}

class LoadingEditGym extends GymState {}

class ScEditGym extends GymState {}

class ErorrEditGym extends GymState {
  final String error;
  ErorrEditGym(this.error);
}

class LoadingChangeUserBan extends GymState {}

class ScChangeUserBan extends GymState {}

class ErorrChangeUserBan extends GymState {
  final String error;
  ErorrChangeUserBan(this.error);
}

class LoadingChangeCoachBan extends GymState {}

class ScChangeCoachBan extends GymState {}

class ErorrChangeCoachBan extends GymState {
  final String error;
  ErorrChangeCoachBan(this.error);
}
