import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/ui/coach/settings_screens/edit_Coach_screen.dart';

import '../../../app/app_colors.dart';
import '../../../app/icon_broken.dart';
import '../../../controller/coach/coach_cubit.dart';
import '../../admin/gyms_screen/gym_details_screen.dart';
import '../../componnents/log_out_button.dart';
import '../../componnents/screen_builder.dart';
import '../../componnents/widgets.dart';

class CoachSettingsScreen extends StatefulWidget {
  const CoachSettingsScreen({super.key});

  @override
  State<CoachSettingsScreen> createState() => _CoachSettingsScreenState();
}

class _CoachSettingsScreenState extends State<CoachSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoachCubit, CoachState>(
      buildWhen: (previous, current) =>
          current is LoadingGetCoach ||
          current is ScGetCoach ||
          current is ErorrGetCoach,
      listener: (context, state) {},
      builder: (context, state) {
        CoachCubit cubit = CoachCubit.get(context);
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
                          if (cubit.coachModel!.image != null &&
                              cubit.coachModel!.image!.isNotEmpty)
                            Container(
                              width: 20.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(cubit.coachModel!.image!),
                                ),
                              ),
                            ),
                          AppSizedBox.w5,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cubit.coachModel!.name.orEmpty(),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              AppSizedBox.h3,
                              Text(
                                cubit.coachModel!.email.orEmpty(),
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
                                builder: (context) => const EditCoachScreen(),
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
              // settingbuildListItem(
              //   context,
              //   title: 'Phone',
              //   leadingIcon: Icons.phone,
              //   subtitle: cubit.coachModel!.phone.orEmpty(),
              // ),
              // settingbuildListItem(
              //   context,
              //   title: 'age',
              //   leadingIcon: Icons.timelapse,
              //   subtitle: cubit.coachModel!.age.orEmpty(),
              // ),
              // settingbuildListItem(
              //   context,
              //   title: 'gender',
              //   leadingIcon: Icons.person,
              //   subtitle: cubit.coachModel!.gender.orEmpty(),
              // ),
              // settingbuildListItem(
              //   context,
              //   title: 'Bio',
              //   leadingIcon: Icons.biotech,
              //   subtitle: cubit.coachModel!.bio.orEmpty(),
              // ),
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
          isErorr: state is ErorrGetCoach,
          isLoading: state is LoadingGetCoach,
          isSc: state is ScGetCoach || cubit.coachModel != null,
        );
      },
    );
  }
}
