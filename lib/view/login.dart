import 'package:aplikasi_catatan/components/regular_button.dart';
import 'package:aplikasi_catatan/components/regular_card.dart';
import 'package:aplikasi_catatan/components/regular_text.dart';
import 'package:aplikasi_catatan/components/regular_textfield.dart';
import 'package:aplikasi_catatan/enum/status_enum.dart';
import 'package:aplikasi_catatan/view/home.dart';
import 'package:aplikasi_catatan/view/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../bloc/auth/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == StatusEnum.loading) {
          EasyLoading.show(status: 'Loading...');
        }
        if (state.status == StatusEnum.failure) {
          EasyLoading.dismiss();
          EasyLoading.showToast(state.error.toString());
        }
        if (state.status == StatusEnum.success) {
          EasyLoading.dismiss();
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomePage.routeName,
            (_) => false,
          );
        }
      },
      child: Scaffold(
        body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RegularCard(
                      children: [
                        RegularText.title("Let's Login"),
                        SizedBox(height: 16),
                        RegularText.description('And notes your idea'),
                        SizedBox(height: 32),
                        RegularText('Email Address'),
                        SizedBox(height: 8),
                        RegularTextfield.text(
                          controller: _emailController,
                          hintText: 'example@mail.com',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        RegularText('Password'),
                        SizedBox(height: 8),
                        RegularTextfield.pass(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                            return null;
                          },
                          controller: _passwordController,
                          hintText: "********",
                        ),
                        SizedBox(height: 8),
                        RegularText(''),
                        SizedBox(height: 40),
                        RegularButton.filled(
                          'Login',
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              LoginAuthEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 16),

                        RegularButton.text(
                          'Don’t have any account? Register here',
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RegisterPage.routeName,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
