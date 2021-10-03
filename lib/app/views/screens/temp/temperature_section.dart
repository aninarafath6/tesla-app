import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:tesla/app/constants/app_images.dart';
import 'package:tesla/app/provider/home_provider.dart';

class TemperatureSection extends StatefulWidget {
  const TemperatureSection({
    Key? key,
  }) : super(key: key);

  @override
  State<TemperatureSection> createState() => _TemperatureSectionState();
}

class _TemperatureSectionState extends State<TemperatureSection>
    with SingleTickerProviderStateMixin {
  late Animation _opacityAnimation;

  @override
  void initState() {
    // context.read<HomeProvider>().tempAnimationController = AnimationController(
    //   vsync: this, duration: const Duration(milliseconds: 300));
    _opacityAnimation = CurvedAnimation(
      parent: context.read<HomeProvider>().tempAnimationController,
      curve: const Interval(.06, 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    context.read<HomeProvider>().tempAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: AnimatedBuilder(
          animation: context.read<HomeProvider>().tempAnimationController,
          builder: (context, _) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Image.asset(
                AppImages.cool,
              ),
            );
          }),
    );
  }
}
