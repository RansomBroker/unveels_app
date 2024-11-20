import 'dart:convert';
import 'package:dio/dio.dart';

class VaTextConnectionRepository {
  final Dio _dio = Dio();
  final String _endpoint = "http://chat-bot.evorty.id/chat";

  Future<void> sendMessage(String message) async {
    await Future.delayed(const Duration(seconds: 1));
    print("Pesan terkirim: $message");
  }

  Future<void> sendAudio(String audioPath) async {
    await Future.delayed(const Duration(seconds: 1));
    print("Audio terkirim: $audioPath");
  }

  Future<Map<String, dynamic>> sendMessageWithDio(
      List<Map<String, String>> chatHistory, String userMsg) async {
    try {
      final Map<String, dynamic> requestBody = {
        "chatHistory": chatHistory,
        "userMsg": userMsg,
      };

      final Response response = await _dio.post(
        _endpoint,
        data: jsonEncode(requestBody),
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Respons diterima: ${response.data}");
        return response.data;
      } else {
        print("Gagal: Status code ${response.statusCode}");
        return {};
      }
    } catch (e) {
      print("Error saat mengirim permintaan: $e");
      return {};
    }
  }
}
