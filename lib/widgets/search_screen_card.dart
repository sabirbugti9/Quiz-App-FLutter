import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:real_est_app/utils/size_config.dart';

class SearchScreenCard extends StatelessWidget {
  final bool isOnlyIcon;
  final Widget? icon;

  const SearchScreenCard({super.key, required this.isOnlyIcon, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.height(context, h: 20)),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: isOnlyIcon
          ? icon
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: SizeConfig.width(context, w: 12)),
                Icon(Iconsax.textalign_left, color: Colors.white),
                SizedBox(width: SizeConfig.width(context, w: 12)),
                Text(
                  "List of variants",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.height(context, h: 30),
                  ),
                ),
              ],
            ),
    );
  }
}
