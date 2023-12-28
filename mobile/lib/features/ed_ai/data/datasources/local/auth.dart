import 'package:mobile/core/errors/exception.dart';
import 'package:mobile/features/ed_ai/data/models/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken({required AuthModel auth});
  Future<AuthModel> getToken();
  Future<void> deleteToken();
  Future<bool> isValidToken();
}

const String authCacheKey = 'authCacheKey';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences plugin;

  AuthLocalDataSourceImpl({required this.plugin});

  @override
  Future<void> cacheToken({required AuthModel auth}) {
    return plugin.setString(authCacheKey, auth.token);
  }

  @override
  Future<void> deleteToken() {
    return plugin.remove(authCacheKey);
  }

  @override
  Future<AuthModel> getToken() {
    final token = plugin.getString(authCacheKey);
    if (token != null) {
      return Future.value(AuthModel(token: token));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> isValidToken() async {
    final token = plugin.getString(authCacheKey);
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }
}
