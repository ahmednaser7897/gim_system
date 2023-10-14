import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/extensions.dart';

import '../../../app/app_sized_box.dart';
import '../../../controller/user/user_cubit.dart';
import '../../componnents/screen_builder.dart';
import '../../componnents/widgets.dart';
import '../../gym/home_screens/coach_details_screen.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      buildWhen: (previous, current) =>
          current is LoadingGetHomeData ||
          current is ScGetHomeData ||
          current is ErorrGetHomeData,
      listener: (context, state) {},
      builder: (context, state) {
        UserCubit cubit = UserCubit.get(context);
        return screenBuilder(
          contant: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSizedBox.h1,
                    const Text(
                      "Coach :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    AppSizedBox.h2,
                    buildCoachsList(),
                    AppSizedBox.h2,
                  ],
                ),
              ),
            ),
          ),
          isEmpty: false,
          isErorr: state is ErorrGetHomeData,
          isLoading: state is LoadingGetHomeData,
          isSc: state is ScGetHomeData || cubit.coachs.isNotEmpty,
        );
      },
    );
  }

  Widget buildCoachsList() {
    return Builder(builder: (context) {
      var cubit = UserCubit.get(context);
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        itemCount: cubit.coachs.length,
        itemBuilder: (context, index) {
          return BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {},
            builder: (context, state) {
              return buildHomeItem(
                ban: cubit.coachs[index].ban.orFalse(),
                name: cubit.coachs[index].name.orEmpty(),
                des: cubit.coachs[index].email.orEmpty(),
                image: cubit.coachs[index].image,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoachDetailsScreen(
                        coachModel: cubit.coachs[index],
                        canEdit: false,
                        isUser: true,
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
