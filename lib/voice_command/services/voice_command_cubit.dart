import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:test_new/main.dart';
import 'package:test_new/unvells/constants/arguments_map.dart';
import 'package:test_new/unvells/models/search/search_screen_model.dart';
import 'package:test_new/unvells/screens/search/simple_search/bloc/search_repository.dart';
import '../../unvells/constants/app_routes.dart';
import '../../unvells/screens/product_detail/bloc/product_detail_screen_repository.dart';

part 'voice_command_state.dart';

class VoiceCommandCubit extends Cubit<VoiceCommandState> {
  final SpeechToText _speech = SpeechToText();
  SearchRepository searchRepository;
  ProductDetailScreenRepository productDetailRepository;

  Product? product;

  VoiceCommandCubit({
    required this.searchRepository,
    required this.productDetailRepository,
  }) : super(VoiceCommandInitial()) {
    _initializeSpeech();
  }

  Future<void> _initializeSpeech() async {
    bool available = await _speech.initialize(
      onStatus: _statusListener,
      onError: _errorListener,
    );
    if (available) {
      emit(VoiceCommandReady());
    } else {
      emit(VoiceCommandError("Speech recognition unavailable"));
    }
  }

  Future<void> startListening() async {
    try {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        const SnackBar(content: Text('Microphone permission not granted'));
        return;
      }

      emit(VoiceCommandListening(state.text, state.confidence));

      await _speech.listen(
        onResult: (result) async {
          final recognizedText = result.recognizedWords;
          final confidence = result.confidence;

          log(result.toJson().toString(), name: 'Voice Command Result');

          if (result.finalResult == true) {


            // Process command
            String command = recognizedText.toLowerCase();

            var context = navigatorKey.currentContext!;
            if (command.startsWith("search")) {
              var query = command.replaceAll("search", "").trim();
              _search(query);
            } else if (command.startsWith("open product")) {
              var query = command.replaceAll("open product", "").trim();

              await _openProduct(query);
            } else if (command.startsWith("open produk")) {
              var query = command.replaceAll("open produk", "").trim();

              await _openProduct(query);
            } else if (command.startsWith("open category")) {
              var query = command.replaceAll("open category", "").trim();

              _openCategory(query);
            } else if (command.startsWith("open kategori")) {
              var query = command.replaceAll("open kategori", "").trim();
              _openCategory(query);
            } else if (command.startsWith("open cart")) {
              Navigator.pushNamed(context, AppRoutes.cart);
            } else if (command.startsWith("add to cart")) {
              _addToCart();
            } else if (command.startsWith("tambahkan keranjang")) {
              _addToCart();
            } else if (command.startsWith("back to home")) {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.home, (route) => false);
            } else if (command.startsWith("back to home")) {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.home, (route) => false);
            }
          }
        },
        listenOptions: SpeechListenOptions(
          listenMode: ListenMode.dictation,
        ),
      );

    } catch (e) {
      await stopListening();
      log(e.toString());
    }

    emit(VoiceCommandListening('', 0));
  }

  Future<void> stopListening() async {
    emit(VoiceCommandStoping());
    await _speech.stop();
    emit(VoiceCommandReady());
  }

  void toggleListening() async {
    if (_speech.isListening) {
      await stopListening();
    } else {
      await startListening();
    }
  }

  void _statusListener(String status) async {
    log(status, name: 'Voice Command Status');


    if (status == 'done' && state is VoiceCommandListening) {
      await Future.delayed(Duration(seconds: 1));
      await startListening();
    }
  }

  void _errorListener(SpeechRecognitionError error) async {
    log(error.errorMsg, name: 'Voice Command Error');
    if (_speech.isListening) {
      await stopListening();
      // startListening();
    }

    if (error.errorMsg == 'error_no_match') {

    }
  }

//   command action
  void _search(String query) {
    var context = navigatorKey.currentContext!;

    Navigator.pushNamed(
      context,
      AppRoutes.catalog,
      arguments: getCatalogMap(
        query ?? "",
        query,
        BUNDLE_KEY_CATALOG_TYPE_SEARCH,
        false,
      ),
    );
  }

  Future<void> _openProduct(String query) async {
    var context = navigatorKey.currentContext!;

    var model = await searchRepository.getSearchSuggestion(query);
    if (model.suggestProductArray != null) {
      var products = model.suggestProductArray?.products ?? [];

      log(model.suggestProductArray!.products.toString(), name: 'search');

      if (products.isEmpty) {
        return;
        // Navigator.pushNamed(
        //   context,
        //   AppRoutes.catalog,
        //   arguments: getCatalogMap(
        //     query ?? "",
        //     query,
        //     BUNDLE_KEY_CATALOG_TYPE_SEARCH,
        //     false,
        //   ),
        // );
      }

      if (products.length > 1) {
        List<String> wordsToCheck = query.split(' ');

        Product? searchMatch;
        int maxMatch = 0;
        for (var item in products) {
          int matchCount = wordsToCheck
              .where((word) =>
                  item.productName!.toLowerCase().contains(word.toLowerCase()))
              .length;
          if (matchCount > maxMatch) {
            searchMatch = item;
            maxMatch = matchCount;
          }
        }

        if (searchMatch != null) {
          product = searchMatch;

          Navigator.of(context).pushNamed(
            AppRoutes.productPage,
            arguments: getProductDataAttributeMap(
              product?.productName ?? "",
              product?.productId ?? "",
            ),
          );
        } else {
          // Navigator.pushNamed(
          //   context,
          //   AppRoutes.catalog,
          //   arguments: getCatalogMap(
          //     query ?? "",
          //     query,
          //     BUNDLE_KEY_CATALOG_TYPE_SEARCH,
          //     false,
          //   ),
          // );
        }
      } else {
        product = products.first;

        Navigator.of(context).pushNamed(
          AppRoutes.productPage,
          arguments: getProductDataAttributeMap(
            product?.productName ?? "",
            product?.productId ?? "",
          ),
        );
      }
    }
  }

  void _openCategory(String query) {
    var context = navigatorKey.currentContext!;

    Navigator.pushNamed(
      context,
      AppRoutes.catalog,
      arguments: getCatalogMap(
        query ?? "",
        query,
        BUNDLE_KEY_CATALOG_TYPE_SEARCH,
        false,
      ),
    );
  }

  void _addToCart() async {
    var context = navigatorKey.currentContext!;

    try {
      // var model = await productDetailRepository
      //     ?.addToCart(product!.productId!, 1, {}, []);
      //
      // log(model!.toJson().toString(), name: '');
      // if (model != null) {
      //   if (model.success == true) {
      //     Navigator.pushNamed(context, AppRoutes.cart);
      //   } else {
      //     ScaffoldMessenger.of(context)
      //         .showSnackBar(SnackBar(content: Text(model.message ?? "")));
      //   }
      // }

      emit(VoiceCommandListening(state.text, state.confidence,status: VoiceCommandStatus.addCart));
    } catch (error, _) {
      print(error);
    }
  }
}
