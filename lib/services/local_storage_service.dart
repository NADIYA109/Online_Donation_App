import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String onboardingKey = 'onboarding_done';

  // Save onboarding completion status
  static Future<void> setOnboardingDone(bool isDone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingKey, isDone);
  }

  // Check if onboarding is completed
  static Future<bool> isOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingKey) ?? false;
  }
}
