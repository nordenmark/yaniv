import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    
    fillColor: const Color(0x1AFFFFFF),
    filled: true,
    focusColor: const Color(0xFFFFFFFF),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: const Color(0x4DFFFFFF),
        )
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: const Color(0xFFFFFFFF),
        )
    ),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: const Color(0xFFFF4C4B),
        )
    ),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: const Color(0xFFFF4C4B),
        )
    ),
    
    hintStyle: TextStyle(
        color: Color(0xB3FFFFFF),
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
    ),
    errorStyle: TextStyle(
      fontSize: 12.0,
      color: const Color(0xFFFFFFFF),
      fontWeight: FontWeight.w500,
    ),
);