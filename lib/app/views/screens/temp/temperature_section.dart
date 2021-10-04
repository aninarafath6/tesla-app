import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';
import 'package:tesla/app/constants/app_colors.dart';
import 'package:tesla/app/constants/app_images.dart';
import 'package:tesla/app/constants/app_sizes.dart';
import 'package:tesla/app/provider/home_provider.dart';
import 'package:tesla/app/utils/custom_animation_controller.dart';
import 'package:tesla/app/utils/enums.dart';

class TemperatureSection extends StatefulWidget {
  const TemperatureSection({
    Key? key,
  }) : super(key: key);

  @override
  State<TemperatureSection> createState() => _TemperatureSectionState();
}

class _TemperatureSectionState extends State<TemperatureSection>
    with TickerProviderStateMixin {
  late AnimationController heatAnimationController;
  late Animation _opacityAnimation;
  late Animation heatAnimation;
  late AnimationController coolAnimationController;
  late Animation coolAnimation;

  @override
  void initState() {
    heatAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    coolAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _opacityAnimation = CurvedAnimation(
      parent: CustomAnimationController.tempAnimationController,
      curve: const Interval(.6, 1),
    );
    heatAnimation =
        Tween<double>(begin: 0, end: 1).animate(heatAnimationController);
    coolAnimation =
        Tween<double>(begin: 0, end: 1).animate(heatAnimationController);
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
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: AnimatedBuilder(
            animation: Listenable.merge(
              [CustomAnimationController.tempAnimationController, _provider],
            ),
            builder: (context, _) {
              return Opacity(
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
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: _provider.constraints.maxHeight * .1,
            horizontal: _provider.constraints.maxWidth * .05,
          ),
          child: AnimatedBuilder(
              animation: heatAnimationController,
              builder: (context, _) {
                return Row(
                  children: [
                    Transform.translate(
                      offset: Offset(0, -coolAnimation.value * 80),
                      child: GestureDetector(
                        onTap: () {
                          heatAnimationController.reverse();
                          coolAnimationController.forward();
                          _provider.updateTempStatus(Temp.cool);
                        },
                        child: AnimatedScale(
                          duration: AppSizes.defaultDuration,
                          scale: !_provider.isCool ? 0.8 : 1,
                          child: Column(
                            children: <Widget>[
                              SvgPicture.asset(
                                AppImages.coolButton,
                                width: 50,
                                color: _provider.isCool
                                    ? AppColors.primaryColor
                                    : Colors.grey,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Cool'.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                      color: _provider.isCool
                                          ? AppColors.primaryColor
                                          : Colors.grey,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                    Transform.translate(
                      offset: Offset(0, (-1 + heatAnimation.value) * 80),
                      child: GestureDetector(
                        onTap: () {
                          heatAnimationController.forward();
                          coolAnimationController.reverse();
                          _provider.updateTempStatus(Temp.heat);
                        },
                        child: AnimatedScale(
                          duration: AppSizes.defaultDuration,
                          scale: _provider.isCool ? 0.8 : 1,
                          child: Column(
                            children: <Widget>[
                              SvgPicture.asset(
                                AppImages.heatButton,
                                width: 50,
                                color: !_provider.isCool
                                    ? AppColors.redColor
                                    : Colors.grey,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'heat'.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                      color: !_provider.isCool
                                          ? AppColors.redColor
                                          : Colors.grey,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }
}
