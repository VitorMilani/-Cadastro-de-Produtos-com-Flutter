import 'package:flutter/material.dart';

class ChipInfoWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  const ChipInfoWidget({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, color: Color.fromARGB(255, 0, 0, 0)),
      label: Text(label, style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 14)),
      backgroundColor: Color.fromARGB(255, 223, 226, 7),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    );
  }
}
