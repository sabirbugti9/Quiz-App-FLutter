import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:real_est_app/constants/app_colors.dart';
import 'package:real_est_app/constants/app_svgs.dart';
import 'package:real_est_app/utils/size_config.dart';

void showCustomPopupMenu(
  BuildContext context, {
  required Offset offset,
  required Function(int value) onTapped,
  required int selectedVal,
}) async {
  double left = offset.dx;
  double top = offset.dy;

  await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(0, top - 260, left, 0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    color: Theme.of(context).scaffoldBackgroundColor,
    menuPadding: EdgeInsets.only(
      left: SizeConfig.width(context, w: 7),
      right: SizeConfig.width(context, w: 10),
    ),
    popUpAnimationStyle: AnimationStyle(
      curve: Curves.ease,
      duration: Duration(milliseconds: 2500),
    ),
    items: [
      popupMenuItem(
        context,
        value: 1,
        text: "Cosy areas",
        isSelected: selectedVal == 1,
      ),
      popupMenuItem(
        context,
        value: 2,
        text: "Price",
        icon: Iconsax.building,
        isSelected: selectedVal == 2,
      ),
      popupMenuItem(
        context,
        value: 3,
        text: "Infrastructure",
        icon: Iconsax.cake,
        isSelected: selectedVal == 3,
      ),
      popupMenuItem(
        context,
        value: 4,
        text: "Without any layer",
        isIconSvg: true,
        svgAssetName: AppSvgs.stacks,
        isSelected: selectedVal == 4,
      ),
    ],
    elevation: 8.0,
  ).then(
    (value) {
      if (value != null) {
        if (kDebugMode) print(value);
        onTapped(value);
      }
    },
  );
}

PopupMenuItem<int> popupMenuItem(
  BuildContext context, {
  required int value,
  required bool isSelected,
  required String text,
  bool isIconSvg = false,
  IconData icon = Iconsax.shield_tick,
  String svgAssetName = "",
}) {
  return PopupMenuItem(
    value: value,
    child: Container(
      padding: EdgeInsets.only(),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
            color: isSelected ? AppColors.primary : Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: SizeConfig.height(context, h: 35),
          ),
        ),
        leading: isIconSvg
            ? SizedBox(
                height: SizeConfig.height(context, h: 45),
                width: SizeConfig.height(context, h: 45),
                child: SvgPicture.asset(
                  svgAssetName,
                  height: SizeConfig.height(context, h: 45),
                  width: SizeConfig.height(context, h: 45),
                  colorFilter: ColorFilter.mode(
                      isSelected ? AppColors.primary : Colors.grey,
                      BlendMode.srcIn),
                ),
              )
            : Icon(
                icon,
                color: isSelected ? AppColors.primary : Colors.grey,
              ),
      ),
    ),
  );
}
