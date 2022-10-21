import 'package:shared_preferences/shared_preferences.dart';
import 'filter_model.dart';

class PreferencesService {
  Future saveSettings(filterSettings settings) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setDouble('maxCal', settings.maxCal);
    await preferences.setDouble('minCal', settings.minCal);
    await preferences.setDouble("maxReadyTime", settings.maxReadyTime);
  }

  Future<filterSettings> getSettings() async {
    final preferences = await SharedPreferences.getInstance();
    final maxCal = preferences.getDouble('maxCal');
    final minCal = preferences.getDouble('minCal');
    final maxReadyTime = preferences.getDouble('maxReadyTime');

    return filterSettings(
      maxCal: maxCal ?? 0,
      minCal: minCal ?? 0,
      maxReadyTime: maxReadyTime ?? 0,
    );
  }
}
