/*
 *


 *
 * /
 */

import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import '../constants/app_constants.dart';

class GraphQlApiCalling {
  final loggerLink = LoggerLink();
  final authLink = AuthLink(
    getToken: appStoragePref.getBearerTokenCheck,
  );
  final httpLink = HttpLink(
      ApiConstant.baseUrl,

      defaultHeaders: {
        'Content-Type': 'application/json',
        'Accept-Charset': 'utf-8',
        'current-currency': appStoragePref.getCurrencyCode(),
        'Platform': Platform.isAndroid? "android" : "iOS",
      },

  );

  GraphQLClient clientToQuery() {
    debugPrint("HEADER ----------------------------> ${httpLink.defaultHeaders}");
    return GraphQLClient(
      queryRequestTimeout: Duration(seconds: 20),
      cache: GraphQLCache(store: HiveStore()),
      // cache: GraphQLCache(),
      link: loggerLink.concat(authLink.concat(httpLink)),

    );
  }
}

class LoggerLink extends Link {
  @override
  Stream<Response> request(Request request, [NextLink? forward]) {
    debugPrint("BASE URL ----------------------------> ${ApiConstant.baseUrl}");
    log("OPERATION ----------------------------> ${request.operation}");
    return forward!(request);
  }
}
