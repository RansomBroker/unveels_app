import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'va_event.dart';
import 'va_repository.dart';
import 'va_state.dart';


class VaTextConnectionBloc
    extends Bloc<VaTextConnectionEvent, VaTextConnectionState> {
  final VaTextConnectionRepository vaRepository;
  final List<ChatMessage> _messages = [];
  final List<Map<String, dynamic>> _categories = [];
  final List<ProductFilterOption> _colorOptions = [];
  final List<ProductFilterOption> _textureOptions = [];
  final List<Map<String, String>> _chatHistory = [];
  bool isFinished = false;

  VaTextConnectionBloc(this.vaRepository) : super(VaInitialState()) {
    on<SendMessageEvent>((event, emit) async {
      emit(VaLoadingState());
      try {
        String formattedTimestamp = DateFormat('h:mm a').format(DateTime.now());

        if (isFinished) {
          _chatHistory.clear();
          isFinished = false;
        }
        _chatHistory.add({"text": event.message, "sender": "user"});

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
            _chatHistory, event.message);

        if (result["chat"] != null) {
          _messages.removeWhere((item) => item.isLoading == true);

          formattedTimestamp = DateFormat('h:mm a').format(DateTime.now());

          _chatHistory.add({"text": result["chat"], "sender": "agent"});

          _messages.add(
            ChatMessage(
              isUser: false,
              content: result["chat"],
              timestamp: formattedTimestamp,
            ),
          );
        }
        if (result["product"].length > 0) {
          var productToFetch = result["product"][0];
          isFinished = true;

          if (_categories.isEmpty) {
            var categories = await vaRepository.getCategories();
            _categories.addAll(vaRepository.flattenCategoryTree(categories));
            _colorOptions.addAll(await vaRepository.getColors());
            _textureOptions.addAll(await vaRepository.getTextures());
          }

          var categoryIds = [];
          var textureIds = [];
          var colorIds = [];

          // if (productToFetch["category"] != null) {
          //   for (var category in productToFetch["category"]) {
          //     categoryIds
          //         .addAll(vaRepository.findIdsByName(_categories, category));
          //   }
          // }

          if (productToFetch["sub_category"] != null) {
            for (var category in productToFetch["sub_category"]) {
              categoryIds
                  .addAll(vaRepository.findIdsByName(_categories, category));
            }
          }

          if (productToFetch["texture"] != null) {
            for (var texture in productToFetch["texture"]) {
              textureIds.addAll(_textureOptions
                  .where((item) => item.label == texture)
                  .map((item) => item.value)
                  .toList());
            }
          }

          if (productToFetch["color"] != null) {
            for (var color in productToFetch["color"]) {
              colorIds.addAll(_textureOptions
                  .where((item) => item.label == color)
                  .map((item) => item.value)
                  .toList());
            }
          }

          var products = await vaRepository.fetchProducts(
            categoryId: categoryIds.isEmpty ? null : categoryIds.join(","),
            color: colorIds.isEmpty ? null : colorIds.join(","),
            texture: textureIds.isEmpty ? null : textureIds.join(","),
          );

          for (var product in products) {
            _messages.add(
              ChatMessage(
                  isUser: false,
                  content: "",
                  timestamp: formattedTimestamp,
                  productInfo: product),
            );
          }
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
