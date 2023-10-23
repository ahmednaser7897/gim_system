import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_assets.dart';
import 'package:gim_system/ui/componnents/widgets.dart';
import 'package:gim_system/app/extensions.dart';
import '../../controller/admin/admin_cubit.dart';
import '../../model/admin_model.dart';
import '../../model/coach_model.dart';
import '../../model/gym_model.dart';
import '../../model/user_model.dart';
import '../admin/admins/admin_details_screen.dart';
import '../admin/gyms_screen/gym_details_screen.dart';
import '../gym/coachs/coach_details_screen.dart';
import '../gym/usres/user_details_screen.dart';

class ShowUsersScreen extends StatelessWidget {
  const ShowUsersScreen(
      {super.key, required this.canEdit, required this.users});
  final List<UserModel> users;
  final bool canEdit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: buildusersList(users: users, canEdit: canEdit),
    );
  }
}

class ShowCoachsScreen extends StatelessWidget {
  const ShowCoachsScreen(
      {super.key, required this.coachs, required this.canEdit});
  final List<CoachModel> coachs;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coachs'),
      ),
      body: buildCoachsList(coachs: coachs, canEdit: canEdit),
    );
  }
}

Widget buildAdminList(List<AdminModel> admins) {
  return Builder(builder: (context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      itemCount: admins.length,
      itemBuilder: (context, index) {
        return BlocConsumer<AdminCubit, AdminState>(
          listener: (context, state) {},
          builder: (context, state) {
            return buildHomeItem(
              ban: admins[index].ban.orFalse(),
              name: admins[index].name.orEmpty(),
              des: admins[index].email.orEmpty(),
              image: admins[index].image,
              id: admins[index].id.orEmpty(),
              assetImage: AppAssets.admin,
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminDetailsScreen(
                      adminModel: admins[index],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  });
}

Widget buildgymList({required List<GymModel> gyms, bool canEdit = true}) {
  return Builder(builder: (context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      itemCount: gyms.length,
      itemBuilder: (context, index) {
        return BlocConsumer<AdminCubit, AdminState>(
          listener: (context, state) {},
          builder: (context, state) {
            return buildHomeItem(
              ban: gyms[index].ban.orFalse(),
              name: gyms[index].name.orEmpty(),
              des: gyms[index].email.orEmpty(),
              id: gyms[index].id.orEmpty(),
              image: gyms[index].image,
              assetImage: AppAssets.gym,
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GymDetailsScreen(
                      gymModel: gyms[index],
                      canEdit: canEdit,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  });
}

Widget buildusersList({required List<UserModel> users, bool canEdit = true}) {
  return Builder(builder: (context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      itemCount: users.orEmpty().length,
      itemBuilder: (context, index) {
        return buildHomeItem(
          ban: users.orEmpty()[index].ban.orFalse(),
          name: users.orEmpty()[index].name.orEmpty(),
          des: users.orEmpty()[index].email.orEmpty(),
          image: users.orEmpty()[index].image,
          id: users[index].id.orEmpty(),
          assetImage: AppAssets.gym,
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserDetailsScreen(
                  model: users.orEmpty()[index],
                  canEdit: canEdit,
                ),
              ),
            );
          },
        );
      },
    );
  });
}

Widget buildCoachsList(
    {required List<CoachModel> coachs,
    bool canEdit = true,
    bool isUser = false}) {
  return Builder(builder: (context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      itemCount: coachs.orEmpty().length,
      itemBuilder: (context, index) {
        return buildHomeItem(
          ban: coachs.orEmpty()[index].ban.orFalse(),
          name: coachs.orEmpty()[index].name.orEmpty(),
          des: coachs.orEmpty()[index].email.orEmpty(),
          image: coachs.orEmpty()[index].image,
          id: coachs[index].id.orEmpty(),
          assetImage: AppAssets.user,
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CoachDetailsScreen(
                  coachModel: coachs.orEmpty()[index],
                  canEdit: canEdit,
                  isUser: isUser,
                ),
              ),
            );
          },
        );
      },
    );
  });
}
