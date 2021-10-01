import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  bool rightLock = false;

  void updateLock(Lock lock) {
    if (lock == Lock.rightDoorLcok) {
      rightLock = !rightLock;
      notifyListeners();
    }
  }
}

enum Lock {
  rightDoorLcok,
  leftDoorLock,
  trunkLook,
  bonnetLock,
}
