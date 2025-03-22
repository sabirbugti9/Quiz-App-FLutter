import 'package:flutter/material.dart';
import 'package:real_est_app/constants/app_colors.dart';
import 'package:real_est_app/utils/size_config.dart';

class LocationTextContainerWidget extends StatefulWidget {
  const LocationTextContainerWidget({super.key});

  @override
  State<LocationTextContainerWidget> createState() =>
      _LocationTextContainerWidgetState();
}

class _LocationTextContainerWidgetState
    extends State<LocationTextContainerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> locationFadeAnimation;

  // location container controller
  bool isStarted = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // fade
    locationFadeAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0.6, 1)));

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isStarted = true;
      });

      _controller.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isStarted
          ? SizeConfig.width(context, w: 170)
          : SizeConfig.width(context, w: 10),
      duration: const Duration(milliseconds: 1500),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: FadeTransition(
        opacity: locationFadeAnimation,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: AppColors.gold,
            ),
            Text(
              "Saint Petersburg",
              style: TextStyle(
                color: AppColors.gold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
