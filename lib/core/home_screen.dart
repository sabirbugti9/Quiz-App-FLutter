import 'dart:async';

import 'package:flutter/material.dart';
import 'package:real_est_app/constants/app_colors.dart';
import 'package:real_est_app/constants/app_images.dart';
import 'package:real_est_app/utils/size_config.dart';
import 'package:real_est_app/widgets/home_room_display_widget.dart';
import 'package:real_est_app/widgets/location_text_container_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // timer
  Timer? _timerBuy;
  Timer? _timerRent;

  // animation controllers
  late AnimationController _startAnimationController;
  late AnimationController _bodyAnimationController;
  late AnimationController _textAnimationController;

  late Animation<double> textFadeAnimation1;
  late Animation<double> textFadeAnimation2;
  late Animation<double> scaleProfilePicAnimation;
  late Animation<double> scaleStatContainersAnimation;
  late Animation<Offset> slideBodyAnimation;

  // For the stats
  int counterForBuy = 0;
  int counterForRent = 0;

  @override
  void initState() {
    _startAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _bodyAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2700),
    );

    // scale
    scaleProfilePicAnimation =
        Tween<double>(begin: 0, end: 1).animate(_startAnimationController);

    _startAnimationController.forward();

    // Start text animation after scaling picture
    _startAnimationController.addListener(() {
      if (_startAnimationController.isCompleted) {
        _textAnimationController.forward();
      }
    });

    textFadeAnimation1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: Interval(0, 0.5),
      ),
    );

    textFadeAnimation2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: Interval(0.5, 1),
      ),
    );

    // start body animation when text is done
    _textAnimationController.addListener(() {
      if (_textAnimationController.isCompleted) {
        _bodyAnimationController.forward();
      }
    });

    //slide
    slideBodyAnimation = Tween<Offset>(begin: Offset(0, 20), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _bodyAnimationController, curve: Curves.ease));
    // scale
    scaleStatContainersAnimation =
        Tween<double>(begin: 0, end: 1).animate(_bodyAnimationController);

    // Start counter
    startBuyCounter();
    startRentCounter();

    super.initState();
  }

  void startBuyCounter() {
    _timerBuy = Timer.periodic(const Duration(milliseconds: 10), (t) {
      if (counterForBuy == 1034) {
        setState(() {
          t.cancel();
        });
      } else {
        setState(() {
          counterForBuy++;
        });
      }
    });
  }

  void startRentCounter() {
    _timerBuy = Timer.periodic(const Duration(milliseconds: 10), (t) {
      if (counterForRent == 2212) {
        setState(() {
          t.cancel();
        });
      } else {
        setState(() {
          counterForRent++;
        });
      }
    });
  }

  @override
  void dispose() {
    _timerBuy?.cancel();
    _timerRent?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _topBoxDeco(context),
        child: SafeArea(child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: SizeConfig.width(context, w: 10),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.height(context, h: 7),),
                  ProfilePart(scaleProfilePicAnimation: scaleProfilePicAnimation),
                    SizedBox(height: SizeConfig.height(context, h: 40),),
                    NamePart(textFadeAnimation1: textFadeAnimation1, textFadeAnimation2: textFadeAnimation2),
                    SizedBox(height: SizeConfig.height(context, h: 50),),
                    BuyPart(scaleStatContainersAnimation: scaleStatContainersAnimation, counterForBuy: counterForBuy, counterForRent: counterForRent),


                ],
              ),
              ),
                SizedBox(height: SizeConfig.height(context, h: 100),),
                ProductSide(slideBodyAnimation: slideBodyAnimation),
            ],
          ),
        )),
      ),

     
    );
  }


























  BoxDecoration _topBoxDeco(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
        colors: [
          Theme.of(context).scaffoldBackgroundColor,
          Theme.of(context).scaffoldBackgroundColor,
          Theme.of(context).scaffoldBackgroundColor,
          Theme.of(context).scaffoldBackgroundColor,
          AppColors.primary.withValues(alpha: 0.3),
          AppColors.primary.withValues(alpha: 0.3),
          AppColors.primary.withValues(alpha: 0.3),
        ],
      ),
    );
  }
}

class ProductSide extends StatelessWidget {
  const ProductSide({
    super.key,
    required this.slideBodyAnimation,
  });

  final Animation<Offset> slideBodyAnimation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideBodyAnimation,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.height(context, h: 20),
          horizontal: SizeConfig.width(context, w: 10),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            HomeRoomDisplayWidget(
              text: 'Gladkova St., 25',
              image: AppImages.room1,
              sliderWidth: SizeConfig.width(context, w: 320),
            ),
            SizedBox(height: SizeConfig.height(context, h: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: SizeConfig.width(context, w: 170),
                  child: HomeRoomDisplayWidget(
                    text: 'Gubina St., 11',
                    image: AppImages.staircase,
                    height: SizeConfig.height(context, h: 700),
                    top: SizeConfig.height(context, h: 560),
                    sliderWidth: SizeConfig.width(context, w: 140),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: SizeConfig.width(context, w: 170),
                      child: HomeRoomDisplayWidget(
                        text: 'Trefoleva St., 43',
                        image: AppImages.room2,
                        height: SizeConfig.height(context, h: 340),
                        top: SizeConfig.height(context, h: 200),
                        sliderWidth:
                            SizeConfig.width(context, w: 140),
                      ),
                    ),
                    SizedBox(
                        height: SizeConfig.height(context, h: 20)),
                    SizedBox(
                      width: SizeConfig.width(context, w: 170),
                      child: HomeRoomDisplayWidget(
                        text: 'Sedova St., 22',
                        image: AppImages.room3,
                        height: SizeConfig.height(context, h: 340),
                        top: SizeConfig.height(context, h: 200),
                        sliderWidth:
                            SizeConfig.width(context, w: 140),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: SizeConfig.height(context, h: 180)),
          ],
        ),
      ),
    );
  }
}

class BuyPart extends StatelessWidget {
  const BuyPart({
    super.key,
    required this.scaleStatContainersAnimation,
    required this.counterForBuy,
    required this.counterForRent,
  });

  final Animation<double> scaleStatContainersAnimation;
  final int counterForBuy;
  final int counterForRent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScaleTransition(
          scale: scaleStatContainersAnimation,
          child: Container(
            height: SizeConfig.height(context, h: 380),
            width: SizeConfig.height(context, h: 380),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Column(
              children: [
                SizedBox(
                    height:
                        SizeConfig.height(context, h: 20)),
                Text(
                  "BUY",
                  style: TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    height:
                        SizeConfig.height(context, h: 50)),
                Text(
                  "${counterForBuy.toString().substring(0, 1)} ${counterForBuy.toString().substring(1)}", // "1034",
                  style: TextStyle(
                    fontSize:
                        SizeConfig.height(context, h: 100),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "offers",
                  style: TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: SizeConfig.width(context, w: 10)),
        ScaleTransition(
          scale: scaleStatContainersAnimation,
          child: Container(
            height: SizeConfig.height(context, h: 380),
            width: SizeConfig.width(context, w: 150),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                SizedBox(
                    height:
                        SizeConfig.height(context, h: 20)),
                Text(
                  "RENT",
                  style: TextStyle(
                    color: AppColors.gold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    height:
                        SizeConfig.height(context, h: 50)),
                Text(
                  "${counterForRent.toString().substring(0, 1)} ${counterForRent.toString().substring(1)}", // "2 212",
                  style: TextStyle(
                    fontSize:
                        SizeConfig.height(context, h: 90),
                    fontWeight: FontWeight.bold,
                    color: AppColors.gold,
                  ),
                ),
                Text(
                  "offers",
                  style: TextStyle(
                    color: AppColors.gold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NamePart extends StatelessWidget {
  const NamePart({
    super.key,
    required this.textFadeAnimation1,
    required this.textFadeAnimation2,
  });

  final Animation<double> textFadeAnimation1;
  final Animation<double> textFadeAnimation2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: textFadeAnimation1,
          child: Text(
            "Hi Sabir Bugti",
            style: TextStyle(
              fontSize: SizeConfig.height(context, h: 50),
              color: AppColors.gold,
            ),
          ),
        ),
        FadeTransition(
          opacity: textFadeAnimation2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "let's select your",
                style: TextStyle(
                  fontSize: SizeConfig.height(context, h: 70),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "perfect place",
                style: TextStyle(
                  height: 0,
                  fontSize: SizeConfig.height(context, h: 70),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfilePart extends StatelessWidget {
  const ProfilePart({
    super.key,
    required this.scaleProfilePicAnimation,
  });

  final Animation<double> scaleProfilePicAnimation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LocationTextContainerWidget(),
        ScaleTransition(
          scale: scaleProfilePicAnimation,
          child: CircleAvatar(
            foregroundImage: AssetImage(AppImages.profile),
            radius: SizeConfig.screenHeight(context) * 0.03,
          ),
        )
      ],
    );
  }
}
