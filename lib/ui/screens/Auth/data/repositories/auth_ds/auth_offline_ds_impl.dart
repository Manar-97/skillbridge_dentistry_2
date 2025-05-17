import 'package:injectable/injectable.dart';
import '../../../../../utils/core/shared_pref_hepler.dart';
import '../../../../../utils/core/shared_pref_key.dart.dart';
import 'auth_ds.dart';

@Injectable(as: AuthOfflineDS)
class AuthOfflineDSImpl implements AuthOfflineDS {
  @override
  Future<void> deleteToken() async {
    await SharedPrefHelper.removeSecureString(SharedPrefKeys.token);
  }

  @override
  Future<String> getToken() async {
    return await SharedPrefHelper.getSecureString(SharedPrefKeys.token) ?? "";
  }

  @override
  Future<void> saveToken(String token) async {
    print('Saving token: $token'); // تأكدي من طباعتها
    await SharedPrefHelper.setSecureString(SharedPrefKeys.token, token);
    print('Token saved');
  }
}
