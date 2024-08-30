import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CsButton extends StatelessWidget {
  const CsButton(
      {super.key,
      required this.title,
      this.textStyle,
      this.onPressed,
      this.bgColor,
      this.borderColor,
      this.useIcon = false,
      this.useBorder = false,
      this.textOnly = false,
      this.alignment,
      this.icon});
  final String title;
  final Color? bgColor;
  final Color? borderColor;
  final bool useIcon;
  final bool useBorder;
  final String? icon;
  final VoidCallback? onPressed;
  final bool textOnly;
  final TextStyle? textStyle;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return textOnly
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: TextButton(
              onPressed: onPressed,
              child: Text(
                title,
                style: textStyle,
              ),
            ),
          )
        : SizedBox(
            width: double.infinity,
            height: 52,
            child: TextButton(
              style: TextButton.styleFrom(
                side: useBorder
                    ? BorderSide(color: borderColor!, width: 2)
                    : BorderSide.none,
                backgroundColor: bgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: onPressed,
              child: useIcon
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(icon!), fit: BoxFit.cover)),
                        ),
                        const Gap(6),
                        Text(title, style: textStyle),
                      ],
                    )
                  : Text(title, style: textStyle),
            ),
          );
  }
}
