import 'package:myapp/core/service/local_service.dart';
import 'package:myapp/models/token.dart';

sealed class TokenService {
  static Future<void> saveAccessToken(String token) =>
      LocalService.store(StorageKey.accessToken, token);
  static Future<void> saveRefreshToken(String token) =>
      LocalService.store(StorageKey.refreshToken, token);

  static Future<String?> get accessToken =>
      LocalService.read(StorageKey.accessToken);
  static Future<String?> get refreshToken =>
      LocalService.read(StorageKey.refreshToken);

  static Future<void> deleteTokens() async {
    await Future.wait([
      LocalService.remove(StorageKey.accessToken),
      LocalService.remove(StorageKey.refreshToken),
    ]);
  }

  static Future<void> saveTokens({required Token token}) async {
    await Future.wait([
      LocalService.store(StorageKey.accessToken,token.accessToken),
      LocalService.store(StorageKey.refreshToken,token.refreshToken),
    ]);
  }
}
