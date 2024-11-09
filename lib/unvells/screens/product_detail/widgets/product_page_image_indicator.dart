/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';

import '../../../app_widgets/image_view.dart';
import '../../../constants/app_constants.dart';
import '../../../models/productDetail/image_gallery.dart';


class ProductPageImageIndicator extends StatefulWidget {
   double _defaultSize = 8.0;
  double _defaultSelectedSize = 8.0;
  static const double _defaultSpacing = 8.0;
  static const Color _defaultDotColor = const Color(0x509E9E9E);
  static const Color _defaultSelectedDotColor = Colors.grey;

  /// The current page index ValueNotifier
  final ValueNotifier<int>? currentPageNotifier;

  /// The number of items managed by the PageController
  final int? itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int>? onPageSelected;

  ///The dot color
  final Color dotColor;

  ///The selected dot color
  final Color selectedDotColor;

  ///The normal dot size
  final double? size;

  ///The selected dot size
  final double? selectedSize;

  ///The space between dots
  final double dotSpacing;
  List<ImageGallery>? productImages;
  ProductPageImageIndicator({
    Key? key,
    @required this.currentPageNotifier,
    @required this.itemCount,
    this.onPageSelected,
    this.size,
    this.dotSpacing = _defaultSpacing,
    Color? dotColor,
    Color? selectedDotColor,
    this.selectedSize,
    this.productImages
  })  : this.dotColor = dotColor ??
            ((selectedDotColor?.withAlpha(150)) ?? _defaultDotColor),
        this.selectedDotColor = selectedDotColor ?? AppColors.black,
        super(key: key);

  @override
  CirclePageIndicatorState createState() {
    return new CirclePageIndicatorState();
  }
}

class CirclePageIndicatorState extends State<ProductPageImageIndicator> {
  int _currentPageIndex = 0;

  @override
  void initState() {
    _readCurrentPageIndex();
    widget.currentPageNotifier!.addListener(_handlePageIndex);
    super.initState();
  }

  @override
  void dispose() {
    widget.currentPageNotifier!.removeListener(_handlePageIndex);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget._defaultSize= AppSizes.deviceWidth / 6;
    widget._defaultSelectedSize= AppSizes.deviceWidth / 5;
    return Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: List<Widget>.generate(widget.itemCount!, (int index) {
          double size = widget._defaultSize;
          Color color = widget.dotColor;
          if (isSelected(index)) {
            size =widget._defaultSelectedSize;
            color = widget.selectedDotColor;
          }
          return GestureDetector(
            onTap: () {
              widget.onPageSelected == null
                ? null
                : widget.onPageSelected!(index);
            },
            child: Container(
              width: size + widget.dotSpacing,
              margin: const EdgeInsets.all(AppSizes.size4),
              child: Material(
                color: color,
                type: MaterialType.card,
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.size1),
                  child: ImageView(
                    url: widget.productImages?[index].largeImage,
                    width: size,
                    height: size,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          );
        }));
  }

  bool isSelected(int dotIndex) => _currentPageIndex == dotIndex;

  _handlePageIndex() {
    setState(_readCurrentPageIndex);
  }

  _readCurrentPageIndex() {
    _currentPageIndex = widget.currentPageNotifier!.value;
  }
}
