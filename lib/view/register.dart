import 'package:aplikasi_catatan/components/regular_textfield.dart';
import 'package:aplikasi_catatan/components/top_bar.dart';
import 'package:aplikasi_catatan/components/regular_button.dart';
import 'package:aplikasi_catatan/components/regular_card.dart';
import 'package:aplikasi_catatan/components/regular_text.dart';
import 'package:aplikasi_catatan/view/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_validator/form_validator.dart';

import '../bloc/auth/auth_bloc.dart';

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
    return Scaffold(
    appBar: MyAppBar.simple('back'),
    body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                    validator: ValidationBuilder().minLength(3).build(),
                    controller: _username,
                    hintText: 'Example: John Doe',
                  ),
                  SizedBox(height: 16),
          
                  RegularText('Email Adsress'),
                  SizedBox(height: 8),
                  RegularTextfield.text(
                    validator: ValidationBuilder().email().build(),
                    controller: _emailController,
                    hintText: 'Example: johndoe@gmail.com',
                  ),
                  SizedBox(height: 16),
          
                  RegularText('Password'),
                  SizedBox(height: 8),
                  RegularTextfield.pass(
                    validator: ValidationBuilder().minLength(6).build(),
                    controller: _passwordController,
                    hintText: "********",
                  ),
          
                  SizedBox(height: 40),
                  RegularButton.filled(
                    'Register',
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        context.read<AuthBloc>().add(
                          RegisterAuthEvent(
                            name: _username.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                        EasyLoading.showSuccess('Registrasi berhasil!');
                      } else {
                        EasyLoading.showToast('Data belum lengkap!');
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
    );
  }
}
