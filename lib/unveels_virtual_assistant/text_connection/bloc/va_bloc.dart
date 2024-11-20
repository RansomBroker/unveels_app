import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'va_event.dart';
import 'va_repository.dart';
import 'va_state.dart';

class VaTextConnectionBloc
    extends Bloc<VaTextConnectionEvent, VaTextConnectionState> {
  final VaTextConnectionRepository vaRepository;
  final List<ChatMessage> _messages = [];
  bool isFinished = false;

  List<Map<String, String>> _chatHistory() {
    return _messages
        .where((item) => item.isLoading == false)
        .map((message) => {
              "text": message.content,
              "sender": message.isUser ? "user" : "agent"
            })
        .toList();
  }

  VaTextConnectionBloc(this.vaRepository) : super(VaInitialState()) {
    on<SendMessageEvent>((event, emit) async {
      emit(VaLoadingState());
      try {
        String formattedTimestamp = DateFormat('h:mm a').format(DateTime.now());

        if (isFinished) {
          _messages.clear();
        }

        _messages.add(
          ChatMessage(
            isUser: true,
            content: event.message,
            timestamp: formattedTimestamp,
          ),
        );

        _messages.add(
          ChatMessage(
            isUser: false,
            content: "...",
            isLoading: true,
            timestamp: formattedTimestamp,
          ),
        );
        emit(VaSuccessState(List.from(_messages)));

        var result = await vaRepository.sendMessageWithDio(
            _chatHistory(), event.message);

        if (result["chat"] != null) {
          _messages.removeWhere((item) => item.isLoading == true);

          formattedTimestamp = DateFormat('h:mm a').format(DateTime.now());
          _messages.add(
            ChatMessage(
              isUser: false,
              content: result["chat"],
              timestamp: formattedTimestamp,
            ),
          );
        }
        if (result["product"].length > 0) {
          print(result["product"][0]["product_subcategory"]);
          isFinished = true;
          _messages.add(
            ChatMessage(
              isUser: false,
              content: result["product"].toString(),
              timestamp: formattedTimestamp,
            ),
          );
        }

        emit(VaSuccessState(List.from(_messages)));
      } catch (e) {
        emit(VaErrorState(e.toString()));
      }
    });

    on<SendAudioEvent>((event, emit) async {
      emit(VaLoadingState());
      try {
        await vaRepository.sendAudio(event.audioPath);
        _messages.add(
          ChatMessage(
            isUser: true,
            content: "Audio message sent",
            timestamp: "10 AM",
          ),
        );
        emit(VaSuccessState(List.from(_messages)));
      } catch (e) {
        emit(VaErrorState(e.toString()));
      }
    });
  }
}
