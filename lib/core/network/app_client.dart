import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/api_endpoints.dart';
import '../constants/app_constant.dart';
import '../storage/local_storage.dart';
import '../utils/logger.dart';

class ApiClient {
  /// 🔹 Common headers
  static Future<Map<String, String>> _headers() async {
    final token = await LocalStorage.getTokenSync();

    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  /// 🔹 GET
  static Future<dynamic> get(String endpoint) async {
    final url = Uri.parse(ApiEndpoints.baseUrl + endpoint);
    AppLogger.debug("GET → $url", tag: "API");

    try {
      final response = await http
          .get(url, headers: await _headers())
          .timeout(const Duration(seconds: AppConstants.apiTimeoutSeconds));

      return _handleResponse(response);
    } catch (e, s) {
      AppLogger.error("GET failed", error: e, stackTrace: s, tag: "API");
      rethrow;
    }
  }

  /// 🔹 POST
  static Future<dynamic> post(
      String endpoint, {
        Map<String, dynamic>? body,
      }) async {
    final url = Uri.parse(ApiEndpoints.baseUrl + endpoint);
    AppLogger.debug("POST → $url | body: $body", tag: "API");

    try {
      final response = await http
          .post(
        url,
        headers: await _headers(),
        body: jsonEncode(body ?? {}),
      )
          .timeout(const Duration(seconds: AppConstants.apiTimeoutSeconds));

      return _handleResponse(response);
    } catch (e, s) {
      AppLogger.error("POST failed", error: e, stackTrace: s, tag: "API");
      rethrow;
    }
  }

  /// 🔹 PUT
  static Future<dynamic> put(
      String endpoint, {
        Map<String, dynamic>? body,
      }) async {
    final url = Uri.parse(ApiEndpoints.baseUrl + endpoint);
    AppLogger.debug("PUT → $url | body: $body", tag: "API");

    try {
      final response = await http
          .put(
        url,
        headers: await _headers(),
        body: jsonEncode(body ?? {}),
      )
          .timeout(const Duration(seconds: AppConstants.apiTimeoutSeconds));

      return _handleResponse(response);
    } catch (e, s) {
      AppLogger.error("PUT failed", error: e, stackTrace: s, tag: "API");
      rethrow;
    }
  }

  /// 🔹 DELETE
  static Future<dynamic> delete(String endpoint) async {
    final url = Uri.parse(ApiEndpoints.baseUrl + endpoint);
    AppLogger.debug("DELETE → $url", tag: "API");

    try {
      final response = await http
          .delete(url, headers: await _headers())
          .timeout(const Duration(seconds: AppConstants.apiTimeoutSeconds));

      return _handleResponse(response);
    } catch (e, s) {
      AppLogger.error("DELETE failed", error: e, stackTrace: s, tag: "API");
      rethrow;
    }
  }

  /// 🔹 Central response handler
  static dynamic _handleResponse(http.Response response) {
    AppLogger.debug(
      "RESPONSE [${response.statusCode}] → ${response.body}",
      tag: "API",
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isNotEmpty
          ? jsonDecode(response.body)
          : null;
    }

    if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    }

    throw Exception(
      "API Error ${response.statusCode}: ${response.body}",
    );
  }
}