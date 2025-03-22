import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:real_est_app/constants/app_colors.dart';
import 'package:real_est_app/utils/size_config.dart';

class LocationCard extends StatefulWidget {
  final bool isIcon;
  final String? text;
  final double? left;

  const LocationCard({super.key, this.text, required this.isIcon, this.left});

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> scaleCardAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // scale
    scaleCardAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    Future.delayed(const Duration(seconds: 1), () {
      _controller.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleCardAnimation,
      child: AnimatedContainer(
        width: widget.isIcon
            ? SizeConfig.height(context, h: 90)
            : SizeConfig.height(context, h: 190),
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.only(left: widget.left ?? 0.0),
        padding: EdgeInsets.all(SizeConfig.height(context, h: 20)),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(13),
            topLeft: Radius.circular(13),
            bottomRight: Radius.circular(13),
          ),
        ),
        curve: Curves.ease,
        child: widget.isIcon
            ? Icon(Iconsax.grid_1, color: Colors.white)
            : Text(
                widget.text ?? "",
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
