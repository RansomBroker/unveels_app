import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:test_new/unveels_virtual_assistant/components/va_suggestion_gift.dart';
import 'package:test_new/unveels_virtual_assistant/components/va_typing_indicator.dart';
import 'package:test_new/unveels_virtual_assistant/components/va_voice_record_button.dart';
import 'package:test_new/unveels_virtual_assistant/screen/text_connection/bloc/va_bloc.dart';
import 'package:test_new/unveels_virtual_assistant/screen/text_connection/bloc/va_event.dart';
import 'package:test_new/unveels_virtual_assistant/screen/text_connection/bloc/va_state.dart';
import 'package:test_new/unvells/constants/arguments_map.dart';
import 'dart:ui' as ui;

import '../../../unvells/constants/app_routes.dart';

class VaVoiceConnection extends StatefulWidget {
  const VaVoiceConnection({super.key});

  @override
  _VaVoiceConnection createState() => _VaVoiceConnection();
}

class _VaVoiceConnection extends State<VaVoiceConnection> {
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _textController = TextEditingController();
  final Record _audioRecorder = Record();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final SpeechToText _speechToText = SpeechToText();
  bool _isRecording = false;
  String? _currentRecordingPath;
  bool _isTextMode = false;
  String _textInput = '';
  String _prevOutputText = '';

  InAppWebViewController? webViewController;

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
    await _speechToText.initialize(finalTimeout: const Duration(seconds: 60));
    setState(() {});
  }

  void onRecognitionResult(SpeechRecognitionResult result) {
    print('_MyAppState.onRecognitionResult... ${result.recognizedWords}');
    setState(() {
      _textInput = result.recognizedWords;
    });
    _textController.text = result.recognizedWords;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Colors.black, Color(0xFF0E0A02), Color(0xFF47330A)],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: SizedBox(
                      height: 750,
                      child: InAppWebView(
                        initialSettings: InAppWebViewSettings(
                            mediaPlaybackRequiresUserGesture: false,
                            allowBackgroundAudioPlaying: true),
                        initialUrlRequest: URLRequest(
                            url: WebUri(
                                'https://unveels-webview.netlify.app/virtual-avatar-web')),
                        onWebViewCreated: (controller) async {
                          webViewController = controller;
                        },
                        onReceivedError: (controller, request, error) =>
                            {print('received error: $error')},
                        onConsoleMessage: (controller, consoleMessage) {
                          print(consoleMessage);
                        },
                      ),
                    ),
                  ),
                ),
                _textInput == ''
                    ? SizedBox(
                        height: 260,
                        child: BlocBuilder<VaTextConnectionBloc,
                            VaTextConnectionState>(
                          builder: (context, state) {
                            if (state is VaInitialState) {
                              const Center(child: Text("Start chatting!"));
                            } else if (state is VaLoadingState) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state is VaSuccessState) {
                              if (state.messages
                                  .where((i) => i.isLoading)
                                  .isEmpty) {
                                Text(_textInput);
                              }
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (_scrollController.hasClients) {
                                  _scrollController.jumpTo(_scrollController
                                      .position.maxScrollExtent);
                                }

                                if (state.audibleMessage != null) {
                                  if (state.audibleMessage!.text !=
                                      _prevOutputText) {
                                    setState(() {
                                      _prevOutputText =
                                          state.audibleMessage!.text;
                                    });
                                    webViewController
                                        ?.evaluateJavascript(
                                            source:
                                                'window.receiveTextAndLanguage("${state.audibleMessage?.text}", "${state.audibleMessage?.language}");')
                                        .then((value) => print(value));
                                  }
                                }
                              });

                              if (state.products != null) {
                                return VaSuggestedGiftsWidget(
                                    products: state.products!);
                              }

                              return ListView.builder(
                                controller: _scrollController,
                                itemCount: state.messages.isEmpty
                                    ? 0
                                    : state.messages.length,
                                itemBuilder: (context, index) {
                                  final message = state.messages[index];
                                  return _buildMessageBubble(message);
                                },
                              );
                            } else if (state is VaErrorState) {
                              return Center(
                                  child: Text("Error: ${state.errorMessage}"));
                            }
                            return const SizedBox();
                          },
                        ),
                      )
                    : SizedBox(
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _textInput,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ),
                _buildInputArea(),
              ],
            ),
          ),
        ].reversed.toList(),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    if (!message.isLoading) {
      return const SizedBox.shrink();
    }
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isTextMode = !_isTextMode;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _isTextMode
                          ? const Color.fromARGB(255, 202, 156, 67)
                          : const Color(0xFF171717),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      CupertinoIcons.keyboard,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                _isTextMode
                    ? Expanded(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(12, 8, 9, 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(color: const Color(0xFFCA9C43)),
                            color: Colors.black,
                          ),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                _textInput = value;
                              });
                            },
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
                      )
                    : Expanded(
                        child: VaVoiceRecordButton(
                            recording: _isRecording,
                            onLongPressStart: () => _toggleRecording(true),
                            onLongPressEnd: () => _toggleRecording(false)),
                      ),
                const SizedBox(width: 10),
                _isTextMode
                    ? Container(
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
                        ))
                    : Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF171717),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            CupertinoIcons.clear_thick,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleRecording(bool isRecording) async {
    setState(() {
      _isRecording = isRecording;
    });
    if (!isRecording) {
      // _currentRecordingPath = await _audioRecorder.stop();
      await _speechToText.stop();
      _sendMessage();
    } else {
      // Request microphone permission
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        const SnackBar(content: Text('Microphone permission not granted'));
        return;
      }

      try {
        // await _audioRecorder.start();
        await _speechToText.listen(onResult: onRecognitionResult);
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
      _textController.clear();
    }
    setState(() {
      _textInput = '';
    });
  }
}
