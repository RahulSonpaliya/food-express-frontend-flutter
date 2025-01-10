import 'package:flutter/material.dart';

import 'colors.dart';

class SimpleIconWidget extends StatelessWidget {
  final void Function()? onTap;
  final IconData icon;
  const SimpleIconWidget({super.key, this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bg_edit_text_color,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            icon,
            color: theme_blue_color_1,
          ),
        ),
      ),
    );
  }
}
