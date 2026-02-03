import 'package:flutter/material.dart';
import 'package:myapp/core/service/token_service.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/network/apis.dart';
import 'package:myapp/network/network.dart';

class AuthProvider extends ChangeNotifier {
  String? _avatarUrl;
  bool _loading = false;

  bool get loading => _loading;
  String? get avatarUrl => _avatarUrl;

  Future<void> uploadAvatar(String path) async {
    _loading = true;
    notifyListeners();

    final data = await Network.uploadFiles(path);
    if (data != null) {
      final attachement = Network.parseAttachment(data);
      _avatarUrl = attachement.location;
    }

    _loading = false;
    notifyListeners();
  }

  Future<bool> signUp(String name, String email, String password) async {
    _loading = true;
    notifyListeners();

    final result = await Network.request(
      api: Apis.isAvailable,
      mode: RequestMode.post,
      data: {'email': email},
    );

    if (result == null || Network.isAvailable(result)) {
      _loading = false;
      notifyListeners();
      return false;
    }

    const placeHolder = "https://i.imgur.com/AHXwxdw.jpeg";
    final user = User(
      id: 0,
      email: email,
      password: password,
      name: name,
      avatar: _avatarUrl ?? placeHolder,
    );

    final data = await Network.request(
      api: Apis.users,
      mode: RequestMode.post,
      data: user.toJson(),
    );

    _loading = false;
    notifyListeners();
    return data != null;
  }

  Future<bool> login(String email, String password) async {
    _loading = true;
    notifyListeners();

    final data = await Network.request(
      api: Apis.login,
      mode: RequestMode.post,
      data: {"email": email, "password": password},
    );
    _loading = false;
    if (data != null) {
      final token = Network.parseToken(data);
      await TokenService.saveTokens(token: token);
    }

    notifyListeners();
    return data != null;
  }
}
