import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/color_config.dart';
import '../../../../shared/configs/size_config.dart';

class PFAnalysisDetailsWidget extends StatelessWidget {
  final String title;
  final String description;

  final double percent;
  const PFAnalysisDetailsWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.percent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                height: 40,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    IconPath.chevronDown,
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Severity",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${NumberFormat.decimalPatternDigits(decimalDigits: 2).format(percent * 100)}%',
                style: TextStyle(
                  fontSize: 14,
                  color: percent > 0.5
                      ? ColorConfig.greenSuccess
                      : percent > 0.3
                          ? Colors.orange
                          : ColorConfig.redError,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
