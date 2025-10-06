import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveHost(bool host) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('MAINHOST', host);
}

Future<bool?> getHost() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('MAINHOST');
}
