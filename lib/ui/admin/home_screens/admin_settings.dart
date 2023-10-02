import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/extensions.dart';

import '../../../app/app_colors.dart';
import '../../../app/icon_broken.dart';
import '../../../controller/admin/admin_cubit.dart';
import '../../componnents/log_out_button.dart';
import '../../componnents/screen_builder.dart';
import '../add_new_admin_screen.dart';
import '../add_new_gym_screen.dart';
import '../edit_admin_screen.dart';

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      buildWhen: (previous, current) =>
          current is LoadingGetAdmin ||
          current is ScGetAdmin ||
          current is ErorrGetAdmin,
      listener: (context, state) {},
      builder: (context, state) {
        AdminCubit cubit = AdminCubit.get(context);
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
                          if (cubit.adminModel!.image != null &&
                              cubit.adminModel!.image!.isNotEmpty)
                            Container(
                              width: 20.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(cubit.adminModel!.image!),
                                ),
                              ),
                            ),
                          AppSizedBox.w5,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cubit.adminModel!.name.orEmpty(),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              AppSizedBox.h3,
                              Text(
                                cubit.adminModel!.email.orEmpty(),
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const EditNewAdminScreen(),
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
              _buildListItem(
                context,
                title: 'New admin',
                leadingIcon: IconBroken.Profile,
                subtitle: 'Create new admin account',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddNewAdminScreen(),
                      ));
                },
              ),
              _buildListItem(
                context,
                title: 'New Gym',
                leadingIcon: IconBroken.Profile,
                subtitle: 'Create new Gym account',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddNewGymScreen(),
                      ));
                },
              ),
              const Spacer(),
              const LogOutButton(),
              AppSizedBox.h3,
            ],
          ),
          isEmpty: false,
          isErorr: state is ErorrGetAdmin,
          isLoading: state is LoadingGetAdmin,
          isSc: state is ScGetAdmin || cubit.adminModel != null,
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
