import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsCubit extends Cubit<String> {
  SettingsCubit() : super('') {
    getEmail();
  }

  static const emailId = 'emailId';

  Future<void> setEmail({
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(emailId, email);
  }

  Future<void> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString(emailId);
    emit(email ?? '');
  }
}
