import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';
import 'package:tesla/app/constants/app_colors.dart';
import 'package:tesla/app/constants/app_images.dart';
import 'package:tesla/app/constants/app_sizes.dart';
import 'package:tesla/app/provider/home_provider.dart';
import 'package:tesla/app/utils/custom_animation_controller.dart';
import 'package:tesla/app/utils/enums.dart';

class TempStatus extends StatefulWidget {
  const TempStatus({Key? key}) : super(key: key);

  @override
  State<TempStatus> createState() => _TempStatusState();
}

class _TempStatusState extends State<TempStatus> with TickerProviderStateMixin {
  late AnimationController heatAnimationController;
  late Animation heatAnimation;
  late AnimationController coolAnimationController;

  late Animation coolAnimation;

  @override
  void initState() {
    heatAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    coolAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    heatAnimation =
        Tween<double>(begin: 0, end: 1).animate(heatAnimationController);
    coolAnimation =
        Tween<double>(begin: 0, end: 1).animate(heatAnimationController);

    super.initState();
  }

  @override
  void dispose() {
    heatAnimationController.dispose();
    coolAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _provider = context.read<HomeProvider>();

    return Padding(
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
                  offset: Offset(0, -coolAnimation.value * 70),
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
                            width: 55,
                            color: _provider.isCool
                                ? AppColors.primaryColor
                                : Colors.grey,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Cool'.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
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
                const SizedBox(width: 15),
                Transform.translate(
                  offset: Offset(0, (-1 + heatAnimation.value) * 70),
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
                            width: 55,
                            color: !_provider.isCool
                                ? AppColors.redColor
                                : Colors.grey,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'heat'.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
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
    );
  }
}
