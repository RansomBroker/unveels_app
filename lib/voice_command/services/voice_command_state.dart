part of 'voice_command_cubit.dart';

abstract class VoiceCommandState {
  final String text;
  final double confidence;

  VoiceCommandState(this.text, this.confidence);
}

class VoiceCommandInitial extends VoiceCommandState {
  VoiceCommandInitial() : super("Listening...", 1.0);
}

class VoiceCommandReady extends VoiceCommandState {
  VoiceCommandReady() : super("Listening...", 1.0);
}



class VoiceCommandListening extends VoiceCommandState {
  VoiceCommandListening(String text, double confidence) : super(text, confidence);
}

class VoiceCommandError extends VoiceCommandState {
  final String errorMessage;

  VoiceCommandError(this.errorMessage) : super("", 0.0);
}
