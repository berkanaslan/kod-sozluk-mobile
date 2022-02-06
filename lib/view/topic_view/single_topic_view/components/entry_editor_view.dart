
import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:html/dom.dart' as dom;
import 'package:kod_sozluk_mobile/core/constant/app_constants.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';
import 'package:kod_sozluk_mobile/core/shared_preferences/shared_preferences.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/snackbar.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_text_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/entry_editor_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/scaffold/app_scaffold.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/bold_text.dart';
import 'package:kod_sozluk_mobile/model/dto/entry_dto.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';
import 'package:kod_sozluk_mobile/model/topic.dart';
import 'package:kod_sozluk_mobile/repository/entry_repository.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/entry_editor_view/components/entry_message_from_html.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/entry_editor_view/components/new_entry_reference_dialog.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/single_entry_view.dart';
import 'package:provider/provider.dart';

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
  late final EntryRepository entryRepository;
  bool previewMode = false;

  final TextEditingController entryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    entryRepository = context.read<EntryRepository>();
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
      onPressed: saveEntry,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleEntryTopicTitle(topic: topic),
          Expanded(child: buildEntryTextFieldArea()),
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
          EntryEditorButton(flex: 3, title: "(bkz: hede)", onPressed: onNewReferenceButtonPressed),
          EntryEditorButton(flex: 2, title: "hede", onPressed: () {}),
          EntryEditorButton(title: "*", onPressed: () {}),
          EntryEditorButton(flex: 3, title: "-spoiler-", onPressed: () {}),
          EntryEditorButton(flex: 2, title: "http://", onPressed: () {}),
          EntryEditorButton(flex: 2, title: "görsel", onPressed: () {}),
          EntryEditorButton(flex: 3, title: "önizleme", onPressed: () => setState(() => previewMode = !previewMode)),
        ],
      ),
    );
  }

  void onNewReferenceButtonPressed() {
    setState(() => previewMode = false);
    NewEntryReferenceDialog(context: context, onCompleted: (value) => entryController.text += value ?? "").show();
  }

  Widget buildEntryTextFieldArea() {
    if (previewMode) {
      return NewEntryPreviewMode(
        message: entryController.text,
        onTap: () => setState(() => previewMode = !previewMode),
      );
    }

    return TextFormField(
      controller: entryController,
      maxLines: null,
      decoration: const InputDecoration(border: InputBorder.none, hintText: "entry'niz"),
    );
  }

  Future<void> saveEntry() async {
    if (entryController.text.isEmpty) return;

    final EntryDTO entryDTO = EntryDTO(
      topic: Topic(id: topic.id),
      author: SharedPrefs.getUser()!,
      message: entryController.text.trim().toLowerCase(),
    );

    final Entry? savedEntry = await entryRepository.save(entryDTO);

    if (savedEntry != null) {
      context.rootNavigator.pop(true);
      AppSnackBar.showSnackBar(
        message: "entry başarıyla kaydedildi efendimiz!",
        type: SnackBarType.SUCCESS,
      );
    }
  }
}

class NewEntryPreviewMode extends StatelessWidget {
  final void Function()? onTap;
  final String message;
  final void Function(String? url, RenderContext context, Map<String, String> attributes, dom.Element? element)?
      onLinkTapped;

  const NewEntryPreviewMode({Key? key, this.onTap, required this.message, this.onLinkTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: onTap,
        child: EntryMessageFromHTML(message: generateEntryMessage()),
      ),
    );
  }

  String generateEntryMessage() {
    final newLineRegex = RegExp(AppConstants.NEW_LINE_REGEX);
    final entryReferenceRegex = RegExp(AppConstants.REFERENCE_REGEX);

    String editedMessage = message.trim().toLowerCase();

    editedMessage = editedMessage.replaceAll(newLineRegex, "<br>");

    while (entryReferenceRegex.hasMatch(editedMessage)) {
      final firstMatch = entryReferenceRegex.firstMatch(editedMessage);
      // TODO: Remove (!)
      editedMessage = editedMessage.replaceFirst(entryReferenceRegex, "(!bkz: <a>${firstMatch?.group(1)?.trim()}</a>)");
    }

    return editedMessage;
  }
}
