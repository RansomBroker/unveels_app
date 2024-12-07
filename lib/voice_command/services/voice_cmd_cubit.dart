import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:test_new/main.dart';
import 'package:test_new/unvells/constants/arguments_map.dart';
import 'package:test_new/unvells/models/search/search_screen_model.dart';
import 'package:test_new/unvells/screens/search/simple_search/bloc/search_repository.dart';
import '../../unvells/constants/app_routes.dart';
import '../../unvells/screens/product_detail/bloc/product_detail_screen_repository.dart';

part 'voice_cmd_state.dart';

class VoiceCmdCubit extends Cubit<VoiceCmdState> {
  final SpeechToText _speech = SpeechToText();

  VoiceCmdCubit() : super(VoiceCommandInitial()) {
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

  void startListening() async {
    try {
      emit(VoiceCommandListening(state.text, state.confidence));

      await _speech.listen(
        onResult: (result) async {
          final recognizedText = result.recognizedWords;
          final confidence = result.confidence;


          log(result.toJson().toString(), name: 'Voice Command');

          emit(VoiceCommandResult(recognizedText, confidence));


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
