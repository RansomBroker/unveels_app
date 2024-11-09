/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

import '../configuration/unvells_theme.dart';

class Loader extends StatelessWidget {
  final String? loadingMessage;
  final String? loadingImage;

  const Loader({super.key, this.loadingMessage, this.loadingImage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage ?? '',
            textAlign: TextAlign.center,
            style:  TextStyle(
              fontSize: AppSizes.size24,
              color: UnvellsTheme.accentColor,
            ),
          ),
          const SizedBox(height: AppSizes.size24),
       loadingImage!=null?   FluxImage(imageUrl: loadingImage??''):
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color?>(
              Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }
}
