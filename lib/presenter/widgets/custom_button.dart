import 'package:ecommerce/app_colors.dart';
import 'package:flutter/material.dart';

enum CustomButtonSize { sm, md, lg, xl, xl2 }

enum CustomButtonHierarchy { primary, secondary, gray }

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.size = CustomButtonSize.sm,
    this.hierarchy = CustomButtonHierarchy.primary,
    this.onPressed,
    this.leading,
    this.trailing,
  });

  final String title;
  final CustomButtonSize size;
  final CustomButtonHierarchy hierarchy;
  final Widget? leading;
  final Widget? trailing;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height[size],
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: backgroundColor[hierarchy],
            border: hierarchy == CustomButtonHierarchy.gray
                ? Border.all(
                    width: 1,
                    color: borderColor[hierarchy]!,
                  )
                : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leading != null)
              Row(
                children: [
                  leading!,
                  const SizedBox(width: 8),
                ],
              ),
            Text(
              title,
              style: TextStyle(
                color: fontColor[hierarchy],
                fontWeight: FontWeight.w600,
                fontSize: fontSize[size],
              ),
            ),
            if (trailing != null)
              Row(
                children: [
                  const SizedBox(width: 8),
                  trailing!,
                ],
              ),
          ],
        ),
      ),
    );
  }

  static Map<CustomButtonSize, double> height = {
    CustomButtonSize.sm: 36,
    CustomButtonSize.md: 40,
    CustomButtonSize.lg: 44,
    CustomButtonSize.xl: 48,
    CustomButtonSize.xl2: 60,
  };

  static Map<CustomButtonSize, double> fontSize = {
    CustomButtonSize.sm: 14,
    CustomButtonSize.md: 14,
    CustomButtonSize.lg: 16,
    CustomButtonSize.xl: 16,
    CustomButtonSize.xl2: 18,
  };

  static Map<CustomButtonHierarchy, Color> backgroundColor = {
    CustomButtonHierarchy.primary: AppColors.primaryColor,
    CustomButtonHierarchy.secondary: AppColors.primaryColor50,
    CustomButtonHierarchy.gray: AppColors.white
  };

  static Map<CustomButtonHierarchy, Color> fontColor = {
    CustomButtonHierarchy.primary: AppColors.white,
    CustomButtonHierarchy.secondary: AppColors.primaryColor,
    CustomButtonHierarchy.gray: AppColors.gray700,
  };

  static Map<CustomButtonHierarchy, Color> borderColor = {
    CustomButtonHierarchy.gray: AppColors.gray300,
  };
}
