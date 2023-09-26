import 'package:flutter/material.dart';

showSnackBar(String message, Color color, context){
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
    ),
  );
}

