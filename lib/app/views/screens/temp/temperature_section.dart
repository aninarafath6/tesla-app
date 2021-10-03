import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';
import 'package:tesla/app/constants/app_images.dart';
import 'package:tesla/app/provider/home_provider.dart';
import 'package:tesla/app/utils/custom_animation_controller.dart';

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
      parent: CustomAnimationController.tempAnimationController,
      curve: const Interval(.6, 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    CustomAnimationController.disposeTempAnimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: AnimatedBuilder(
              animation: CustomAnimationController.tempAnimationController,
              builder: (context, _) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Image.asset(
                    AppImages.cool,
                  ),
                );
              }),
        ),
        Column(
          children: <Widget>[
            SvgPicture.asset(
              AppImages.coolButton,
              width: 50,
            ),
          ],
        ),
      ],
    );
  }
}
