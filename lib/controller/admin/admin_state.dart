part of 'admin_cubit.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class LoadingGetAdmin extends AdminState {}

class ScGetAdmin extends AdminState {}

class ErorrGetAdmin extends AdminState {
  final String error;
  ErorrGetAdmin(this.error);
}
