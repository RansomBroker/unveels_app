import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:test_new/unveels_virtual_assistant/screen/text_connection/bloc/va_state.dart';

class ProductFilterOption {
  final String label;
  final String value;
  ProductFilterOption({required this.label, required this.value});
}

class VaTextConnectionRepository {
  final Dio _dio = Dio();
  final String _endpoint = "https://chat-bot.evorty.id/chat";
  final String magnetoBaseUrl =
      "https://magento-1231949-4398885.cloudwaysapps.com";
  final String token = "hb2vxjo1ayu0agrkr97eprrl5rccqotc";

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

  Future<Map<String, dynamic>> getCategories() async {
    try {
      final Response response = await _dio.get(
        "$magnetoBaseUrl/rest/V1/categories",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
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

  List<Map<String, dynamic>> flattenCategoryTree(
      Map<String, dynamic> jsonTree) {
    List<Map<String, dynamic>> flatList = [];

    void flatten(Map<String, dynamic> node) {
      flatList.add({
        'id': node['id'],
        'parent_id': node['parent_id'],
        'name': node['name'],
        'is_active': node['is_active'],
        'position': node['position'],
        'level': node['level'],
        'product_count': node['product_count']
      });

      if (node['children_data'] != null) {
        for (var child in node['children_data']) {
          flatten(child);
        }
      }
    }

    flatten(jsonTree);
    return flatList;
  }

  List<int> findIdsByName(List<Map<String, dynamic>> flatList, String name) {
    return flatList
        .where((node) => node['name'] == name)
        .map<int>((node) => node['id'] as int)
        .toList();
  }

  Future<List<ProductFilterOption>> getColors() async {
    try {
      final Response response = await _dio.get(
        "$magnetoBaseUrl/en/rest/V1/products/attributes/color",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      if (response.statusCode == 200) {
        return (response.data["options"] as List<dynamic>).map((item) {
          return ProductFilterOption(
              label: item["label"], value: item["value"]);
        }).toList();
      } else {
        print("Gagal: Status code ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error saat mengirim permintaan: $e");
      return [];
    }
  }

  Future<List<ProductFilterOption>> getTextures() async {
    try {
      final Response response = await _dio.get(
        "$magnetoBaseUrl/en/rest/V1/products/attributes/texture",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      if (response.statusCode == 200) {
        return (response.data["options"] as List<dynamic>).map((item) {
          return ProductFilterOption(
              label: item["label"], value: item["value"]);
        }).toList();
      } else {
        print("Gagal: Status code ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error saat mengirim permintaan: $e");
      return [];
    }
  }

  Future<List<ProductInfo>> fetchProducts(
      {String? categoryId, String? color, String? texture}) async {
    String url = "$magnetoBaseUrl/rest/V1/products";

    final headers = {
      "Authorization": "Bearer $token",
    };

    final filters = [
      if (categoryId != null)
        {'field': 'category_id', 'value': categoryId, 'condition_type': 'in'},
      if (color != null) {'field': 'color', 'value': color},
      if (texture != null)
        {'field': 'texture', 'value': texture, 'condition_type': 'in'},
    ];

    final queryParams = {
      for (int i = 0; i < filters.length; i++) ...{
        'searchCriteria[filter_groups][$i][filters][0][field]': filters[i]
            ['field']!,
        'searchCriteria[filter_groups][$i][filters][0][value]': filters[i]
            ['value']!,
        if (filters[i].containsKey('condition_type'))
          'searchCriteria[filter_groups][$i][filters][0][condition_type]':
              filters[i]['condition_type']!,
      }
    };

    print(queryParams);
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return (response.data["items"] as List<dynamic>).map((item) {
          var customAttribute = item["custom_attributes"] as List<dynamic>;
          var imgLink = customAttribute
              .firstWhere((e) => e["attribute_code"] == "image")['value'];
          return ProductInfo(
              id: item['id'],
              imageUrl: "$magnetoBaseUrl/media/catalog/product$imgLink",
              name: item['name'],
              brand: "",
              price: item['price'].toDouble());
        }).toList();
      } else {
        print("Gagal: Status code ${response.statusCode}");
        return [];
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error response: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
      } else {
        print('Error message: ${e.message}');
      }
      return [];
    }
  }
}
