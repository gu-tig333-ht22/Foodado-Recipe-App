import 'package:shared_preferences/shared_preferences.dart';
import '../models/filter_model.dart';

class PreferencesService {
  Future saveSettings(FilterSettings settings) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setDouble('maxCal', settings.maxCal);
    await preferences.setDouble('minCal', settings.minCal);
    await preferences.setDouble("maxReadyTime", settings.maxReadyTime);
    await preferences.setString("selectedDiet", settings.selectedDiet);
    await preferences.setString("selectedType", settings.selectedType);
  }

  Future<FilterSettings> getSettings() async {
    final preferences = await SharedPreferences.getInstance();
    final maxCal = preferences.getDouble('maxCal');
    final minCal = preferences.getDouble('minCal');
    final maxReadyTime = preferences.getDouble('maxReadyTime');
    final selectedDiet = preferences.getString('selectedDiet');
    final selectedType = preferences.getString('selectedType');

    return FilterSettings(
      maxCal: maxCal ?? 0,
      minCal: minCal ?? 0,
      maxReadyTime: maxReadyTime ?? 15,
      selectedDiet: selectedDiet ?? '',
      selectedType: selectedType ?? '',
    );
  }
}
