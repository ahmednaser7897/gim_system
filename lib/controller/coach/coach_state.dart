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

class LoadingUpdateUserFitnessInfo extends CoachState {}

class ScUpdateUserFitnessInfo extends CoachState {}

class ErorrUpdateUserFitnessInfo extends CoachState {
  final String error;
  ErorrUpdateUserFitnessInfo(this.error);
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

class LoadingCoachSendMessage extends CoachState {}

class ScCoachSendMessage extends CoachState {}

class ErorrCoachSendMessage extends CoachState {
  final String error;
  ErorrCoachSendMessage(this.error);
}

class LoadingCoachGetdMessages extends CoachState {}

class ScCoachGetdMessages extends CoachState {}

class ErorrCoachGetdMessages extends CoachState {
  final String error;
  ErorrCoachGetdMessages(this.error);
}

class LoadingUploadFile extends CoachState {}

class ScUploadFile extends CoachState {}

class ErorrUploadFile extends CoachState {
  final String error;
  ErorrUploadFile(this.error);
}
