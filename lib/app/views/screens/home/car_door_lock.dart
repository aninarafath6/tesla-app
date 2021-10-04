import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tesla/app/constants/app_images.dart';
import 'package:tesla/app/constants/app_sizes.dart';
import 'package:tesla/app/provider/home_provider.dart';
import 'package:tesla/app/utils/custom_animation_controller.dart';
import 'package:tesla/app/utils/enums.dart';
import 'package:tesla/app/views/screens/battery/battery_section.dart';
import 'package:tesla/app/views/screens/home/lock_alignment.dart';
import 'package:tesla/app/views/screens/temp/temperature_section.dart';

class CarDoorLock extends StatefulWidget {
  const CarDoorLock({
    Key? key,
  }) : super(key: key);

  @override
  State<CarDoorLock> createState() => _CarDoorLockState();
}

class _CarDoorLockState extends State<CarDoorLock>
    with SingleTickerProviderStateMixin {
  late Animation<double> _posAnimation;

  @override
  void initState() {
    CustomAnimationController.setTempAnimation(
      tickerProvider: this,
      duration: const Duration(milliseconds: 600),
    );
    _posAnimation = CurvedAnimation(
        parent: CustomAnimationController.tempAnimationController,
        curve: const Interval(0, .4));

    super.initState();
  }

  @override
  void dispose() {
    CustomAnimationController.disposeTempAnimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return LayoutBuilder(builder: (context, constrains) {
      context.read<HomeProvider>().constraints = constrains;
      return Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
              animation: CustomAnimationController.tempAnimationController,
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(_posAnimation.value * 180, 0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: constrains.maxHeight * .1,
                    ),
                    child: SvgPicture.asset(
                      AppImages.teslaCar,
                      width: double.infinity,
                    ),
                  ),
                );
              }),
          LockAlignment(
            door: Lock.rightDoorLock,
            isLocked: provider.rightLock,
            align: Alignment.centerRight,
          ),
          LockAlignment(
            door: Lock.leftDoorLock,
            isLocked: provider.leftLock,
            align: Alignment.centerLeft,
          ),
          LockAlignment(
            door: Lock.bonnetLock,
            isLocked: provider.bonnetLock,
            align: Alignment.topCenter,
          ),
          LockAlignment(
            door: Lock.trunkLook,
            isLocked: provider.trunkLock,
            align: Alignment.bottomCenter,
          ),
          BatterySection(
            constraints: constrains,
          ),
         const TemperatureSection(),
        ],
      );
    });
  }
}
