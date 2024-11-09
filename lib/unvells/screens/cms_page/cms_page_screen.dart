/*
 *
  

 *
 * /
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_constants.dart';
import '../../constants/arguments_map.dart';
import '../../models/cms_page/cms_page_model.dart';
import 'bloc/cms_page_bloc.dart';
import 'bloc/cms_page_event.dart';
import 'bloc/cms_page_state.dart';

class CmsPage extends StatefulWidget {
  final Map<String, dynamic> arguments;

  CmsPage(this.arguments,{Key? key}) : super(key: key);

  @override
  State<CmsPage> createState() => _CmsPageState();
}

class _CmsPageState extends State<CmsPage> {
  CmsPageBloc? _cmsPageBloc;
  bool isLoading = true;
  CmsPageModel? _model;

  @override
  void initState() {
    _cmsPageBloc = context.read<CmsPageBloc>();
    _cmsPageBloc?.add(CmsPageDetailsEvent(widget.arguments[cmsPageId]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Html(
          data:  widget.arguments[cmsPageTitle]??'',style: {
          "body": Style(
            fontSize:  FontSize(AppSizes.textSizeLarge),
            color: AppColors.textColorPrimary,
          ),
        },),
      ),
      body: mainView(),
    );
  }

  Widget mainView() {
    return BlocBuilder<CmsPageBloc, CmsPageState>(
        builder: (BuildContext context, CmsPageState currentState) {
          if (currentState is CmsPageLoadingState) {
            isLoading = true;
          } else if (currentState is CmsPageSuccessState) {
            isLoading = false;
            _model = currentState.data;
          } else if (currentState is CmsPageErrorState) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.message ?? '', context);
            });
          }
          return _buildUI();
        });  }

  Widget _buildUI() {
    return Stack(
      children: [
        Visibility(
          visible: !isLoading,
          child: WebView(
            initialUrl: "",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (c) {
              _loadHtmlFromAssets(c);
            },
          ),
        ),
        Visibility(visible: isLoading, child: const Loader())
      ],
    );
  }
  _loadHtmlFromAssets(_controller) async {
    String fileText = _model?.content??"" ;
    _controller?.loadUrl(Uri.dataFromString("""<!DOCTYPE html>
    <html>
      <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
      <body style='"margin: 0; padding: 0;'>
        <div>
          $fileText
        </div>
      </body>
    </html>""", mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

}


