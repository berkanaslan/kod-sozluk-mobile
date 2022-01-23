import 'package:flutter/cupertino.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';

class SlidableButtons extends StatelessWidget {
  final String firstButton;
  final String secondButton;
  final String? thirdButton;
  final int index;
  final void Function(int? index) onChanged;
  final double? width;

  const SlidableButtons({
    Key? key,
    required this.firstButton,
    required this.secondButton,
    this.thirdButton,
    required this.index,
    required this.onChanged,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildButtons(context);
  }

  Widget buildButtons(BuildContext context) {
    return Container(
      padding: UIConstants.SMALL_PADDING,
      width: width ?? context.width,
      color: context.theme.scaffoldBackgroundColor,
      child: CupertinoSegmentedControl<int>(
        unselectedColor: context.theme.cardColor,
        selectedColor: context.theme.primaryColor,
        padding: EdgeInsets.zero,
        children: getChildren(context),
        groupValue: index,
        onValueChanged: onChanged,
      ),
    );
  }

  Map<int, Widget> getChildren(BuildContext context) {
    return <int, Widget>{
      0: Text(
        firstButton,
        style: context.theme.textTheme.bodyText2!.copyWith(
          color: 0 == index ? AppColors.white : null,
        ),
      ),
      1: Text(
        secondButton,
        style: context.theme.textTheme.bodyText2!.copyWith(
          color: 1 == index ? AppColors.white : null,
        ),
      ),
      if (thirdButton != null)
        2: Text(
          thirdButton!,
          style: context.theme.textTheme.bodyText2!.copyWith(
            color: 2 == index ? AppColors.white : null,
          ),
        ),
    };
  }
}
