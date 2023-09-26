import 'package:visio/constant/constant_builder.dart';
import 'dart:core';



InputDecoration inputDec(String text,  {String? hint, bool isPassword = false, bool? obscure, ValueSetter<bool>? togglePass}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: white,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelStyle: const TextStyle(
        color: fontColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.all(16),
      

      suffixIcon: (isPassword == true) 
      ? IconButton(
        splashRadius: 23,
              icon: Icon(
                obscure! ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                togglePass!(!obscure);
              },
            )
      : null,
    );
  }