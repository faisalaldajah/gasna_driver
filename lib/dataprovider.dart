
import 'package:flutter/material.dart';

import 'datamodels/history.dart';

class AppData extends ChangeNotifier{

  var earnings = '0';
  int tripCount = 0;
  List<String> tripHistoryKeys = [];
  List<History> tripHistory = [];

  void updateEarnings(String newEarnings){
    earnings = newEarnings;
    notifyListeners();
  }

  void updateTripCount(int newTripCount){
    tripCount = newTripCount;
    notifyListeners();
  }

  void updateTripKeys(List<String> newKeys){
    tripHistoryKeys = newKeys;
    notifyListeners();
  }

  void updateTripHistory(History historyItem){
    tripHistory.add(historyItem);
    notifyListeners();
  }
}