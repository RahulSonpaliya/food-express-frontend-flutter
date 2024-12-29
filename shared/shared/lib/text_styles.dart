import 'package:flutter/material.dart';

import 'colors.dart';

const FontWeight Regular = FontWeight.w400;
const FontWeight SemiBold = FontWeight.w600;
const FontWeight Bold = FontWeight.w700;
const String FONT_FAMILY = "Poppins";

//acronym of TextStyleBuilder
class TSB {
  static TextStyle regular(
      {Color? textColor, required double textSize, bool? underLineText}) {
    return TextStyle(
        fontFamily: FONT_FAMILY,
        color: textColor ?? colorBlack,
        fontWeight: Regular,
        decoration: (underLineText == true)
            ? TextDecoration.underline
            : TextDecoration.none,
        fontSize: textSize);
  }

  static TextStyle regularVSmall({Color? textColor, bool? underLineText}) {
    return TSB.regular(
        textSize: 12, textColor: textColor, underLineText: underLineText);
  }

  static TextStyle regularSmall({Color? textColor, bool? underLineText}) {
    return TSB.regular(
        textSize: 14, textColor: textColor, underLineText: underLineText);
  }

  static TextStyle regularMedium({Color? textColor, bool? underLineText}) {
    return TSB.regular(
        textSize: 16, textColor: textColor, underLineText: underLineText);
  }

  static TextStyle regularLarge({Color? textColor, bool? underLineText}) {
    return TSB.regular(
        textSize: 18, textColor: textColor, underLineText: underLineText);
  }

  static TextStyle regularXLarge({Color? textColor, bool? underLineText}) {
    return TSB.regular(
        textSize: 20, textColor: textColor, underLineText: underLineText);
  }

  static TextStyle regularHeading({Color? textColor, bool? underLineText}) {
    return TSB.regular(
        textSize: 24, textColor: textColor, underLineText: underLineText);
  }

  static TextStyle semiBold(
      {Color? textColor, required double textSize, bool? underLineText}) {
    return TextStyle(
        fontFamily: FONT_FAMILY,
        color: textColor ?? colorBlack,
        fontWeight: SemiBold,
        decoration: (underLineText == true)
            ? TextDecoration.underline
            : TextDecoration.none,
        fontSize: textSize);
  }

  static TextStyle semiBoldVSmall({Color? textColor, bool? underLineText}) {
    return TSB.semiBold(
        textSize: 12, textColor: textColor, underLineText: underLineText);
  }

  static TextStyle semiBoldSmall({Color? textColor, bool? underLineText}) {
    return TSB.semiBold(
        textSize: 14, textColor: textColor, underLineText: underLineText);
  }

  static TextStyle semiBoldMedium({Color? textColor, bool? underLineText}) {
    return TSB.semiBold(
        textSize: 16, textColor: textColor, underLineText: underLineText);
  }

  static TextStyle semiBoldLarge({Color? textColor, bool? underLineText}) {
    return TSB.semiBold(
        textSize: 18, textColor: textColor, underLineText: underLineText);
  }

  static TextStyle semiBoldXLarge({Color? textColor, bool? underLineText}) {
    return TSB.semiBold(
        textSize: 20, textColor: textColor, underLineText: underLineText);
  }

  static TextStyle semiBoldHeading({Color? textColor, bool? underLineText}) {
    return TSB.semiBold(
        textSize: 24, textColor: textColor, underLineText: underLineText);
  }

  static TextStyle bold(
      {Color? textColor, required double textSize, bool? underLineText}) {
    return TextStyle(
        fontFamily: FONT_FAMILY,
        color: textColor ?? colorBlack,
        fontWeight: Bold,
        decoration: (underLineText == true)
            ? TextDecoration.underline
            : TextDecoration.none,
        fontSize: textSize);
  }

  static TextStyle boldVSmall({Color? textColor, bool? underLineText}) {
    return TSB.bold(
        textSize: 12, textColor: textColor, underLineText: underLineText);
  }

  static TextStyle boldSmall({Color? textColor, bool? underLineText}) {
    return TSB.bold(
        textSize: 14, textColor: textColor, underLineText: underLineText);
  }

  static TextStyle boldMedium({Color? textColor, bool? underLineText}) {
    return TSB.bold(
        textSize: 16, textColor: textColor, underLineText: underLineText);
  }

  static TextStyle boldLarge({Color? textColor, bool? underLineText}) {
    return TSB.bold(
        textSize: 18, textColor: textColor, underLineText: underLineText);
  }

  static TextStyle boldXLarge({Color? textColor, bool? underLineText}) {
    return TSB.bold(
        textSize: 20, textColor: textColor, underLineText: underLineText);
  }

  static TextStyle boldHeading({Color? textColor, bool? underLineText}) {
    return TSB.bold(
        textSize: 24, textColor: textColor, underLineText: underLineText);
  }
}
