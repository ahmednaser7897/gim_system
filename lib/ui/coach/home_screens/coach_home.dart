import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/extensions.dart';

import '../../../app/app_assets.dart';
import '../../../app/app_sized_box.dart';
import '../../../controller/coach/coach_cubit.dart';
import '../../componnents/screen_builder.dart';
import '../../componnents/widgets.dart';
import '../../gym/coachs/coach_details_screen.dart';

class CochHome extends StatefulWidget {
  const CochHome({super.key});

  @override
  State<CochHome> createState() => _CochHomeState();
}

class _CochHomeState extends State<CochHome> {
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
      var cubit = CoachCubit.get(context);
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        itemCount: cubit.coachs.length,
        itemBuilder: (context, index) {
          return BlocConsumer<CoachCubit, CoachState>(
            listener: (context, state) {},
            builder: (context, state) {
              return buildHomeItem(
                ban: cubit.coachs[index].ban.orFalse(),
                name: cubit.coachs[index].name.orEmpty(),
                des: cubit.coachs[index].email.orEmpty(),
                id: cubit.coachs[index].id.orEmpty(),
                image: cubit.coachs[index].image,
                assetImage: AppAssets.coach,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoachDetailsScreen(
                        coachModel: cubit.coachs[index],
                        canEdit: false,
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
