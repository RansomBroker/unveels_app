import 'package:dio/dio.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

import '../get_brand_name.dart';

class ProductData {
  final int id;
  final String imageUrl;
  final String name;
  final String brand;
  final double price;
  final String? color;
  final String? hexacode;

  ProductData({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.brand,
    required this.price,
    this.color,
    this.hexacode,
  });
}

class ProductRepository {
  final Dio _dio = Dio();
  final String _magnetoBaseUrl = ApiConstant.webUrl;
  final String _token = ApiConstant.techToken;

  Future<List<ProductData>> fetchProducts({
    String? categoryIds,
    String? color,
    String? texture,
    String? productType,
    String? productTypes,
    String? pattern,
    String? skinTone,
    String? shape,
    String? material,
    String? occasion,
    String? fabric,
    String? browMakeup,
    String? lenses,
    String? skinConcern,
  }) async {
    print("Fetch Product");
    String url = "$_magnetoBaseUrl/rest/V1/products";

    final headers = {
      "Authorization": "Bearer $_token",
    };

    final filters = [
      if (categoryIds != null)
        {'field': 'category_id', 'value': categoryIds, 'condition_type': 'in'},
      if (color != null)
        {'field': 'color', 'value': color, 'condition_type': 'eq'},
      if (texture != null)
        {'field': 'texture', 'value': texture, 'condition_type': 'in'},
      if (productTypes != null && productType != null)
        {'field': productType, 'value': productTypes, 'condition_type': 'in'},
      if (pattern != null)
        {'field': 'pattern', 'value': pattern, 'condition_type': 'finset'},
      if (shape != null)
        {'field': 'shape', 'value': shape, 'condition_type': 'eq'},
      if (material != null)
        {'field': 'material', 'value': material, 'condition_type': 'eq'},
      if (occasion != null)
        {'field': 'occasion', 'value': occasion, 'condition_type': 'eq'},
      if (fabric != null)
        {'field': 'fabric', 'value': fabric, 'condition_type': 'eq'},
      if (browMakeup != null)
        {
          'field': 'brow_makeup_product_type',
          'value': browMakeup,
          'condition_type': 'notnull'
        },
      if (lenses != null)
        {
          'field': 'lenses_product_type',
          'value': lenses,
          'condition_type': 'notnull'
        },
      if (skinConcern != null)
        {'field': 'skin_concern', 'value': skinConcern, 'condition_type': 'eq'},
    ];

    final queryParams = getQueryParamsFromFilter([
      ...filters,
      {
        'field': 'type_id',
        'value': 'simple,configurable',
        'condition_type': 'in'
      }
    ]);

    print(queryParams);

    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        Map<String, List<String>> brands = {};
        var result = (response.data["items"] as List<dynamic>).map((item) {
          var customAttribute = item["custom_attributes"] as List<dynamic>?;

          var brandId = customAttribute?.firstWhere(
            (e) => e["attribute_code"] == "brand",
            orElse: () => null,
          )?['value'];

          String? brandName =
              brandId != null ? getBrandNameByValue(brandId) : null;

          var extensionAttributes = item["extension_attributes"];
          if (extensionAttributes != null &&
              brandName != null &&
              extensionAttributes["configurable_product_links"] != null) {
            var productLinks = extensionAttributes["configurable_product_links"]
                    as List<dynamic>? ??
                [];
            for (var element in productLinks) {
              if (brands.containsKey(brandName)) {
                brands[brandName]!.add(element.toString());
              } else {
                brands[brandName] = [element.toString()];
              }
            }
          }

          return extensionAttributes?["configurable_product_links"];
        }).toList();

        Map<String, String> productToBrand = {};

        brands.forEach((brandName, productIds) {
          for (var productId in productIds) {
            productToBrand[productId] = brandName;
          }
        });

        var flattenedResult =
            result.where((e) => e != null).expand((e) => e).toList();

        final productsResponse = await _dio.get(
          url,
          queryParameters: getQueryParamsFromFilter([
            {
              'field': 'entity_id',
              'value': flattenedResult.join(","),
              'condition_type': 'in'
            },
            if (skinTone != null)
              {'field': 'skin_tone', 'value': skinTone, 'condition_type': 'eq'},
          ]),
          options: Options(headers: headers),
        );

        return (productsResponse.data["items"] as List<dynamic>).map((item) {
          var customAttribute = item["custom_attributes"] as List<dynamic>;
          var imgLink = customAttribute
              .firstWhere((e) => e["attribute_code"] == "image")?['value'];

          String? productColor = customAttribute.firstWhere(
              (e) => e["attribute_code"] == "color",
              orElse: () => null)?['value'];

          String? hexacode = customAttribute.firstWhere(
              (e) => e["attribute_code"] == "hexacode",
              orElse: () => null)?['value'];

          return ProductData(
            id: item['id'],
            imageUrl: "$_magnetoBaseUrl/media/catalog/product$imgLink",
            name: item['name'],
            brand: productToBrand[item['id'].toString()] ?? "",
            price: item['price']?.toDouble(),
            color: productColor,
            hexacode: hexacode,
          );
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

  Map<String, String>? getQueryParamsFromFilter(
      List<Map<String, String>> filters) {
    Map<String, String> queryParams = {
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
    return queryParams;
  }
}
