import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';

class IconChipButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  final bool filled;

  const IconChipButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.filled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(height: 24, width: 24, decoration: boxDecoration, child: sizedIcon),
      ),
    );
  }

  BoxDecoration get boxDecoration {
    return BoxDecoration(
      color: filled ? AppColors.primary : AppColors.white,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: filled ? AppColors.primary : AppColors.grey3, width: 1),
    );
  }

  Icon get sizedIcon => Icon(icon, size: 12, color: filled ? AppColors.white : AppColors.grey3);
}
