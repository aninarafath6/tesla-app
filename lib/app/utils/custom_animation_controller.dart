import 'package:flutter/material.dart';

class CustomAnimationController {
  static late AnimationController _batteryAnimationController;
  static late AnimationController _tempAnimationController;
  static late AnimationController _heatAnimationController;
 static late AnimationController _coolAnimationController;

  static AnimationController get batteryAnimationController =>
      _batteryAnimationController;
  static AnimationController get tempAnimationController =>
      _tempAnimationController;

  static AnimationController get heatAnimationController =>
      _heatAnimationController;

  static AnimationController get coolAnimationController => _coolAnimationController;

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
static void setCoolAnimation(
      {required TickerProvider tickerProvider, required Duration duration}) {
    _coolAnimationController =
        AnimationController(vsync: tickerProvider, duration: duration);
  }
  static void setHeatAnimation(
      {required TickerProvider tickerProvider, required Duration duration}) {
    _heatAnimationController =
        AnimationController(vsync: tickerProvider, duration: duration);
  }
  static void disposeBatteryAnimation() =>
      _batteryAnimationController.dispose();
  static void disposeTempAnimation() => _tempAnimationController.dispose();
  static void disposeHeatAnimation() => _heatAnimationController.dispose();
  static void disposeCoolAnimation() => _coolAnimationController.dispose();


}
