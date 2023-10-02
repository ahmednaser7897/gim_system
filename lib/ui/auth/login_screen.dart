import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gim_system/app/app_assets.dart';
import 'package:gim_system/app/app_sized_box.dart';
import 'package:gim_system/app/app_validation.dart';
import 'package:gim_system/app/extensions.dart';
import 'package:gim_system/ui/admin/home_screens/admin_home_screen.dart';

import '../../controller/auth/auth_cubit.dart';
import '../componnents/const_widget.dart';
import '../componnents/show_flutter_toast.dart';
import 'widgets/build_auth_bottom.dart';
import 'widgets/build_text_form_filed.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =
      TextEditingController(text: 'ahmednaser7897@gmail.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthGetUserAfterLoginSuccessState) {
            showFlutterToast(
              message: 'Login Successfully ${state.message}',
              toastColor: Colors.green,
            );
            if (state.message == 'admin') {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminHomeScreen(),
                ),
                (route) => false,
              );
            }
            //else if (state.message == 'parent') {
            //     Navigator.pushNamedAndRemoveUntil(
            //       context,
            //       Routers.PARENTS_LAYOUT_SCREEN,
            //       (route) => false,
            //     );
            //   } else if (state.message == 'teacher') {
            //     Navigator.pushNamedAndRemoveUntil(
            //       context,
            //       Routers.TEACHERS_LAYOUT_SCREEN,
            //       (route) => false,
            //     );
            //   } else if (state.message == 'supervisor') {
            //     Navigator.pushNamedAndRemoveUntil(
            //         context, Routers.SUPERVISORS_LAYOUT_SCREEN, (route) => false);
            //   }
            // }
            // if (state is AuthGetUserAfterLoginErrorState) {
            //   showFlutterToast(
            //     message: state.error,
            //     toastColor: Colors.red,
            //   );
          }
        },
        builder: (context, state) {
          AuthCubit authCubit = AuthCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 70.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppAssets.appLogo),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        AppSizedBox.h5,
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormFiledComponent(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                hintText: 'Email',
                                prefixIcon: Icons.email,
                                validate: (value) {
                                  return Validations.emailValidation(value,
                                      name: 'your email');
                                  // if (value!.isEmpty) {
                                  //   return 'Please enter your email';
                                  // }
                                  // if (!value.contains('@')) {
                                  //   return 'Please enter a valid email';
                                  // }

                                  // return null;
                                },
                              ),
                              AppSizedBox.h3,
                              TextFormFiledComponent(
                                controller: passwordController,
                                keyboardType: TextInputType.text,
                                hintText: 'Password',
                                prefixIcon: Icons.lock,
                                suffixIcon: Icons.visibility,
                                obscureText: true,
                                validate: (value) {
                                  return Validations.passwordValidation(value,
                                      name: ' your password');
                                  // if (value!.isEmpty) {
                                  //   return 'Please enter your password';
                                  // }
                                  // return null;
                                },
                              ),
                              AppSizedBox.h5,
                              state is AuthGetUserAfterLoginLoadingState
                                  ? const CircularProgressComponent()
                                  : BottomComponent(
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          authCubit.userMakLogin(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                        }
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
