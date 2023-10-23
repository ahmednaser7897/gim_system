import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/ui/coach/users/user_details_from_coach_screen.dart';

import '../../../app/app_assets.dart';
import '../../../app/app_sized_box.dart';
import '../../../controller/coach/coach_cubit.dart';
import '../../componnents/screen_builder.dart';
import '../../componnents/widgets.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoachCubit, CoachState>(
      buildWhen: (previous, current) =>
          current is LoadingGetHomeData ||
          current is ScGetHomeData ||
          current is ErorrGetHomeData,
      listener: (context, state) {},
      builder: (context, state) {
        CoachCubit cubit = CoachCubit.get(context);
        return screenBuilder(
          contant: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildUserList(),
                    AppSizedBox.h2,
                  ],
                ),
              ),
            ),
          ),
          isEmpty: false,
          isErorr: state is ErorrGetHomeData,
          isLoading: state is LoadingGetHomeData,
          isSc: state is ScGetHomeData || cubit.users.isNotEmpty,
        );
      },
    );
  }

  Widget buildUserList() {
    return Builder(builder: (context) {
      var cubit = CoachCubit.get(context);
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        itemCount: cubit.users.length,
        itemBuilder: (context, index) {
          return BlocConsumer<CoachCubit, CoachState>(
            listener: (context, state) {},
            builder: (context, state) {
              return buildHomeItem(
                ban: cubit.users[index].ban.orFalse(),
                name: cubit.users[index].name.orEmpty(),
                des: cubit.users[index].email.orEmpty(),
                image: cubit.users[index].image,
                id: cubit.users[index].id.orEmpty(),
                assetImage: AppAssets.user,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsFromCoachScreen(
                        model: cubit.users[index],
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
}
