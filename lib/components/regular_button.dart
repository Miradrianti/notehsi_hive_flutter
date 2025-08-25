import 'package:flutter/material.dart';

class RegularButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonStyle style;
  final Widget Function({
    required VoidCallback? onPressed,
    required Widget child,
    required ButtonStyle? style,
  }) builder;

  const RegularButton._({
    required this.label,
    required this.onPressed,
    required this.style,
    required this.builder,
  });

  factory RegularButton.filled(String label,{required VoidCallback onPressed, bool isEnabled = true}) {
    return RegularButton._(
      label: label, 
      onPressed: isEnabled ? onPressed: (){}, 
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        backgroundColor: isEnabled ? Color.fromRGBO(57, 70, 117, 1) : Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ), 
      builder: ({required onPressed, required child, required style}) => FilledButton(
        onPressed: isEnabled ? onPressed : null, 
        style: style,
        child: child,),
      );
  }

factory RegularButton.text(String label,{required VoidCallback onPressed, bool isEnabled = true}) {
    return RegularButton._(
      label: label, 
      onPressed: isEnabled ? onPressed: (){}, 
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Color.fromRGBO(57, 70, 117, 1),
        minimumSize: const Size(double.infinity, 48),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ), 
      builder: ({required onPressed, required child, required style}) => FilledButton(
        onPressed: isEnabled ? onPressed : null, 
        style: style,
        child: child,),
      );
  }
  
  @override
  Widget build(BuildContext context) {
    return builder(
      onPressed: onPressed,
      style: style,
      child: Text(label),
    );
  }
}