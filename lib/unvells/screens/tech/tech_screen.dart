import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

import '../../app_widgets/Tabbar/badge_icon_update.dart';
import '../../app_widgets/app_bar.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/utils.dart';

class TechScreen extends StatelessWidget {
  const TechScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: AppSizes.deviceHeight * .08,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.cart);
            },
            icon: const BadgeIconUpdate(
              iconColor: Colors.white,
            ),
          ),
        ],
        titleSpacing: 0,
        leading: const Padding(
          padding: EdgeInsetsDirectional.only(start: 10),
          child: FluxImage(
            imageUrl: AppImages.placeholder,
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsetsDirectional.only(start: 8),
          child: SizedBox(
            height: 40,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.search);
              },
              child: CupertinoSearchTextField(
                suffixMode: OverlayVisibilityMode.always,
                itemSize: 20,
                suffixIcon: const Icon(
                  Icons.mic,
                ),
                enabled: false,
                itemColor: const Color(0xff5E6672),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFFE2E2E2),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                style: KTextStyle.of(context).semiBoldSixteen.copyWith(
                  color: const Color(0xFFB1B1B1),
                  height: 1,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 6),
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Utils.getStringValue(context, "LIMITLESS_LUXURY"),
                    style: KTextStyle.of(context)
                        .eighteen
                        .copyWith(color: AppColors.gold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    Utils.getStringValue(context, "AI_TECHNOLOGIES"),
                    style: KTextStyle.of(context)
                        .bold24
                        .copyWith(color: AppColors.white),
                  ),
                  const SizedBox(height: 16),
                  const FluxImage(
                    imageUrl: "assets/images/place_holder_image.png",
                  ),
                  const SizedBox(height: 20),
                  Text(
                    Utils.getStringValue(context, "DISCOVER_UNVEILS"),
                    textAlign: TextAlign.center,
                    style: KTextStyle.of(context)
                        .twenty
                        .copyWith(color: AppColors.gold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    Utils.getStringValue(context, "EXCLUSIVE_TECHNOLOGIES_DESCRIPTION"),
                    style: KTextStyle.of(context)
                        .sixteen
                        .copyWith(color: AppColors.white),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            const CustomTechContainer(
              textColor: Colors.black,
              bgColor: Colors.white,
              title: "AI_MAKEUP_TRY_ON",
              subTitle: "GLAMOUR_AT_YOUR_FINGERTIPS",
              description: "MAKEUP_TRY_ON_DESCRIPTION",
              buttonTitle: 'TRY_ON_NOW',
            ),
            const CustomTechContainer(
              textColor: Colors.white,
              bgColor: Colors.black,
              title: "FIND_THE_LOOK",
              subTitle: "CURATE_SIGNATURE_STYLE",
              description: "FIND_THE_LOOK_DESCRIPTION",
              buttonTitle: 'FIND_A_LOOK',
            ),
            const CustomTechContainer(
              textColor: Colors.black,
              bgColor: Colors.white,
              title: "AI_SKIN_ANALYSIS",
              subTitle: "REVEAL_SECRETS_OF_RADIANT_SKIN",
              description: "AI_SKIN_ANALYSIS_DESCRIPTION",
              buttonTitle: 'ANALYZE_MY_SKIN',
            ),
            const CustomTechContainer(
              textColor: Colors.white,
              bgColor: Colors.black,
              title: "AI_SKIN_TONE_FINDER",
              subTitle: "ILLUMINATE_YOUR_TRUE_HUE",
              description: "AI_SKIN_TONE_FINDER_DESCRIPTION",
              buttonTitle: 'FIND_MY_SKIN_TONE',
            ),
            const CustomTechContainer(
              textColor: Colors.black,
              bgColor: Colors.white,
              title: "AI_FACE_ANALYZER",
              subTitle: "ELEGANCE_BEYOND_IMAGINATION",
              description: "AI_FACE_ANALYZER_DESCRIPTION",
              buttonTitle: 'TRY_ON_NOW',
            ),
            const CustomTechContainer(
              textColor: Colors.white,
              bgColor: Colors.black,
              title: "SHOP_THE_LOOK",
              subTitle: "ELEVATE_YOUR_STYLE",
              description: "SHOP_THE_LOOK_DESCRIPTION",
              buttonTitle: 'SHOP_A_LOOK',
            ),
            const CustomTechContainer(
              textColor: Colors.black,
              bgColor: Colors.white,
              title: "AI_ACCESSORIES_TRY_ON",
              subTitle: "ELEGANCE_BEYOND_IMAGINATION",
              description: "AI_ACCESSORIES_TRY_ON_DESCRIPTION",
              buttonTitle: 'TRY_ON_NOW',
            ),
            const CustomTechContainer(
              textColor: Colors.white,
              bgColor: Colors.black,
              title: "AI_SKIN_SIMULATION",
              subTitle: "ENVISION_FUTURE_RADIANCE",
              description: "AI_SKIN_SIMULATION_DESCRIPTION",
              buttonTitle: 'SIMULATE_MY_SKIN',
            ),
            const CustomTechContainer(
              textColor: Colors.black,
              bgColor: Colors.white,
              title: "AI_PERSONALITY_FINDER",
              subTitle: "DISCOVER_YOUR_ESSENCE",
              description: "AI_PERSONALITY_FINDER_DESCRIPTION",
              buttonTitle: 'FIND_MY_PERSONALITY',
            ),
            const CustomTechContainer(
              textColor: Colors.white,
              bgColor: Colors.black,
              title: "AI_SMART_BEAUTY_MIRROR",
              subTitle: "REFLECTIONS_OF_ELEGANCE",
              description: "AI_SMART_BEAUTY_MIRROR_DESCRIPTION",
              buttonTitle: 'USE_SMART_MIRROR',
            ),
            const CustomTechContainer(
              textColor: Colors.black,
              bgColor: Colors.white,
              title: "AR_HOME_ACCESSORIES",
              subTitle: "TRANSFORM_YOUR_SPACE",
              description: "AR_HOME_ACCESSORIES_DESCRIPTION",
              buttonTitle: 'TRY_NOW',
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTechContainer extends StatelessWidget {
  const CustomTechContainer({
    super.key,
    required this.bgColor,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.textColor,
    required this.buttonTitle,
  });

  final Color bgColor;
  final Color textColor;
  final String title;
  final String subTitle;
  final String description;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 6),
      color: bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Utils.getStringValue(context, title),
            style: KTextStyle.of(context).bold24.copyWith(color: textColor),
          ),
          const SizedBox(height: 24),
          const FluxImage(imageUrl: "assets/images/Video_placeHolder.png"),
          const SizedBox(height: 20),
          Text(
            Utils.getStringValue(context, subTitle),
            textAlign: TextAlign.center,
            style: KTextStyle.of(context).twenty.copyWith(
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            Utils.getStringValue(context, description),
            style: KTextStyle.of(context).sixteen.copyWith(color: textColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          CustomButton(
            borderColor: AppColors.gold,
            kFillColor: Colors.transparent,
            textColor: AppColors.gold,
            borderWidth: 1,
            isFlat: true,
            title: Utils.getStringValue(context, buttonTitle).toUpperCase(),
            onPressed: () {},
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
