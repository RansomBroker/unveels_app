part of 'voice_command_cubit.dart';

enum VoiceCommandStatus { addCart }

abstract class VoiceCommandState {
  final String text;
  final double confidence;
  final VoiceCommandStatus? status;

  VoiceCommandState(this.text, this.confidence, {
    this.status,
  });
}

class VoiceCommandInitial extends VoiceCommandState {
  VoiceCommandInitial() : super("Listening...", 1.0);
}

class VoiceCommandReady extends VoiceCommandState {
  VoiceCommandReady() : super("Listening...", 1.0);
}


class VoiceCommandStoping extends VoiceCommandState {
  VoiceCommandStoping() : super("Stoping...", 1.0);
}



class VoiceCommandListening extends VoiceCommandState {
  VoiceCommandListening(String text, double confidence, { VoiceCommandStatus? status }) : super(text, confidence, status: status);
}

class VoiceCommandError extends VoiceCommandState {
  final String errorMessage;

  VoiceCommandError(this.errorMessage) : super("", 0.0);
}
