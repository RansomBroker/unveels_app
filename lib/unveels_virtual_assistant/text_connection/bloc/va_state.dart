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

class ProductInfo {
  final String imageUrl;
  final String name;
  final String brand;
  final double price;

  ProductInfo({
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

  const VaSuccessState(this.messages);

  @override
  List<Object?> get props => [messages];
}

class VaErrorState extends VaTextConnectionState {
  final String errorMessage;

  const VaErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
