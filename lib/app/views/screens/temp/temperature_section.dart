import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';
import 'package:tesla/app/constants/app_colors.dart';
import 'package:tesla/app/constants/app_images.dart';
import 'package:tesla/app/constants/app_sizes.dart';
import 'package:tesla/app/provider/home_provider.dart';
import 'package:tesla/app/utils/custom_animation_controller.dart';
import 'package:tesla/app/utils/enums.dart';
import 'package:tesla/app/views/screens/temp/temp_status.dart';

class TemperatureSection extends StatefulWidget {
  const TemperatureSection({
    Key? key,
  }) : super(key: key);

  @override
  State<TemperatureSection> createState() => _TemperatureSectionState();
}

class _TemperatureSectionState extends State<TemperatureSection>
    with SingleTickerProviderStateMixin {
  late AnimationController heatAnimationController;
  late Animation _opacityAnimation;
  late Animation heatAnimation;
  late AnimationController coolAnimationController;
  late Animation coolAnimation;
  late Animation opacityAnimation;
  late Animation<double> posAnimation;

  @override
  void initState() {
    _opacityAnimation = CurvedAnimation(
      parent: CustomAnimationController.tempAnimationController,
      curve: const Interval(.6, 1),
    );

    posAnimation = CurvedAnimation(
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
    var _provider = context.read<HomeProvider>();
    return Align(
      alignment: Alignment.centerRight,
      child: AnimatedBuilder(
        animation: Listenable.merge(
          [CustomAnimationController.tempAnimationController, _provider],
        ),
        builder: (context, _) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: _provider.isCool
                      ? Image.asset(
                          AppImages.cool,
                          key: const ValueKey('cool'),
                        )
                      : Image.asset(
                          AppImages.heat,
                          key: const ValueKey('hot'),
                        ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top:(1-posAnimation.value)*50),
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: TempStatus(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
