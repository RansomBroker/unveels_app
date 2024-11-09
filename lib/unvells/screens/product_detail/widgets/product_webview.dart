/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductsWebView extends StatefulWidget {
  String description;

  ProductsWebView(this.description, {Key? key}) : super(key: key);
  @override
  _ProductsWebViewState createState() => _ProductsWebViewState(this.description);
}

class _ProductsWebViewState extends State<ProductsWebView> {
  WebViewController? _webViewController;
  String description;

  _ProductsWebViewState(this.description);

  _loadHtml(){
    _webViewController!.loadUrl(Uri.dataFromString("<h1>$description</h1>", mimeType: 'text/html',encoding: Encoding.getByName('utf-8')).toString());

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  Theme.of(context).colorScheme.background,
      // height: MediaQuery.of(context).size.height/5,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(AppSizes.size8),
      child: WebView(
          initialUrl: '',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _webViewController = webViewController;
            _loadHtml();
          }
      ),
    );
  }
}
