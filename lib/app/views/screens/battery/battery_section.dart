import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:tesla/app/constants/app_images.dart';
import 'package:tesla/app/provider/home_provider.dart';
import 'package:tesla/app/utils/custom_animation_controller.dart';
import 'package:tesla/app/views/screens/battery/battery_status.dart';

class BatterySection extends StatefulWidget {
  const BatterySection({Key? key, this.constraints}) : super(key: key);
  final BoxConstraints? constraints;

  @override
  State<BatterySection> createState() => _BatterySectionState();
}

class _BatterySectionState extends State<BatterySection>
    with SingleTickerProviderStateMixin {
  late Animation _batteryAnimation;
  late Animation<double> _batteryStatusAnimation;

  @override
  void initState() {
    super.initState();
    CustomAnimationController.setBatteryAnimation(
        tickerProvider: this, duration: const Duration(milliseconds: 600));

    _batteryAnimation = CurvedAnimation(
        parent: CustomAnimationController.batteryAnimationController,
        curve: const Interval(0, .5));
    _batteryStatusAnimation = CurvedAnimation(
      parent: CustomAnimationController.batteryAnimationController,
      curve: const Interval(0.8, 1),
    );
  }

  @override
  void dispose() {
    CustomAnimationController.disposeBatteryAnimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CustomAnimationController.batteryAnimationController,
      builder: (context, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Opacity(
                opacity: _batteryAnimation.value,
                child: SvgPicture.asset(
                  AppImages.battery,
                  width: widget.constraints!.maxWidth * .45,
                ),
              ),
            ),
            Positioned(
              top: 50 * (1 - _batteryStatusAnimation.value),
              width: widget.constraints!.maxWidth,
              height: widget.constraints!.maxHeight,
              child: Opacity(
                opacity: _batteryStatusAnimation.value,
                child: BatteryStatus(
                  constraints: widget.constraints,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
