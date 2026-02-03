import 'dart:convert';

import 'package:http/http.dart';
import 'package:myapp/core/routes/router.dart';
import 'package:myapp/core/service/token_service.dart';
import 'package:myapp/models/attachment.dart';
import 'package:myapp/models/category.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/models/token.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/network/apis.dart';

enum RequestMode { get, post, put, patch, delete }

sealed class Network {
  static Future<String?> request({
    required String api,
    Object? id,
    RequestMode mode = RequestMode.get,
    bool useToken = false,
    Map<String, Object?>? data,
    Map<String, String> headers = Apis.headers,
    Map<String, String>? queryParams,
  }) async {
    var url = Uri.http(
      Apis.baseUrl,
      "$api${(id != null) ? "/$id" : ""}",
      queryParams,
    );

    final String body = jsonEncode(data);

    if (useToken) {
      final accessToken = await TokenService.accessToken;
      if (accessToken != null) {
        headers = Map<String, String>.of(Apis.headers)..addAll(Apis.headersForAuth(accessToken));
      }
    }

    final Response response = await switch (mode) {
      RequestMode.get => get(url, headers: headers),
      RequestMode.post => post(url, headers: headers, body: body),
      RequestMode.put => put(url, headers: headers, body: body),
      RequestMode.patch => patch(url, headers: headers, body: body),
      RequestMode.delete => delete(url, headers: headers),
    };

    if (response.statusCode == 200 || response.statusCode == 201) {
      return utf8.decoder.convert(response.bodyBytes);
    } else if (response.statusCode == 401) {
      final result = await _refreshTokens();
      if (result) {
        return request(
            api: api, id: id, mode: mode, queryParams: queryParams, useToken: useToken, data: data, headers: headers);
      }
    }
    return null;
  }

  static Future<bool> _refreshTokens() async {
    final refreshToken = await TokenService.refreshToken;
    final url = Uri.https(Apis.baseUrl, Apis.refreshToken);
    final response = await post(url, body: jsonEncode(Apis.dataRefreshToken(refreshToken)), headers: Apis.headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = utf8.decoder.convert(response.bodyBytes);
      await TokenService.saveTokens(token: parseToken(data));
      return true;
    } else if (response.statusCode == 401) {
      await TokenService.deleteTokens();
      AppRoute.router.go(Routes.login);
    }
    return false;
  }


  static Future<String?> uploadFiles(String path) async {
    final url = Uri.http(Apis.baseUrl, Apis.fileUpload);
    final multiPartFile = await MultipartFile.fromPath('file', path);

    final request = MultipartRequest(RequestMode.post.name, url);
    request.files.add(multiPartFile);
    request.headers.addAll(Apis.headersForUpload);

    final StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      return response.stream.bytesToString();
    }
    return null;
  }

  static List<Category> parseCategories(String responseBody) {
    final data = jsonDecode(responseBody) as List;
    return data.map((e) => Category.fromJson(e)).toList();
  }

  static Category parseCategory(String responseBody) {
    return Category.fromJson(jsonDecode(responseBody));
  }

  static Product parseProduct(String responseBody) {
    return Product.fromJson(jsonDecode(responseBody));
  }

  static List<Product> parseProducts(String responseBody) {
    final data = jsonDecode(responseBody) as List;
    return data.map((e) => Product.fromJson(e)).toList();
  }

  static Attachment parseAttachment(String responseBody) {
    return Attachment.fromJson(jsonDecode(responseBody));
  }

  static Token parseToken(String responseBody) {
    return Token.fromJson(jsonDecode(responseBody));
  }

  static bool isAvailable(String data) {
    final json = jsonDecode(data);
    return json["isAvailable"] ?? false;
  }
  static User parseUser(String data) {
    final json = jsonDecode(data);
    return User.fromJson(json);
  }
}
