part of 'coach_cubit.dart';

abstract class CoachState {}

class CoachInitial extends CoachState {}

class LoadingChangeHomeIndex extends CoachState {}

class ScChangeHomeIndex extends CoachState {}

class LoadingGetCoach extends CoachState {}

class ScGetCoach extends CoachState {}

class ErorrGetCoach extends CoachState {
  final String error;
  ErorrGetCoach(this.error);
}

class LoadingAddDite extends CoachState {}

class ScAddDite extends CoachState {}

class ErorrAddDite extends CoachState {
  final String error;
  ErorrAddDite(this.error);
}

class LoadingAddExercise extends CoachState {}

class ScAddExercise extends CoachState {}

class ErorrAddExercise extends CoachState {
  final String error;
  ErorrAddExercise(this.error);
}

class LoadingEditExercise extends CoachState {}

class ScEditExercise extends CoachState {}

class ErorrEditExercise extends CoachState {
  final String error;
  ErorrEditExercise(this.error);
}

class LoadingGetHomeData extends CoachState {}

class ScGetHomeData extends CoachState {}

class ErorrGetHomeData extends CoachState {
  final String error;
  ErorrGetHomeData(this.error);
}

class LoadingEditCoach extends CoachState {}

class ScEditCoach extends CoachState {}

class ErorrEditCoach extends CoachState {
  final String error;
  ErorrEditCoach(this.error);
}

class LoadingChangeUserBan extends CoachState {}

class ScChangeUserBan extends CoachState {}

class ErorrChangeUserBan extends CoachState {
  final String error;
  ErorrChangeUserBan(this.error);
}

class LoadingChangeCoachBan extends CoachState {}

class ScChangeCoachBan extends CoachState {}

class ErorrChangeCoachBan extends CoachState {
  final String error;
  ErorrChangeCoachBan(this.error);
}
