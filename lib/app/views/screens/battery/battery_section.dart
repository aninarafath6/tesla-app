import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:tesla/app/constants/app_images.dart';
import 'package:tesla/app/provider/home_provider.dart';

class BatterySection extends StatefulWidget {
  const BatterySection({Key? key, this.constraints}) : super(key: key);
  final BoxConstraints? constraints;

  @override
  State<BatterySection> createState() => _BatterySectionState();
}

class _BatterySectionState extends State<BatterySection>
    with SingleTickerProviderStateMixin {
  late Animation _batteryAnimation;

  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 600,
      ),
    );
    _batteryAnimation = CurvedAnimation(
        parent: context.read<HomeProvider>().animationController,
        curve: Interval(0, 0.5));
  }

  @override
  void dispose() {
    context.read<HomeProvider>().animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: context.read<HomeProvider>().animationController,
      builder: (context, _) {
        return Opacity(
          opacity: _batteryAnimation.value,
          child: SvgPicture.asset(
            AppImages.battery,
            width: widget.constraints!.maxWidth * .45,
          ),
        );
      },
    );
  }
}