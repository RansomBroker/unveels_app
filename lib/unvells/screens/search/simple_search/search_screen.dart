/*
 *


 *
 * /
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/search/simple_search/bloc/search_events.dart';
import 'package:test_new/unvells/screens/search/simple_search/bloc/search_state.dart';
import 'package:test_new/unvells/screens/search/simple_search/views/category_list.dart';
import 'package:test_new/unvells/screens/search/simple_search/views/search_container.dart';
import 'package:test_new/unvells/screens/search/simple_search/views/search_suggestion.dart';
import '../../../app_widgets/app_alert_message.dart';
import '../../../app_widgets/dialog_helper.dart';
import '../../../configuration/unvells_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/arguments_map.dart';
import '../../../constants/global_data.dart';
import '../../../helper/app_localizations.dart';
import '../../../models/search/search_screen_model.dart';
import 'bloc/search_bloc.dart';
import 'package:flutter/services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  SearchScreenModel? searchModel;
  final TextEditingController _searchText = TextEditingController(text: "");
  String? _searchTextString;
  SearchScreenBloc? searchBloc;
  bool isFirst = true;
  final SpeechToText _speechToText = SpeechToText();
  final bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  bool _isLoading = false;
  String selectedLang = "en_US";
  AnimationController? _controller;
  bool isSearchEmpty = false;
  String transcription = '';
  String searchImage = "imageSearch";
  String searchText = "textSearch";
  AppLocalizations? _localizations;

  final Permission _permission = Permission.camera;

  @override
  void initState() {
    activateSpeechRecognizer();
    searchBloc = context.read<SearchScreenBloc>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  void activateSpeechRecognizer() async {
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: const Duration(seconds: 3),
    )..repeat();
    await _speechToText.initialize();
    setState(() {});
  }

  void onRecognitionResult(SpeechRecognitionResult result) {
    print('_MyAppState.onRecognitionResult... ${result.recognizedWords}');
    setState(() {
      transcription = result.recognizedWords;
      _searchText.text = transcription;
      if (transcription.length > 2) {
        searchBloc?.add(SearchSuggestionEvent(transcription));
      }
      stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchScreenBloc, SearchState>(
        builder: (context, currentState) {
      if (currentState is SearchInitialState) {
        if (!isFirst) {
          if (_searchText.text != "") _isLoading = true;
        }
        isFirst = false;
        searchBloc?.emit(SearchActionState());
      } else if (currentState is SearchScreenSuccess) {
        _isLoading = false;
        if (isSearchEmpty) {
          searchModel = null;
        } else if (!isSearchEmpty) {
          searchModel = currentState.searchSuggestionModel;
        }
        _isLoading = false;
        searchBloc?.emit(SearchActionState());
      } else if (currentState is SearchScreenError) {
        _isLoading = false;
        // WidgetsBinding.instance?.addPostFrameCallback((_) {
        //   AlertMessage.showError(currentState.message ??'', context);
        // });
      }
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Utils.hideSoftKeyBoard();
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            title: TextField(
              readOnly: _isListening,
              controller: _searchText,
              onChanged: (searchKey) {
                print("Search key ---> " + searchKey);
                searchBloc?.add(SearchSuggestionEvent(searchKey));
              },
              onSubmitted: (searchKey) {
                Navigator.pushNamed(context, AppRoutes.catalog,
                    arguments: getCatalogMap(
                      searchKey ?? "",
                      searchKey,
                      BUNDLE_KEY_CATALOG_TYPE_SEARCH,
                      false,
                    ));
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:
                    _localizations?.translate(AppStringConstant.search) ?? '',
                hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
              ),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w500, height: 1.5),
              cursorColor: Theme.of(context).iconTheme.color,
            ),
            actions: [
              (_isListening)
                  ? Center(
                      child: Text(
                          _localizations
                                  ?.translate(AppStringConstant.listening) ??
                              '',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.normal)))
                  : IconButton(
                      onPressed: () {
                        DialogHelper.searchDialog(context, () {
                          Navigator.of(context).pop();
                          _checkPermission(_permission, searchImage);
                        }, () {
                          Navigator.of(context).pop();
                          _checkPermission(_permission, searchText);
                        });
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                        size: AppSizes.size20,
                      ),
                    ),
              _buildVoiceInput(
                onPressed: _speechToText.isNotListening ? start : stop,
              ),
              _searchText.text != "" && _searchText.text != null
                  ? IconButton(
                      onPressed: () {
                        Utils.hideSoftKeyBoard();
                        _searchText.text = "";
                        searchModel = null;
                        searchBloc?.add(InitialSearchSuggestionEvent());
                      },
                      icon: const Icon(
                        Icons.close,
                        size: AppSizes.size20,
                      ),
                    )
                  : Container(),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Visibility(
                  visible: _isLoading,
                  child: LinearProgressIndicator(
                    backgroundColor: Theme.of(context).iconTheme.color,
                    valueColor:const AlwaysStoppedAnimation(AppColors.white),
                  ),
                ),
                if (AppConstant.advanceSearch)
                  advanceSearchContainer(context, () {
                    Navigator.pushNamed(context, AppRoutes.advanceSearch);
                  }),
                Visibility(
                    visible: !_isLoading,
                    child: suggestionList(
                        searchModel, context, _localizations, _searchText)),

                // Visibility(visible:!_isLoading && ,child: Text(Utils.getStringValue(context, AppStringConstant.noProductAvailable)))
                if ((GlobalData.homePageData?.categories ?? []).isNotEmpty)
                  categoryList(
                      context, GlobalData.homePageData?.categories, () {})
              ],
            ),
          ));
    });
  }

  void stop() async {
    await _speechToText.stop();
    _isListening = false;
    setState(() {});
  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade400.withOpacity(1 - _controller!.value),
      ),
    );
  }

  Widget _buildVoiceInput({String? label, VoidCallback? onPressed}) =>
      GestureDetector(
          onTap: onPressed,
          child: SizedBox(
            width: 40,
            child: AnimatedBuilder(
              animation: CurvedAnimation(
                  parent: _controller!, curve: Curves.fastOutSlowIn),
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    _buildContainer(
                        10 * (_isListening ? _controller!.value : 0)),
                    _buildContainer(
                        20 * (_isListening ? _controller!.value : 0)),
                    _buildContainer(
                        30 * (_isListening ? _controller!.value : 0)),
                    _buildContainer(
                        40 * (_isListening ? _controller!.value : 0)),
                    Align(
                      child: Icon(
                        _speechRecognitionAvailable && !_isListening
                            ? Icons.mic_off
                            : Icons.mic,
                        size: AppSizes.size20,
                      ),
                    ),
                  ],
                );
              },
            ),
          )
          // _speechRecognitionAvailable && !_isListening ? start() : stop();
          );

  void start() async {
    await _speechToText.listen(onResult: onRecognitionResult);
    _isListening = true;
    setState(() {});
  }

  Future<void> _checkPermission(Permission permission, String type) async {

    if (Platform.isIOS) {
      try {
        const platform = MethodChannel(AppConstant.channelName);
        var data = await platform.invokeMethod(type);
        _searchText.text = data;
        onImageSearch(data);
        return data;
      } on PlatformException catch (e) {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          AlertMessage.showWarning(e.message ?? '', context);
        });
      }
    } else {
      final status = await permission.request();
      if (status == PermissionStatus.granted) {
        try {
          const platform = MethodChannel(AppConstant.channelName);
          var data = await platform.invokeMethod(type);
          _searchText.text = data;
          onImageSearch(data);
          return data;
        } on PlatformException catch (e) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showWarning(e.message ?? '', context);
          });
        }
      } else if (status == PermissionStatus.denied) {
        _checkPermission(_permission, type);
      } else if (status == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
    }

  }

  Future<void> onImageSearch(data) async {
    dynamic connected = await Utils.connectedToNetwork();
    if (connected == true) {
      searchBloc?.add(SearchSuggestionEvent(data));
      searchBloc?.emit(SearchInitialState());
    } else {
      DialogHelper.networkErrorDialog(context, onConfirm: () {
        onImageSearch(data);
      });
    }
  }
}
