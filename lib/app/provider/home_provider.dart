import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int selectedNav = 0;

  // door locks
  bool rightLock = false;
  bool leftLock = false;
  bool bonnetLock = false;
  bool trunkLock = false;

  late AnimationController animationController;

  void onChangeBottomNav(int index) {
    selectedNav = index;
    notifyListeners();
  }

  void updateLock(Lock lock) {
    if (lock == Lock.rightDoorLock) {
      rightLock = !rightLock;
    } else if (lock == Lock.leftDoorLock) {
      leftLock = !leftLock;
    } else if (lock == Lock.bonnetLock) {
      bonnetLock = !bonnetLock;
    } else {
      trunkLock = !trunkLock;
    }
    notifyListeners();
  }
}

enum Lock {
  rightDoorLock,
  leftDoorLock,
  trunkLook,
  bonnetLock,
}
