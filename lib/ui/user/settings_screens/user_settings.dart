import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/ui/admin/home_screens/gym_details_screen.dart';

import '../../../app/app_colors.dart';
import '../../../app/icon_broken.dart';
import '../../../controller/user/user_cubit.dart';
import '../../coach/home_screens/show_user_diets.dart';
import '../../componnents/log_out_button.dart';
import '../../componnents/screen_builder.dart';
import '../../componnents/widgets.dart';
import 'edit_user_screen.dart';
import 'show_and_edit_user_exercises.dart';
import 'show_user_fitness_Info.dart';

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      buildWhen: (previous, current) =>
          current is LoadingGetUser ||
          current is ScGetUser ||
          current is ErorrGetUser,
      listener: (context, state) {},
      builder: (context, state) {
        UserCubit cubit = UserCubit.get(context);
        return screenBuilder(
          contant: Column(
            children: [
              SizedBox(
                width: 100.w,
                height: 20.h,
                child: Stack(
                  children: [
                    Container(
                      width: 100.w,
                      height: 20.h,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (cubit.userModel!.image != null &&
                              cubit.userModel!.image!.isNotEmpty)
                            Container(
                              width: 20.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(cubit.userModel!.image!),
                                ),
                              ),
                            ),
                          AppSizedBox.w5,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cubit.userModel!.name.orEmpty(),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              AppSizedBox.h3,
                              Text(
                                cubit.userModel!.email.orEmpty(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 100.w,
                      height: 20.h,
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditUserScreen(),
                              ));
                        },
                        icon: const Icon(
                          IconBroken.Edit,
                          color: AppColors.primerColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              AppSizedBox.h3,
              settingbuildListItem(
                context,
                title: 'Fitness Info',
                leadingIcon: Icons.sports_gymnastics,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowUserFitnessInfo(
                          model: cubit.userModel!,
                        ),
                      ));
                },
                subtitle: 'Show your Fitness Info',
              ),
              settingbuildListItem(
                context,
                title: 'My Gym',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GymDetailsScreen(
                          gymModel: cubit.gymModel!,
                          canEdit: false,
                        ),
                      ));
                },
                leadingIcon: Icons.sports_gymnastics,
                subtitle: 'Show your gym info',
              ),
              settingbuildListItem(
                context,
                title: 'Exercises',
                leadingIcon: Icons.sports_gymnastics,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowAndEditUserExercises(
                          user: cubit.userModel!,
                        ),
                      ));
                },
                subtitle: 'Show your Exercises',
              ),
              settingbuildListItem(
                context,
                title: 'Dites',
                leadingIcon: Icons.food_bank,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowUserDites(
                          user: cubit.userModel!,
                        ),
                      ));
                },
                subtitle: 'Show your Dites',
              ),
              const Spacer(),
              LogOutButton(
                onTap: () {
                  cubit.changeBottomNavBar(0);
                },
              ),
              AppSizedBox.h3,
            ],
          ),
          isEmpty: false,
          isErorr: state is ErorrGetUser,
          isLoading: state is LoadingGetUser,
          isSc: state is ScGetUser || cubit.userModel != null,
        );
      },
    );
  }
}
