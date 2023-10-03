import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/extensions.dart';

import '../../../app/app_colors.dart';
import '../../../app/icon_broken.dart';
import '../../../controller/gym/gym_cubit.dart';
import '../../componnents/log_out_button.dart';
import '../../componnents/screen_builder.dart';
import '../add_new_coach_screen.dart';
import '../add_new_exercises.dart';
import '../add_new_user_screen.dart';
import '../edit_gym_screen.dart';

class GymSettingsScreen extends StatefulWidget {
  const GymSettingsScreen({super.key});

  @override
  State<GymSettingsScreen> createState() => _GymSettingsScreenState();
}

class _GymSettingsScreenState extends State<GymSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit, GymState>(
      buildWhen: (previous, current) =>
          current is LoadingGetGym ||
          current is ScGetGym ||
          current is ErorrGetGym,
      listener: (context, state) {},
      builder: (context, state) {
        GymCubit cubit = GymCubit.get(context);
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
                          if (cubit.gymModel!.image != null &&
                              cubit.gymModel!.image!.isNotEmpty)
                            Container(
                              width: 20.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(cubit.gymModel!.image!),
                                ),
                              ),
                            ),
                          AppSizedBox.w5,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cubit.gymModel!.name.orEmpty(),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              AppSizedBox.h3,
                              Text(
                                cubit.gymModel!.email.orEmpty(),
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
                          var value = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditGymScreen(),
                              ));
                          if (value == 'edit') {
                            await cubit.getCurrentGymData();
                            //await cubit.getHomeData();
                          }
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
              _buildListItem(
                context,
                title: 'New coach',
                leadingIcon: IconBroken.Profile,
                subtitle: 'Create new coach account',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddNewCoachScreen(),
                      ));
                },
              ),
              _buildListItem(
                context,
                title: 'New User',
                leadingIcon: IconBroken.Profile,
                subtitle: 'Create new User account',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddNewUserScreen(),
                      ));
                },
              ),
              _buildListItem(
                context,
                title: 'New Exercise',
                leadingIcon: Icons.sports_gymnastics,
                subtitle: 'Create new Exercise',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddNewExercisesScreen(),
                      ));
                },
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
          isErorr: state is ErorrGetGym,
          isLoading: state is LoadingGetGym,
          isSc: state is ScGetGym || cubit.gymModel != null,
        );
      },
    );
  }

  Widget _buildListItem(BuildContext context,
      {required String title,
      required IconData leadingIcon,
      IconData? tailIcon,
      String? subtitle,
      Function()? onTap}) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      dense: true,
      splashColor: AppColors.primerColor.withOpacity(0.2),
      style: ListTileStyle.list,
      leading: Icon(
        leadingIcon,
        color: AppColors.primerColor,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(subtitle ?? ''),
      trailing: Icon(tailIcon),
    );
  }
}
