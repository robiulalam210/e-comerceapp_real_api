
import 'package:flutter/material.dart';

// Widget myTextField(String hintText,keyBoardType,controller){
//   return TextField(
//     keyboardType: keyBoardType,
//     controller: controller,
//     decoration: InputDecoration(hintText: hintText),
//   );
// }


class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
        required this.Controller,
        this.keyBoardType,
        this.labelText,
        this.icon,
        this.sufixicon,
      })
      : super(key: key);

  final TextEditingController Controller;

  final TextInputType? keyBoardType;
  final String? labelText;
  final IconData? icon;
  final IconData? sufixicon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: Controller,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Color(0xff0c1288)),
          borderRadius: BorderRadius.circular(30.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Color(0xff7B81EC)),
          borderRadius: BorderRadius.circular(30.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Color(0xff7B81EC)),
          borderRadius: BorderRadius.circular(30.0),
        ),
        labelText: labelText,
        prefixIcon: Icon(icon, color: Color(0xff7B81EC),),
        suffixIcon: Icon(sufixicon, color: Color(0xff7B81EC),),
      ),
    );
  }
}
