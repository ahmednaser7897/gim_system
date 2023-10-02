import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_prefs.dart';
import 'package:gim_system/app/constants.dart';
import 'package:gim_system/model/users_models.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
  static AdminCubit get(context) => BlocProvider.of(context);
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
}
