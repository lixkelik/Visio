import 'package:visio/constant/constant_builder.dart';
import 'dart:core';



InputDecoration inputDec(String text,  {String? hint, bool isPassword = false, bool? obscure, ValueSetter<bool>? togglePass}) {
    return InputDecoration(
      labelText: text,
      hintText: hint,
      labelStyle: 
        const TextStyle(
          color: fontColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),

        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: appOrange,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )
        ),
        contentPadding: const EdgeInsets.all(20),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: appOrange,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )
        ),
        
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: appYellow,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )
        ),

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