import 'package:flutter/material.dart';

class RegularTextfield extends StatefulWidget {
  const RegularTextfield({
    super.key, 
    required this.hintText, 
    this.obscureText = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.border = InputBorder.none,
    this.textStyle = const TextStyle(),
    this.validator,
  });
  

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final InputBorder border;
  final TextStyle textStyle;
  final FormFieldValidator<String>? validator;

  

  factory RegularTextfield.pass({
    required String hintText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    required validator,
  }) {
    return RegularTextfield(
      hintText: hintText,
      obscureText: true,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
      )
    );
  }

  factory RegularTextfield.text({
    required String hintText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    required validator,
  }) {
    return RegularTextfield(
      hintText: hintText,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
      )
    );
  }

  factory RegularTextfield.title({
    required String hintText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    required InputBorder border,
  }) {
    return RegularTextfield(
      hintText: hintText,
      obscureText: true,
      controller: controller,
      keyboardType: keyboardType,
      border: InputBorder.none,
      textStyle: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold
      ),
    );
  }

  @override
  State<RegularTextfield> createState() => _RegularTextfieldState();
}

class _RegularTextfieldState extends State<RegularTextfield> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.grey
        ),
        border: widget.border
      )
    );
  }
}