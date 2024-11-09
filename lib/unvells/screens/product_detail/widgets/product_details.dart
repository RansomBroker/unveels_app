import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/product_detail/widgets/product_webview.dart';

class ProductDetailsView extends StatefulWidget {
  String? description;

  ProductDetailsView(this.description, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  bool _isExpanded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isExpanded = (widget.description ?? '').isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      margin: const EdgeInsets.only(top: AppSizes.size8),
      child: ExpansionTile(
          trailing: Icon(_isExpanded ? Icons.minimize : Icons.add),
          initiallyExpanded: _isExpanded,
          onExpansionChanged: (bool expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          shape: const Border(),
          iconColor: Colors.black,
          childrenPadding: const EdgeInsetsDirectional.only(start: 10),
          title: Text(
              Utils.getStringValue(context, AppStringConstant.details) ?? '',
              style: KTextStyle.of(context).semiBoldSixteen),
          children: [
            Html(
              data: widget.description ?? '',
              style: {
                "body": Style(
                  color: Colors.black,
                  fontSize: FontSize(12),
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                )
              },
            ),
          ]),
    );
  }
}
