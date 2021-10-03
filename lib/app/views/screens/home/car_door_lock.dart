import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tesla/app/constants/app_images.dart';
import 'package:tesla/app/constants/app_sizes.dart';
import 'package:tesla/app/provider/home_provider.dart';
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
    context.read<HomeProvider>().tempAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _posAnimation = CurvedAnimation(
        parent: context.read<HomeProvider>().tempAnimationController,
        curve: const Interval(0.6, 1));

    super.initState();
  }

  @override
  void dispose() {
    context.read<HomeProvider>().tempAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return LayoutBuilder(builder: (context, constrains) {
      return Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
              animation: context.read<HomeProvider>().tempAnimationController,
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
            constraints: constrains,
            door: Lock.rightDoorLock,
            isLocked: provider.rightLock,
            align: Alignment.centerRight,
          ),
          LockAlignment(
            constraints: constrains,
            door: Lock.leftDoorLock,
            isLocked: provider.leftLock,
            align: Alignment.centerLeft,
          ),
          LockAlignment(
            constraints: constrains,
            door: Lock.bonnetLock,
            isLocked: provider.bonnetLock,
            align: Alignment.topCenter,
          ),
          LockAlignment(
            constraints: constrains,
            door: Lock.trunkLook,
            isLocked: provider.trunkLock,
            align: Alignment.bottomCenter,
          ),
          BatterySection(
            constraints: constrains,
          ),
          TemperatureSection(),
        ],
      );
    });
  }
}
