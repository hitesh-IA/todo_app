import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final Icon icon;
  final Color color;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Material(
        color: color,
        child: InkWell(
          onTap: onTap,
          onHover: (value) {},
          child: SizedBox(
            height: 33,
            width: 33,
            child: icon,
          ),
        ),
      ),
    );
  }
}
