import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rootics_final/theme/app_colors.dart';

class CustomTextForm extends StatelessWidget {
  final String lable;
  final TextEditingController myController;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final Widget? preffix;
  final bool? obscureText;
  const CustomTextForm(
      {super.key,
      required this.lable,
      required this.myController,
      this.keyboardType,
      this.validator,
      this.suffix,
      this.preffix, this.obscureText = false,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: myController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors().darkGreen, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors().darkGreen, width: 2)),
        //label: Text(),
        fillColor: AppColors().lightGreen.withOpacity(0.6),
        filled: true,
        labelText: lable,
        labelStyle: TextStyle(color: AppColors().darkGreen, fontSize: 20),
        suffixIcon: suffix,
        prefix: preffix,
      ),
      obscureText: obscureText!,
      validator: validator,
    );
  }
}

class TxtField extends StatelessWidget {
  const TxtField({super.key, required this.lable, required this.myController});
  final String lable;
  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors().lightGreen3, width: 4)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors().lightGreen3, width: 4)),
        fillColor: AppColors().lightGreen,
        filled: true,
        labelText: lable,
        labelStyle: TextStyle(color: AppColors().darkGreen, fontSize: 20),
      ),
    );
  }
}
