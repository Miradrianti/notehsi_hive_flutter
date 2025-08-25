import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  
  const MyAppBar({
    super.key,
    this.onBackPressed,
    this.title,
    this.showBackButton = true,
    this.actions,
    this.customTitle,
    this.titleStyle,
  });

  final VoidCallback? onBackPressed;
  final String? title;
  final bool showBackButton;
  final List<Widget>? actions;
  final Widget? customTitle;
  final TextStyle? titleStyle;

  factory MyAppBar.simple(String title, {
    VoidCallback? onBackPressed,
    TextStyle? titleStyle,
  }) {
    return MyAppBar(
      title: title,
      showBackButton: true,
      onBackPressed: onBackPressed,
      titleStyle: titleStyle,
    );
  }

  factory MyAppBar.home({
    VoidCallback? onLogoutPressed,
  }) {
    return MyAppBar(
      customTitle: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // final email = state.user?.email ?? "User";
          return Text('');
        }
      ),
      showBackButton: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: onLogoutPressed,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
      title: customTitle ?? 
        (title != null 
        ? Text(title!,
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(57, 70, 117, 1),
          ).merge(titleStyle),
          ) 
        : null),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}