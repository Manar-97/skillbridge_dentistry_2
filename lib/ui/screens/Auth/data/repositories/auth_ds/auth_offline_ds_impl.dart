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

  @override
  Future<void> saveConsultantId(String consultantId) async {
    print('Saving consultantId: $consultantId'); // تأكدي من طباعتها
    await SharedPrefHelper.setSecureString('consultantId', consultantId);
    print('consultantId saved');
  }

  @override
  Future<void> saveFreshGradId(String freshGradId) async {
    print('Saving freshGradId: $freshGradId'); // تأكدي من طباعتها
    await SharedPrefHelper.setSecureString('freshGradId', freshGradId);
    print('freshGradId saved');
  }

  @override
  Future<void> saveUserId(String userId) async {
    print('Saving userId: $userId'); // تأكدي من طباعتها
    await SharedPrefHelper.setSecureString('userId', userId);
    print('userId saved');
  }
}
