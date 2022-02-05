import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_text_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/scaffold/app_scaffold.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/bold_text.dart';
import 'package:kod_sozluk_mobile/model/topic.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/single_entry_view.dart';

// TODO: Needs translation
class EntryEditorViewArgs {
  final Topic topic;

  EntryEditorViewArgs({required this.topic});
}

class EntryEditorView extends StatefulWidget {
  static const String PATH = "/topic/entry-editor";

  final EntryEditorViewArgs args;

  const EntryEditorView({Key? key, required this.args}) : super(key: key);

  @override
  _EntryEditorViewState createState() => _EntryEditorViewState();
}

class _EntryEditorViewState extends State<EntryEditorView> {
  late final Topic topic;

  final TextEditingController entryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    topic = widget.args.topic;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      leading: const Padding(padding: UIConstants.SMALL_PADDING, child: BoldText(text: "vazgeç")),
      actions: [
        buildSaveAsTemplateButton(context),
        buildSendButton(context),
      ],
      body: buildBody(),
    );
  }

  AppTextButton buildSendButton(BuildContext context) {
    return AppTextButton(
      title: "gönder",
      padding: UIConstants.SMALL_PADDING,
      style: context.theme.textTheme.bodyText1!.copyWith(color: context.theme.primaryColor),
      onPressed: () {},
    );
  }

  AppTextButton buildSaveAsTemplateButton(BuildContext context) {
    return AppTextButton(
      title: "kenarda dursun",
      padding: UIConstants.SMALL_PADDING,
      style: context.theme.textTheme.bodyText2,
      onPressed: () {},
    );
  }

  Widget buildBody() {
    return Padding(
      padding: UIConstants.SMALL_PADDING,
      child: Stack(
        children: [
          SingleEntryTopicTitle(topic: topic),
          buildEntryTextFieldArea(),
          buildEntryEditorButtonArea(),
        ],
      ),
    );
  }

  Align buildEntryEditorButtonArea() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EntryEditorButton(flex: 3, title: "(bkz:hede)", onPressed: () {}),
          EntryEditorButton(flex: 2, title: "hede", onPressed: () {}),
          EntryEditorButton(title: "*", onPressed: () {}),
          EntryEditorButton(flex: 3, title: "-spoiler-", onPressed: () {}),
          EntryEditorButton(flex: 2, title: "http://", onPressed: () {}),
          EntryEditorButton(flex: 2, title: "görsel", onPressed: () {}),
          EntryEditorButton(flex: 3, title: "önizleme", onPressed: () {}),
        ],
      ),
    );
  }

  Padding buildEntryTextFieldArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextFormField(
        controller: entryController,
        maxLines: null,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class EntryEditorButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final int flex;

  const EntryEditorButton({Key? key, required this.title, this.onPressed, this.flex = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(right: 2.0),
        child: SizedBox(
          height: 28,
          child: TextButton(
            child: Text(title, style: const TextStyle(color: AppColors.lightGrey, fontSize: 13)),
            onPressed: onPressed,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              overlayColor: MaterialStateProperty.all(AppColors.transparent),
              side: MaterialStateProperty.all(const BorderSide(color: AppColors.lightGrey, width: 1)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
            ),
          ),
        ),
      ),
    );
  }
}
