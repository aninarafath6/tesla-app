import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int selectedNav = 0;

  // door locks
  bool rightLock = false;
  bool leftLock = false;
  bool bonetLock = false;
  bool trunkLock = false;

  void onChangeBottomNav(int index) {
    selectedNav = index;
    notifyListeners();
  }

  void updateLock(Lock lock) {
    if (lock == Lock.rightDoorLcok) {
      rightLock = !rightLock;
    } else if (lock == Lock.leftDoorLock) {
      leftLock = !leftLock;
    } else if (lock == Lock.bonnetLock) {
      bonetLock = !bonetLock;
    } else {
      trunkLock = !trunkLock;
    }
    notifyListeners();
  }
}

enum Lock {
  rightDoorLcok,
  leftDoorLock,
  trunkLook,
  bonnetLock,
}
