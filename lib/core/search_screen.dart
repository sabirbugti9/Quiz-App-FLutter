import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:real_est_app/constants/app_colors.dart';

import 'package:real_est_app/constants/app_images.dart';
import 'package:real_est_app/constants/app_svgs.dart';
import 'package:real_est_app/utils/size_config.dart';
import 'package:real_est_app/widgets/location_card.dart';
import 'package:real_est_app/widgets/pop_up_menu.dart';
import 'package:real_est_app/widgets/search_screen_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  int selectedMenuVal = 2;
  bool isWithoutLayer = false;

  late AnimationController _controller;
  late Animation<double> scaleTextFieldAndFilterAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    scaleTextFieldAndFilterAnimation =
        Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImages.map,
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              AppColors.secondaryBackground,
              BlendMode.softLight,
            ),
          ),
        ),
        child: Stack(
          children: [
            // Main
            ListView(
              children: [
                Column(
                  children: [
                    SizedBox(height: SizeConfig.height(context, h: 40)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width(context, w: 20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: ScaleTransition(
                              scale: scaleTextFieldAndFilterAnimation,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Saint Petersburg",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  prefixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Iconsax.search_normal_1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: SizeConfig.width(context, w: 12)),
                          ScaleTransition(
                            scale: scaleTextFieldAndFilterAnimation,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: SizeConfig.height(context, h: 90),
                              width: SizeConfig.height(context, h: 90),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(width: 0),
                              ),
                              child: Icon(
                                Iconsax.setting_4,
                                size: SizeConfig.width(context, w: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: SizeConfig.height(context, h: 60)),
                    LocationCard(
                      text: "10,3 mn P",
                      isIcon: isWithoutLayer,
                      left: SizeConfig.width(context, w: 70),
                    ),
                    SizedBox(height: SizeConfig.height(context, h: 10)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LocationCard(
                          text: "11 mn P",
                          isIcon: isWithoutLayer,
                          left: SizeConfig.width(context, w: 90),
                        ),
                        Column(
                          children: [
                            SizedBox(height: SizeConfig.height(context, h: 60)),
                            LocationCard(
                              text: "7,8 mn P",
                              isIcon: isWithoutLayer,
                              left: SizeConfig.width(context, w: 90),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.height(context, h: 160)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: SizeConfig.height(context, h: 60)),
                            LocationCard(
                              text: "13,3 mn P",
                              isIcon: isWithoutLayer,
                              left: SizeConfig.width(context, w: 90),
                            ),
                          ],
                        ),
                        LocationCard(
                          text: "8,5 mn P",
                          isIcon: isWithoutLayer,
                          left: SizeConfig.width(context, w: 90),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.height(context, h: 80)),
                    LocationCard(
                      text: "6,95 mn P",
                      isIcon: isWithoutLayer,
                      left: SizeConfig.width(context, w: 50),
                    ),
                  ],
                ),
              ],
            ),
            // Buttons
            Positioned(
              bottom: SizeConfig.height(context, h: 200),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.width(context, w: 20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: SizeConfig.height(context, h: 20),
                          children: [
                            // stack
                            ScaleTransition(
                              scale: scaleTextFieldAndFilterAnimation,
                              child: SearchScreenCard(
                                isOnlyIcon: true,
                                icon: SvgPicture.asset(
                                  AppSvgs.stacks,
                                  height: SizeConfig.height(context, h: 60),
                                  width: SizeConfig.height(context, h: 60),
                                  colorFilter: ColorFilter.mode(
                                      Colors.white, BlendMode.srcIn),
                                ),
                              ),
                            ),
                            // send
                            GestureDetector(
                              onTapDown: (TapDownDetails details) {
                                showCustomPopupMenu(
                                  context,
                                  offset: details.globalPosition,
                                  selectedVal: selectedMenuVal,
                                  onTapped: (value) {
                                    selectedMenuVal = value;

                                    if (value == 2) {
                                      setState(() {
                                        isWithoutLayer = false;
                                      });
                                    } else if (value == 4) {
                                      setState(() {
                                        isWithoutLayer = true;
                                      });
                                    }
                                  },
                                );
                              },
                              child: ScaleTransition(
                                scale: scaleTextFieldAndFilterAnimation,
                                child: SearchScreenCard(
                                  isOnlyIcon: true,
                                  icon: Icon(
                                    Iconsax.send_2,
                                    color: Colors.white,
                                    size: SizeConfig.height(context, h: 60),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: SizeConfig.width(context, w: 120)),
                        // List of variants
                        ScaleTransition(
                          scale: scaleTextFieldAndFilterAnimation,
                          child: SearchScreenCard(isOnlyIcon: false),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
