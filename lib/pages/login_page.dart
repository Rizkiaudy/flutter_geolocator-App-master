import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geolocator_app/constants.dart';
import 'package:flutter_geolocator_app/cubit/auth_cubit.dart';
import 'package:flutter_geolocator_app/widgets/custom_text_form_field.dart';
import 'package:flutter_geolocator_app/widgets/my_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    Widget myFormSection() {
      return Column(
        children: [
          CustomTextFormField(
            title: "Username",
            hintText: "Masukkan Username",
            controller: usernameController,
          ),
          CustomTextFormField(
            title: "Password",
            hintText: "Masukkan Password",
            controller: passwordController,
            isPassword: true,
          ),
          // Container(
          //   width: double.infinity,
          //   child: Text(
          //     "Forgot Password?",
          //     style: orangeTextStyle.copyWith(
          //       fontSize: 11,
          //       fontWeight: semiBold,
          //     ),
          //     textAlign: TextAlign.end,
          //   ),
          // )
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: defaultMargin),
              Container(
                width: double.infinity,
                child: Text(
                  "Sign In",
                  style: titleTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 64, vertical: defaultMargin),
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/logo.png"),
                    ),
                  ),
                ),
              ),
              myFormSection(),
              SizedBox(height: defaultMargin),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'main-page', (route) => false);
                  } else if (state is AuthFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        // backgroundColor: kGreenLightColor,
                        content: Text(state.error),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return MyButton(
                    onTap: () {
                      context.read<AuthCubit>().signIn(
                            email: usernameController.text,
                            password: passwordController.text,
                          );
                      // ApiService().login(
                      //     usernameController.text, passwordController.text);
                      // Navigator.pushNamedAndRemoveUntil(
                      //     context, 'main-page', (route) => false);
                    },
                    title: "Login",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
