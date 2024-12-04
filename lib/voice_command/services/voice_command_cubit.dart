import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:test_new/main.dart';
import 'package:test_new/unvells/constants/arguments_map.dart';
import 'package:test_new/unvells/screens/search/simple_search/bloc/search_repository.dart';
import '../../unvells/constants/app_routes.dart';

part 'voice_command_state.dart';

class VoiceCommandCubit extends Cubit<VoiceCommandState> {
  final SpeechToText _speech = SpeechToText();
  SearchRepository repository;

  VoiceCommandCubit({
    required this.repository,
  }) : super(VoiceCommandInitial()) {
    _initializeSpeech();
  }

  void _initializeSpeech() async {
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

  void _openProduct(String query) async {
    var context = navigatorKey.currentContext!;

    var model = await repository?.getSearchSuggestion(query);
    if (model != null) {
      log(model.suggestProductArray!.toString(), name: 'search');

      var products = model.suggestProductArray?.products ?? [];

      if (products.isEmpty) {
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
      var first = products.first;

      Navigator.of(context).pushNamed(
        AppRoutes.productPage,
        arguments: getProductDataAttributeMap(
          first.productName ?? "",
          first.productId ?? "",
        ),
      );
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

  void startListening() async {
    try {
      emit(VoiceCommandListening(state.text, state.confidence));

      await _speech.listen(
        onResult: (result) async {
          final recognizedText = result.recognizedWords;
          final confidence = result.confidence;

          if (result.finalResult == false) return;

          log(result.toJson().toString(), name: 'Voice Command');

          // Process command
          String command = recognizedText.toLowerCase();

          var context = navigatorKey.currentContext!;
          if (command.startsWith("search")) {
            var query = command.replaceAll("search", "");
            _search(query);
          } else if (command.startsWith("open product")) {
            var query = command.replaceAll("open product", "");

            _openProduct(query);
          } else if (command.startsWith("open category")) {
            var query = command.replaceAll("open category", "");

            _openCategory(query);
          } else if (command.startsWith("open kategori")) {
            var query = command.replaceAll("open kategori", "");

            _openCategory(query);
          } else if (command.startsWith("back to home")) {
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
          }

          emit(VoiceCommandListening(recognizedText, confidence));
        },
        listenOptions: SpeechListenOptions(
          listenMode: ListenMode.dictation,
        ),
      );
    } catch (e) {}
  }

  void stopListening() async {
    await _speech.stop();
    emit(VoiceCommandReady());
  }

  void toggleListening() {
    if (state is VoiceCommandListening) {
      stopListening();
    } else {
      startListening();
    }
  }

  void _statusListener(String status) {
    if (status == 'notListening' && state is VoiceCommandListening) {
      startListening(); // Restart listening
    }
  }

  void _errorListener(SpeechRecognitionError error) {
    if (error.errorMsg.contains("error") && state is VoiceCommandListening) {
      startListening();
    }
  }
}
