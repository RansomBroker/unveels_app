import 'package:equatable/equatable.dart';


class ChatMessage {
  final bool isUser;
  final String content;
  final String timestamp;
  final ProductInfo? productInfo;
  final String? audioUrl;
  final bool isLoading;

  ChatMessage({
    required this.isUser,
    required this.content,
    required this.timestamp,
    this.productInfo,
    this.audioUrl,
    this.isLoading = false,
  });
}

class AudibleChatMessage {
  final String text;
  final String language;

  AudibleChatMessage({required this.text, required this.language});
}

class ProductInfo {
  final int id;
  final String imageUrl;
  final String name;
  final String brand;
  final double price;

  ProductInfo({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.brand,
    required this.price,
  });
}

abstract class VaTextConnectionState extends Equatable {
  const VaTextConnectionState();

  @override
  List<Object?> get props => [];
}

class VaInitialState extends VaTextConnectionState {}

class VaLoadingState extends VaTextConnectionState {}

class VaSuccessState extends VaTextConnectionState {
  final List<ChatMessage> messages;
  final AudibleChatMessage? audibleMessage;
  final List<ProductInfo>? products;

  const VaSuccessState(this.messages, [this.audibleMessage, this.products]);

  @override
  List<Object?> get props => [messages, audibleMessage];
}

class VaErrorState extends VaTextConnectionState {
  final String errorMessage;

  const VaErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
