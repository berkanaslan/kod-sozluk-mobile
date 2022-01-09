import 'package:flutter/cupertino.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/form_field_wrapper.dart';

enum Gender { MALE, FEMALE, OTHER, UNDEFINED }

final Map<Gender, Widget> genderTabs = <Gender, Widget>{
  Gender.FEMALE: Text(LocaleKeys.female_.locale),
  Gender.MALE: Text(LocaleKeys.male_.locale),
  Gender.OTHER: Text(LocaleKeys.other_.locale),
  Gender.UNDEFINED: Text(LocaleKeys.undefined.locale),
};

class GenderSelectionFormField extends StatelessWidget {
  final void Function(Gender? gender) onChanged;
  final Gender value;

  const GenderSelectionFormField({Key? key, required this.onChanged, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormFieldWrapper(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(LocaleKeys.gender_.locale),
          UIConstants.HORIZONTAL_MEDIUM_SIZED_BOX,
          Expanded(
            child: CupertinoSlidingSegmentedControl<Gender>(
              groupValue: value,
              children: genderTabs,
              onValueChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
