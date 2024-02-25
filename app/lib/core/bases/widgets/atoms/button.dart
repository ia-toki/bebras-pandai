import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../theme/base_colors.dart';
import '../../enum/button_type.dart';

class Button extends StatelessWidget {
  final String text;
  final Function? onTap;
  final bool? isLoading;
  final bool? isDisabled;
  final ButtonType? buttonType;
  final double innerHorizontalPadding;
  final double innerVerticalPadding;
  final double fontSize;
  final Color customButtonColor;
  final Color customTextColor;
  final Color customBorderColor;
  final double borderRadius;

  const Button({
    required this.text,
    this.buttonType,
    this.onTap,
    this.isLoading = false,
    this.isDisabled = false,
    this.innerHorizontalPadding = 20,
    this.innerVerticalPadding = 16,
    this.fontSize = 16,
    this.customButtonColor = Colors.transparent,
    this.customTextColor = BaseColors.black,
    this.borderRadius = 16,
    this.customBorderColor = Colors.transparent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor;
    Color buttonColor;

    switch (buttonType) {
      case ButtonType.primary:
        textColor = BaseColors.white;
        buttonColor = BaseColors.black;
        break;
      case ButtonType.secondary:
        textColor = BaseColors.black;
        buttonColor = BaseColors.white;
        break;
      case ButtonType.tertiary:
        textColor = BaseColors.white;
        buttonColor = Colors.blueAccent;
        break;
      case null:
        textColor = customTextColor;
        buttonColor = customButtonColor;
        break;
    }

    return InkWell(
      onTap: () {
        if (!isLoading! && !isDisabled!) {
          onTap!();
        }
      },
      child: Opacity(
        opacity: isDisabled! ? 0.5 : 1,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: innerHorizontalPadding,
            vertical: innerVerticalPadding,
          ),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: customBorderColor),
          ),
          width: double.infinity,
          child: AutoSizeText(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
            minFontSize: 2,
          ),
        ),
      ),
    );
  }
}
