import 'package:flutter/material.dart';
import '../configuration/text_theme.dart';
import 'flux_image.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.width,
      this.hieght,
      this.isLoading = false,
      this.kFillColor,
      this.isFlat = false,
      this.iconPath,
      this.textColor,
        this.loadingWidget,
      this.borderColor,
      this.borderWidth});

  final String title;
  final bool? isLoading;
  final Color? kFillColor;
  final Function() onPressed;
  final double? width, hieght, borderWidth;
  final String? iconPath;
  final bool isFlat;
  final Color? textColor;
  final Color? borderColor;
  final Widget? loadingWidget;

  @override
  Widget build(BuildContext context) {
    return isLoading!
        ? loadingWidget ?? LinearProgressIndicator()
        : InkWell(
            onTap: isLoading ?? false ? null : onPressed,
            child: Container(
              decoration: BoxDecoration(
                  color: kFillColor ?? Colors.black,
                  borderRadius: BorderRadius.circular(isFlat ? 0 : 10),
                  border: Border.all(
                      color: borderColor ?? Colors.transparent,
                      width: borderWidth ?? 2.5)),
              width: width ?? MediaQuery.of(context).size.width / 1.1,
              height: hieght ?? 54,
              alignment: Alignment.center,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (iconPath != null) ...[
                        Image.asset(
                          iconPath ?? '',
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                      FittedBox(
                        child: Text(
                          title,
                          style: KTextStyle.of(context).boldSixteen.copyWith(
                              color: textColor ?? Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
