part of 'admin_cubit.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class LoadingChangeHomeIndex extends AdminState {}

class ScChangeHomeIndex extends AdminState {}

class LoadingGetAdmin extends AdminState {}

class ScGetAdmin extends AdminState {}

class ErorrGetAdmin extends AdminState {
  final String error;
  ErorrGetAdmin(this.error);
}

class LoadingAddGym extends AdminState {}

class ScAddGym extends AdminState {}

class ErorrAddGym extends AdminState {
  final String error;
  ErorrAddGym(this.error);
}

class LoadingAddAdmin extends AdminState {}

class ScAddAdmin extends AdminState {}

class ErorrAddAdmin extends AdminState {
  final String error;
  ErorrAddAdmin(this.error);
}

class LoadingGetHomeData extends AdminState {}

class ScGetHomeData extends AdminState {}

class ErorrGetHomeData extends AdminState {
  final String error;
  ErorrGetHomeData(this.error);
}

class LoadingEditAdmin extends AdminState {}

class ScEditAdmin extends AdminState {}

class ErorrEditAdmin extends AdminState {
  final String error;
  ErorrEditAdmin(this.error);
}

class LoadingChangeGymBan extends AdminState {}

class ScChangeGymBan extends AdminState {}

class ErorrChangeGymBan extends AdminState {
  final String error;
  ErorrChangeGymBan(this.error);
}

class LoadingChangeAdminBan extends AdminState {}

class ScChangeAdminBan extends AdminState {}

class ErorrChangeAdminBan extends AdminState {
  final String error;
  ErorrChangeAdminBan(this.error);
}
