import 'package:aplikasi_catatan/bloc/note/note_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../bloc/auth/auth_bloc.dart';
import '../view/login.dart';
import 'route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => NoteBloc()),
      ],
      child: MaterialApp(
        title: 'HSI Note',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoute.routes,
        home: LoginPage(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
