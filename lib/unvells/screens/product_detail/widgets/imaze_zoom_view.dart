/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/screens/product_detail/widgets/product_page_image_indicator.dart';

import '../../../app_widgets/image_view.dart';
import '../../../app_widgets/widget_space.dart';
import '../../../constants/app_constants.dart';
import '../../../models/productDetail/image_gallery.dart';


class ZoomImageView extends StatefulWidget {
  ZoomImageView({Key? key, this.productImages}) : super(key: key);
  List<ImageGallery>? productImages;

  @override
  _ZoomImageViewState createState() => _ZoomImageViewState();
}

class _ZoomImageViewState extends State<ZoomImageView> {
  final _pageController = PageController(initialPage: 0);
  final _currentPageNotifier = ValueNotifier<int>(0);
  double? imageSize;
  @override
  Widget build(BuildContext context) {
    imageSize ??= (AppSizes.deviceWidth / 4);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.size16),
                  child: Image.asset(
                    AppImages.cancelIcon,
                    width: AppSizes.size16,
                    height: AppSizes.size16,
                  ),
                )),
            widgetSpace(),
            SizedBox(
              width: AppSizes.deviceWidth,
              height: AppSizes.deviceWidth,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.productImages?.length,
                itemBuilder: (BuildContext context, int index) {
                  return ImageView(
                    url: widget.productImages?[index].largeImage,
                    width: AppSizes.deviceWidth,
                    height: AppSizes.deviceWidth / 4,

                  );
                },
                onPageChanged: (int index) {
                  _currentPageNotifier.value = index;
                },
              ),
            ),
            _buildCircularIndicator(_currentPageNotifier),
          ],
        ),
      ),
    );
  }
  Widget _buildCircularIndicator(_currentPageNotifier){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ProductPageImageIndicator(
        dotColor: AppColors.darkGray,
        selectedDotColor: Theme.of(context).bottomAppBarTheme.color ?? Colors.black,
        itemCount: widget.productImages?.length,
        currentPageNotifier: _currentPageNotifier,
        productImages: widget.productImages,
        onPageSelected: (int index) {
          _currentPageNotifier.value = index;
          setState(() {
            _pageController.animateToPage(index,curve: Curves.ease,duration: Duration(milliseconds: 300));
          });
        },
      ),
    );

  }
}
