import 'package:flutter/material.dart';

extension StringExtension on String? {
  String capitalize() {
    if (this == null || this!.isEmpty) {
      return '';
    }
    final regex = RegExp(r"[A-Za-zÀ-ÿ']+");
    final words = regex.allMatches(this!);
    final capitalizedWords = words.map((match) {
      final word = match.group(0)!;
      final firstUpperCase = word.characters.first.toUpperCase();
      final remainingToLowerCase = word.substring(1).toLowerCase();
      return '$firstUpperCase$remainingToLowerCase';
    });
    return capitalizedWords.join(' ').trim();
  }
}
