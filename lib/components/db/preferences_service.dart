import 'package:grupp_5/components/models/filter_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future saveSettings(FilterSettings settings) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setDouble('maxCal', settings.maxCal);
    await preferences.setDouble('minCal', settings.minCal);
    await preferences.setDouble("maxReadyTime", settings.maxReadyTime);
  }

  Future<FilterSettings> getSettings() async {
    final preferences = await SharedPreferences.getInstance();
    final maxCal = preferences.getDouble('maxCal');
    final minCal = preferences.getDouble('minCal');
    final maxReadyTime = preferences.getDouble('maxReadyTime');

    return FilterSettings(
      maxCal: maxCal ?? 0,
      minCal: minCal ?? 0,
      maxReadyTime: maxReadyTime ?? 15,
    );
  }
}
