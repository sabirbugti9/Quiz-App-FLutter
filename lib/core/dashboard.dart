import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:real_est_app/constants/app_colors.dart';
import 'package:real_est_app/core/home_screen.dart';
import 'package:real_est_app/core/search_screen.dart';
import 'package:real_est_app/utils/size_config.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  int navIndex = 2;

  late AnimationController _controller;

  late Animation<Offset> slideNavBarAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    slideNavBarAnimation = Tween<Offset>(begin: Offset(0, 30), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

    Future.delayed(const Duration(seconds: 6), () {
      _controller.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dashboardScreens[navIndex],
      floatingActionButton: SlideTransition(
        position: slideNavBarAnimation,
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.darkBg,
          onPressed: () {},
          label: SizedBox(
            width: SizeConfig.width(context, w: 280),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(navbarItems.length, (index) {
                var item = navbarItems[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      navIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    padding: EdgeInsets.all(navIndex == index ? 12 : 10),
                    decoration: BoxDecoration(
                      color: navIndex == index
                          ? AppColors.primary
                          : Colors.black.withValues(alpha: 0.7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item["icon"],
                      size: 22.0,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          extendedPadding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth(context) * 0.02, vertical: 10),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  List<Widget> dashboardScreens = [
    // search
    const SearchScreen(),
    // messaging
    const Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: Center(
        child: Text(
          "Messaging",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
    // home
    const HomeScreen(),
    // favorites
    const Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: Center(
        child: Text(
          "Favorites",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
    // profile
    const Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: Center(
        child: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  ];

  List<Map<String, dynamic>> navbarItems = [
    {"icon": Iconsax.search_normal_1},
    {"icon": Iconsax.message_text_15},
    {"icon": Iconsax.home_14},
    {"icon": Icons.favorite},
    {"icon": Icons.person_2_rounded},
  ];
}
