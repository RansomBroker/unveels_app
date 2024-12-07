part of 'voice_cmd_cubit.dart';

abstract class VoiceCmdState {
  final String text;
  final double confidence;

  VoiceCmdState(this.text, this.confidence);
}

class VoiceCommandInitial extends VoiceCmdState {
  VoiceCommandInitial() : super("Listening...", 1.0);
}

class VoiceCommandReady extends VoiceCmdState {
  VoiceCommandReady() : super("Listening...", 1.0);
}



class VoiceCommandListening extends VoiceCmdState {
  VoiceCommandListening(String text, double confidence) : super(text, confidence);
}

class VoiceCommandResult extends VoiceCmdState {
  VoiceCommandResult(String text, double confidence) : super(text, confidence);
}

class VoiceCommandError extends VoiceCmdState {
  final String errorMessage;

  VoiceCommandError(this.errorMessage) : super("", 0.0);
}
