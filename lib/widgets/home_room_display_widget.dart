import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:real_est_app/utils/size_config.dart';
import 'package:real_est_app/widgets/swipper.dart';

class HomeRoomDisplayWidget extends StatelessWidget {
  final String text;
  final String image;
  final double? height;
  final double? top;
  final double? sliderWidth;

  const HomeRoomDisplayWidget({
    super.key,
    required this.text,
    required this.image,
    this.height,
    this.top,
    this.sliderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? SizeConfig.height(context, h: 400),
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width(context, w: 20),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: top ?? SizeConfig.height(context, h: 260)),
          Stack(
            children: <Widget>[
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 5.0,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: SizeConfig.height(context, h: 100),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: SwipperWidget(
                        onConfirmation: () {},
                        text: text,
                        leftIcon: Icons.arrow_forward_ios,
                        rightIcon: Icons.arrow_forward_ios,
                        backgroundColor: Colors.white60,
                        foregroundColor: Colors.white,
                        replaceBackgroundColor: Colors.transparent,
                        iconColor: Colors.black87,
                        width: sliderWidth ?? double.maxFinite,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
