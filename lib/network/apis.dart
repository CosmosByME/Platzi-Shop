import 'package:flutter/foundation.dart';

sealed class Apis {
  static const String _developmentBaseUrl = 'api.escuelajs.co';
  static const String _testBaseUrl = 'api.escuelajs.co';
  static const String _productionBaseUrl = 'api.escuelajs.co';

  static String get baseUrl {
    if (kReleaseMode) {
      return _productionBaseUrl;
    } else if (kProfileMode) {
      return _testBaseUrl;
    } else {
      return _developmentBaseUrl;
    }
  }

  static const headers = {"Content-type": "application/json"};
  static const headersForUpload = {"Content-type": "multipart/form-data"};

  static Map<String, String> headersForAuth(String accessToken) => {
    "Authorization": "Bearer $accessToken",
  };

  static Map<String, Object?> dataRefreshToken(String? refreshToken) => {
    "refreshToken": refreshToken,
  };

  static const products = "/api/v1/products";
  static const categories = "/api/v1/categories";
  static const users = "/api/v1/users";
  static const isAvailable = "/api/v1/users/is-available";
  static const login = "/api/v1/auth/login";
  static const profile = "/api/v1/auth/profile";
  static const refreshToken = "/api/v1/auth/refresh-token";
  static const fileUpload = "/api/v1/files/upload";

  static String productsByCategory(String categoryID) {
    return "api/v1/categories/$categoryID/products";
  }

  static String getFile(String fileName) {
    return "api/v1/files/$fileName";
  }

  static Map<String, String> paginationProduct(int offset, int limit) => {
    "offset": offset.toString(),
    "limit": limit.toString(),
  };
  static Map<String, String> searchProduct(String title) => {"title": title};
}
