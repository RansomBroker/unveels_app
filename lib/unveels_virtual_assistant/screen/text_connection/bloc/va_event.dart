import 'package:equatable/equatable.dart';

abstract class VaTextConnectionEvent extends Equatable {
  const VaTextConnectionEvent();
}

class SendMessageEvent extends VaTextConnectionEvent {
  final String message;

  const SendMessageEvent(this.message);

  @override
  List<Object?> get props => [message];
}

class SendAudioEvent extends VaTextConnectionEvent {
  final String audioPath;

  const SendAudioEvent(this.audioPath);

  @override
  List<Object?> get props => [audioPath];
}
