import 'package:flutter/material.dart';

class CustomAnimationController {
  static late AnimationController _batteryAnimationController;
  static late AnimationController _tempAnimationController;

  static AnimationController get batteryAnimationController =>
      _batteryAnimationController;
  static AnimationController get tempAnimationController =>
      _tempAnimationController;

  static void setBatteryAnimation(
      {required TickerProvider tickerProvider, required Duration duration}) {
    _batteryAnimationController =
        AnimationController(vsync: tickerProvider, duration: duration);
  }

  static void setTempAnimation(
      {required TickerProvider tickerProvider, required Duration duration}) {
    _tempAnimationController =
        AnimationController(vsync: tickerProvider, duration: duration);
  }

  static void disposeBatteryAnimation() =>
      _batteryAnimationController.dispose();
  static void disposeTempAnimation() => _tempAnimationController.dispose();
}
