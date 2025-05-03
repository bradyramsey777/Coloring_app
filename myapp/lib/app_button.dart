// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onTap;
  final String text;

  const AppButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        textStyle: const TextStyle(fontSize: 18),
      ),
      icon: icon,
      label: Text(text),
    );
  }
}