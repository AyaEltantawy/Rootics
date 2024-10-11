import 'package:flutter/material.dart';
import 'package:rootics_final/theme/app_colors.dart';

class SubmitBtn extends StatelessWidget {
  const SubmitBtn({super.key, required this.onTap, required this.text});
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors().lightGreen, width: 4),
              borderRadius: BorderRadius.circular(13),
              color: AppColors().lightGreen2,
              boxShadow: const [
                BoxShadow(blurRadius: 2, offset: Offset(0, 2))
              ]),
          child: Center(
              child: Text(
            text,
            style: TextStyle(color: AppColors().darkGreen, fontSize: 25),
          )),
        ));
  }
}
