import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum ApiServiceMethodType {
  get,
  post,
  delete,
}

const baseUrl = 'https://api.stripe.com/v1';
final Map<String, String> requestHeaders = {
  'Content-Type': 'application/x-www-form-urlencoded',
  'Authorization':
      'Bearer sk_test_51NleA3BYVJTtq48mcNufuLvW5uC5hyOZHm0IDzuRf2F9Ahtn1nW4AXqJYpPQKqoFNeT8zW3CUF11x1Kmf2MDEAZI00lfdGhUMP',
};

Future<Map<String, dynamic>?> apiService({
  required ApiServiceMethodType requestMethod,
  required String endpoint,
  Map<String, dynamic>? requestBody,
}) async {
  final requestUrl = '$baseUrl/$endpoint';

  // +++++++++++++++++
  // ++ GET REQUEST ++
  // +++++++++++++++++

  if (requestMethod == ApiServiceMethodType.get) {
    try {
      final requestResponse = await http.get(
        Uri.parse(requestUrl),
        headers: requestHeaders,
      );

      return json.decode(requestResponse.body);
    } catch (err) {
      debugPrint("Error: $err");
    }
  }
  // ++++++++++++++++++
  // ++ DELETE REQUEST ++
  // ++++++++++++++++++
  if (requestMethod == ApiServiceMethodType.delete) {
    try {
      final requestResponse = await http.delete(
        Uri.parse(requestUrl),
        headers: requestHeaders,
      );
      log(requestResponse.statusCode.toString());
      return json.decode(requestResponse.body);
    } catch (err) {
      debugPrint("Error: $err");
    }
  }

  // ++++++++++++++++++
  // ++ POST REQUEST ++
  // ++++++++++++++++++

  try {
    final requestResponse = await http.post(
      Uri.parse(requestUrl),
      headers: requestHeaders,
      body: requestBody,
    );

    return json.decode(requestResponse.body);
  } catch (err) {
    debugPrint("Error: $err");
  }
  return null;
}
