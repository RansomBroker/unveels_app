import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';
import '../../face_analyzer_model.dart';

class PFAttributesAnalysisWidget extends StatelessWidget {
  const PFAttributesAnalysisWidget({super.key, required this.resultDataParsed});
  final List<FaceAnalyzerModel> resultDataParsed;
  Color hexToColor(String hexString) {
    // Ensure the string is properly formatted
    hexString = hexString.toUpperCase().replaceAll('#', '');

    // If the hex code is only 6 characters (RRGGBB), add the 'FF' prefix for full opacity
    if (hexString.length == 6) {
      hexString = 'FF' + hexString;
    }

    // Parse the hex string to an integer and return the color
    return Color(int.parse(hexString, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: SizeConfig.horizontalPadding,
      ),
      child: Column(
        children: [
          _BodyItemWidget(
            title: "Face",
            iconPath: IconPath.face,
            leftChildren: [
              _DetailBodyItem(
                title: "Face Shape",
                value: resultDataParsed
                        .where((element) => element.name == "Face Shape")
                        .firstOrNull
                        ?.outputLabel ??
                    '',
              ),
            ],
            rightChildren: [
              _DetailBodyItem(
                title: "Skin Tone",
                value: resultDataParsed
                        .where((element) => element.name == "Skin Type")
                        .firstOrNull
                        ?.outputLabel ??
                    '-',
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          _BodyItemWidget(
            title: "Eyes",
            iconPath: IconPath.eye,
            leftChildren: [
              _DetailBodyItem(
                title: "Eye Shape",
                value: resultDataParsed
                        .where((element) => element.name == "Eye Shape")
                        .firstOrNull
                        ?.outputLabel ??
                    '-',
              ),
              _DetailBodyItem(
                title: "Eye Angle",
                value: resultDataParsed
                        .where((element) => element.name == "Eye Angle")
                        .firstOrNull
                        ?.outputLabel ??
                    '-',
              ),
              _DetailBodyItem(
                title: "Eyelid",
                value: resultDataParsed
                        .where((element) => element.name == "Eye Lid")
                        .firstOrNull
                        ?.outputLabel ??
                    '-',
              ),
            ],
            rightChildren: [
              _DetailBodyItem(
                title: "Eye Size",
                value: resultDataParsed
                        .where((element) => element.name == "Eye Size")
                        .firstOrNull
                        ?.outputLabel ??
                    '-',
              ),
              _DetailBodyItem(
                title: "Eye Distance",
                value: resultDataParsed
                        .where((element) => element.name == "Eye Distance")
                        .firstOrNull
                        ?.outputLabel ??
                    '-',
              ),
              _DetailBodyItem(
                title: "Eye Color",
                valueWidget: Container(
                  height: 28,
                  color: hexToColor(resultDataParsed
                          .where(
                              (element) => element.name == "Average Eye Color")
                          .firstOrNull
                          ?.outputColor ??
                      '#ffffff'),
                ),
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          _BodyItemWidget(
            title: "Brows",
            iconPath: IconPath.brow,
            leftChildren: [
              _DetailBodyItem(
                title: "Eyebrow Shape",
                value: resultDataParsed
                        .where((element) => element.name == "Eyebrow Shape")
                        .firstOrNull
                        ?.outputLabel ??
                    '-',
              ),
              _DetailBodyItem(
                title: "Eyebrow Distance",
                value: resultDataParsed
                        .where((element) => element.name == "Eyebrow Distance")
                        .firstOrNull
                        ?.outputLabel ??
                    '-',
              ),
            ],
            rightChildren: [
              _DetailBodyItem(
                title: "Thickness",
                value: resultDataParsed
                        .where((element) => element.name == "Thickness")
                        .firstOrNull
                        ?.outputLabel ??
                    '-',
              ),
              _DetailBodyItem(
                title: "Eyebrow color",
                valueWidget: Container(
                  height: 28,
                  color: hexToColor(resultDataParsed
                          .where((element) =>
                              element.name == "Average Eyebrow Color")
                          .firstOrNull
                          ?.outputColor ??
                      '#ffffff'),
                ),
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          _BodyItemWidget(
            title: "Lips",
            iconPath: IconPath.lip,
            leftChildren: [
              _DetailBodyItem(
                title: "Lip shape",
                value: resultDataParsed
                        .where((element) => element.name == "Lip")
                        .firstOrNull
                        ?.outputLabel ??
                    '-',
              ),
            ],
            rightChildren: [
              _DetailBodyItem(
                title: "Lip color",
                valueWidget: Container(
                  height: 28,
                  color: hexToColor(resultDataParsed
                          .where(
                              (element) => element.name == "Average Lip Color")
                          .firstOrNull
                          ?.outputColor ??
                      '#ffffff'),
                ),
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          _BodyItemWidget(
            title: "Cheekbones",
            iconPath: IconPath.cheekbones,
            leftChildren: [
              _DetailBodyItem(
                title: "Cheekbones",
                value: resultDataParsed
                        .where((element) => element.name == "Cheeks Bones")
                        .firstOrNull
                        ?.outputLabel ??
                    '-',
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          _BodyItemWidget(
            title: "Nose",
            iconPath: IconPath.nose,
            leftChildren: [
              _DetailBodyItem(
                title: "Nose Shape",
                value: resultDataParsed
                        .where((element) => element.name == "Nose Shape")
                        .firstOrNull
                        ?.outputLabel ??
                    '-',
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          _BodyItemWidget(
            title: "Hair",
            iconPath: IconPath.hair,
            leftChildren: [
              _DetailBodyItem(
                title: "Face Shape",
                valueWidget: Container(
                    height: 28,
                    color: hexToColor(resultDataParsed
                            .where((element) => element.name == "Hair Color")
                            .firstOrNull
                            ?.outputColor ??
                        '#ffffff')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BodyItemWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final List<Widget> leftChildren;
  final List<Widget> rightChildren;

  const _BodyItemWidget({
    required this.iconPath,
    required this.title,
    this.leftChildren = const [],
    this.rightChildren = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              width: 24,
              iconPath,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: context.width * 0.4,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: leftChildren.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return leftChildren[index];
                },
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: context.width * 0.4,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: rightChildren.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return rightChildren[index];
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DetailBodyItem extends StatelessWidget {
  final String title;
  final String? value;
  final Widget? valueWidget;

  const _DetailBodyItem({
    required this.title,
    this.value,
    this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        if (valueWidget != null) ...[
          const SizedBox(
            height: 4,
          ),
          valueWidget!,
        ],
        if (value != null) ...[
          const SizedBox(
            height: 4,
          ),
          Text(
            "• $value",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ],
    );
  }
}
