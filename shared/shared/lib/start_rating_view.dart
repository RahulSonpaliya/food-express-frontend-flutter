import 'package:flutter/material.dart';

class StarRatingView extends StatelessWidget {
  final double rating;
  final double iconSize;
  final Color starColor;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;

  const StarRatingView({
    super.key,
    this.rating = 0.0,
    this.iconSize = 18.0,
    this.starColor = Colors.yellow,
    this.backgroundColor = Colors.grey,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, size: iconSize, color: starColor),
          SizedBox(width: 5),
          Text(
            rating.toStringAsFixed(1),
            style: textStyle ?? TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
