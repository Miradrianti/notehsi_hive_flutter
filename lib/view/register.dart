import 'package:aplikasi_catatan/components/regular_textfield.dart';
import 'package:aplikasi_catatan/components/top_bar.dart';
import 'package:aplikasi_catatan/components/regular_button.dart';
import 'package:aplikasi_catatan/components/regular_card.dart';
import 'package:aplikasi_catatan/components/regular_text.dart';
import 'package:aplikasi_catatan/view/home.dart';
import 'package:aplikasi_catatan/view/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../bloc/auth/auth_bloc.dart';
import '../enum/status_enum.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const String routeName = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _username = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == StatusEnum.loading) {
          EasyLoading.show(status: 'Loading...');
        }
        if (state.status == StatusEnum.failure) {
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
        appBar: MyAppBar.simple('back'),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RegularCard(
                  children: [
                    RegularText.title("Register"),
                    SizedBox(height: 16),
                    RegularText.description('And start taking notes'),
                    SizedBox(height: 32),
            
                    RegularText('Full Name'),
                    SizedBox(height: 8),
                    RegularTextfield.text(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      controller: _username,
                      hintText: 'Example: John Doe',
                    ),
                    SizedBox(height: 16),
            
                    RegularText('Email Adsress'),
                    SizedBox(height: 8),
                    RegularTextfield.text(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      controller: _emailController,
                      hintText: 'Example: johndoe@gmail.com',
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
            
                    SizedBox(height: 40),
                    RegularButton.filled(
                      'Register',
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<AuthBloc>().add(
                            RegisterAuthEvent(
                              name: _username.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                          EasyLoading.showSuccess('Register berhasil!');
                        } else {
                          EasyLoading.showError('Data belum lengkap!');
                        }
                      }
                    ),
                    SizedBox(height: 16),
                    RegularButton.text(
                      'Don’t have any account? Login here',
                      onPressed: () { 
                        Navigator.pushNamed(context, LoginPage.routeName);
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
