import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:record/record.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:test_new/unveels_virtual_assistant/components/va_typing_indicator.dart';
import 'package:test_new/unveels_virtual_assistant/screen/text_connection/bloc/va_bloc.dart';
import 'package:test_new/unveels_virtual_assistant/screen/text_connection/bloc/va_event.dart';
import 'package:test_new/unveels_virtual_assistant/screen/text_connection/bloc/va_state.dart';
import 'package:test_new/unvells/constants/arguments_map.dart';
import 'dart:ui' as ui;

import '../../../unvells/constants/app_routes.dart';

class VaTextConnection extends StatefulWidget {
  const VaTextConnection({super.key});

  @override
  State<VaTextConnection> createState() => _VaTextConnectionState();
}

class _VaTextConnectionState extends State<VaTextConnection> {
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _textController = TextEditingController();
  // final Record _audioRecorder = Record();
  // final AudioPlayer _audioPlayer = AudioPlayer();
  final SpeechToText _speechToText = SpeechToText();
  bool _isRecording = false;
  // String? _currentRecordingPath;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    activateSpeechRecognizer();
    super.initState();
  }

  void activateSpeechRecognizer() async {
    await _speechToText.initialize(finalTimeout: const Duration(seconds: 10));
    setState(() {});
  }

  void onRecognitionResult(SpeechRecognitionResult result) {
    print('_MyAppState.onRecognitionResult... ${result.recognizedWords}');

    _textController.text = result.recognizedWords;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.black),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Colors.black, Color(0xFF0E0A02), Color(0xFF47330A)],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<VaTextConnectionBloc, VaTextConnectionState>(
                builder: (context, state) {
                  if (state is VaInitialState) {
                    return const Center(child: Text("Start chatting!"));
                  } else if (state is VaLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is VaSuccessState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_scrollController.hasClients) {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      }
                    });
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return _buildMessageBubble(message);
                      },
                    );
                  } else if (state is VaErrorState) {
                    return Center(child: Text("Error: ${state.errorMessage}"));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser)
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/img_sarah.png'),
            ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              margin: message.isUser
                  ? const EdgeInsets.only(left: 40)
                  : const EdgeInsets.only(right: 40),
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              clipBehavior: Clip.antiAlias,
              decoration: message.isUser
                  ? const ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(1.00, 0.00),
                        end: Alignment(-1, 0),
                        colors: [
                          Color(0x99CA9C43),
                          Color(0x99906E2A),
                          Color(0x996A4F1A),
                          Color(0x99463109)
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                    )
                  : const ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(1.00, 0.00),
                        end: Alignment(-1, 0),
                        colors: [
                          Color(0xFFCA9C43),
                          Color(0xFF906E2A),
                          Color(0xFF6A4F1A),
                          Color(0xFF463109)
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
              child: message.isLoading
                  ? const VaTypingIndicator()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          message.content,
                          style: const TextStyle(color: Colors.white),
                          textDirection: Bidi.hasAnyRtl(message.content)
                              ? ui.TextDirection.rtl
                              : ui.TextDirection.ltr,
                          textAlign: Bidi.hasAnyRtl(message.content)
                              ? TextAlign.right
                              : TextAlign.left,
                        ),
                        if (message.productInfo != null)
                          _buildProductCard(message.productInfo!),
                        if (message.audioUrl != null)
                          _buildAudioPlayer(message.audioUrl!),
                        message.productInfo == null
                            ? Text(
                                textAlign: message.isUser
                                    ? TextAlign.right
                                    : TextAlign.left,
                                message.timestamp,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
            ),
          ),
          if (message.isUser)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: CircleAvatar(
                backgroundColor: Colors.white,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductCard(ProductInfo product) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        AppRoutes.productPage,
        arguments: getProductDataAttributeMap(
          product.name,
          product.id.toString(),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            product.brand,
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            'KWD ${product.price}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioPlayer(String audioUrl) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.brown.shade800,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.play_arrow, color: Colors.white),
            onPressed: () {
              // Implement audio playback
            },
          ),
          Expanded(
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.brown.shade700,
                borderRadius: BorderRadius.circular(15),
              ),
              // Add waveform visualization here
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.black.withOpacity(0.26),
      ),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(11, 12, 9, 12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    // padding: const EdgeInsets.fromLTRB(12, 8, 9, 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(color: const Color(0xFFCA9C43)),
                      color: Colors.black,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onSubmitted: (value) => _sendMessage(),
                            controller: _textController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Ask me anything...',
                              hintStyle: const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.black,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isRecording
                                ? CupertinoIcons.stop
                                : CupertinoIcons.mic,
                            color: Colors.white,
                          ),
                          onPressed: _toggleRecording,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFCA9C43),
                          Color(0xFF916E2B),
                          Color(0xFF6A4F1B),
                          Color(0xFF473209),
                        ],
                        stops: [0.0, 0.274, 0.594, 1.0],
                      ),
                    ),
                    padding: const EdgeInsets.all(0),
                    child: IconButton(
                      icon: const Icon(CupertinoIcons.paperplane,
                          color: Colors.white),
                      onPressed: _sendMessage,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      // _currentRecordingPath = await _audioRecorder.stop();
      await _speechToText.stop();
      setState(() {
        _isRecording = false;
      });
      _sendMessage();
    } else {
      // Request microphone permission
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        const SnackBar(content: Text('Microphone permission not granted'));
        return;
      }

      // Initialize audio session
      try {
        // await _audioRecorder.start();
        await _speechToText.listen(onResult: onRecognitionResult);
        setState(() {
          _isRecording = true;
        });
      } catch (e) {
        print('Error starting recording: $e');
      }
    }
  }

  void _sendMessage() {
    if (_textController.text.isNotEmpty) {
      context
          .read<VaTextConnectionBloc>()
          .add(SendMessageEvent(_textController.text));
      // setState(() {
      //   messages.add(ChatMessage(
      //     isUser: true,
      //     content: _textController.text,
      //     timestamp: "10 AM",
      //   ));
      // });
      _textController.clear();
    }
  }
}
