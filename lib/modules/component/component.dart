import 'package:flutter/material.dart';

Widget defaultButton(void Function()? onTap, String name) => InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(13.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            gradient: const LinearGradient(
              colors: [Color(0xFF887868), Colors.white24],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )),
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

String toRoman(int value) {
  final List<String> romanNumerals = [
    '',
    'I.',
    'II.',
    'III.',
    'IV.',
    'V.',
    'VI.',
    'VII.',
    'VIII.',
    'IX.',
    'X.',
    'XI.',
    'XII.',
    'XIII.',
    'XIV.',
    'XV.',
    'XVI.',
    'XVII.',
    'XVIII.',
    'XIX.',
    'XX.',
    'XXI.',
    'XXII.',
    'XXIII.',
    'XXIV.',
    'XXV.',
    'XXVI.',
    'XXVII.',
    'XXVIII.',
    'XXIX.',
    'XXX.'
  ];

  return romanNumerals[value].padRight(6); // Pad to a consistent width
}
