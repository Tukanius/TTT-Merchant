import 'package:flutter/material.dart';
import 'package:ttt_merchant_flutter/api/general_api.dart';
import 'package:ttt_merchant_flutter/models/general/general_init.dart';

class GeneralProvider extends ChangeNotifier {
  GeneralInit general = GeneralInit();

  init() async {
    general = await GeneralApi().getInit();
    notifyListeners();
    return general;
  }
}
