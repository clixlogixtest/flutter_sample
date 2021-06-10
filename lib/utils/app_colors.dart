import 'package:flutter/material.dart';

/**
new Container(color: const Color(0xff2980b9));
new Color(0xAARRGGBB)
AA = transparency

RR = red

GG = green

BB = blue

now if you want to create custom color 8-digit code from 6-digit color code then just append transparency (AA) value to it
    */

/**
 * 100% - FF
    95% - F2
    90% - E6
    85% - D9
    80% - CC
    75% - BF
    70% - B3
    65% - A6
    60% - 99
    55% - 8C
    50% - 80
    45% - 73
    40% - 66
    35% - 59
    30% - 4D
    25% - 40
    20% - 33
    15% - 26
    10% - 1A
    5% - 0D
    0% - 00
 */

//So color is 0x then transparency like above FF and then html code without #



// App Colors Class - Resource class for storing app level color constants
class AppColors {
  static const Color PRIMARY_COLOR = Color(0xFF1785C1);
  static const Color PRIMARY_COLOR_TRANSPARENT = Color(0x66BB9A5C);
  static const Color SECONDARY_COLOR = Color(0xFFC2D835);
  static const Color WHITE_COLOR_TRANSPARENT = Color(0x1A000000);
  static const Color WHITE_COLOR = Color(0xF000000);
  static const Color BLACK_TEXT_COLOR = Color(0xFF00344F);
  static const Color LIGHT_GREY_TEXT_COLOR = Color(0xFF999FAE);
  static const Color BORDER_COLOR = Color(0xFF999FAE);
  static const Color INPUT_BG_COLOR = Color(0xFFF5F6FA);
  static const Color ERROR_COLOR = Color(0xFFF76F71);
  static const Color SUCCESS_COLOR = Color(0xFF4EC692);
  static const Color ERROR_TEXT_COLOR = Color(0xFFF76F71);
  static const Color DARK_TEXT_COLOR = Color(0xFF00344F);
  static const Color BLUE_GRAD_ONE = Color(0xFF1785C1);
  static const Color BLUE_GRAD_TWO = Color(0xFF3BAEED);
  static const Color GREEN_GRAD_ONE = Color(0xFF4DC591);
  static const Color GREEN_GRAD_TWO = Color(0xFF63E1AB);


}

mixin AppColor {
  static Color basicBlue = const Color.fromRGBO(45, 54, 59, 1);
  static const Color black = const Color.fromRGBO(0, 0, 0, 1);
  static Color blue = const Color.fromRGBO(143, 203, 245, 1);
  static Color red = const Color.fromRGBO(163, 34, 24, 1);
  static Color grey = const Color.fromRGBO(30, 30, 30, 1);
  static Color greytheme = const Color.fromRGBO(34, 34, 34, 1);
  static Color innerOrange = const Color.fromRGBO(245, 179, 77, 1);
  static Color outerOrange = const Color.fromRGBO(229, 119, 58, 1);
  static Color outerGreen = const Color.fromRGBO(84, 183, 66, 1);
  static Color innerGreen = const Color.fromRGBO(179, 252, 149, 1);
  static Color profileImageGreyBG = const Color.fromRGBO(51, 51, 51, 1);
  static Color greymenuUnderline = const Color.fromRGBO(44, 44, 44, 1);
  static Color menutextcolor = const Color.fromRGBO(190, 190, 190, 1);
  static Color yellowTileInner = const Color.fromRGBO(245, 237, 146, 1);
  static Color yellowTileOuter = const Color.fromRGBO(216, 203, 68, 1);
  static Color greyBg = const Color.fromRGBO(17, 17, 17, 1);
  static Color green = const Color.fromRGBO(159, 183, 155, 1);
  static Color cream = const Color.fromRGBO(247, 207, 173, 1);
  static Color pink = const Color.fromRGBO(214, 83, 98, 1);
  static Color btnDark = const Color.fromRGBO(44, 54, 58, 1);
  static Color fontColor = const Color.fromRGBO(85, 98, 82, 1);
  static Color orange = const Color.fromRGBO(239, 138, 128, 1);
  static Color lightGrayColor = const Color.fromRGBO(182, 192, 202, 1);
  static Color lg = const Color.fromRGBO(239, 241, 247, 1);
  static Color darkGrayColor = const Color.fromRGBO(134, 141, 148, 1);
  static Color disabledButtonColor = const Color.fromRGBO(153, 203, 246, 1);
  static Color gradient1Color = const Color.fromRGBO(60, 129, 249, 1);
  static Color gradient2Color = const Color.fromRGBO(71, 206, 243, 1);
  static Color appBlueColor = const Color.fromRGBO(65, 167, 246, 1);
  static Color dividerHeaderColor = const Color(0xFFECEEF1);
  static Color textFieldHeaderColor = const Color.fromRGBO(134, 141, 148, 1);
  static Color buttonColor = const Color.fromRGBO(71, 169, 243, 1);
  static Color hoverColor = const Color.fromRGBO(182, 192, 202, 1);
  static Color colorOrange = const Color.fromRGBO(255, 180, 0, 1);
  static Color colorGreen = const Color.fromRGBO(43, 214, 169, 1);
  static Color colorPinkRed = const Color.fromRGBO(255, 0, 10, 1);
}
