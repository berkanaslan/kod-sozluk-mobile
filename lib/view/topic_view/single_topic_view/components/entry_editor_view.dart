import 'package:flutter/material.dart';
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
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/entry_editor_view/components/new_entry_preview_mode_view.dart';
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
  EntryEditorType? selectedEditorType;
  bool showEntryEditorTextField = false;
  final FocusNode entryEditorFocusNode = FocusNode(debugLabel: "entry-editor");

  void setShowEntryEditorTextField(bool value) {
    showEntryEditorTextField = value;
    setState(() {});

    if (value) {
      entryEditorFocusNode.requestFocus();
      return;
    }

    FocusScope.of(context).nextFocus();
  }

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
      leading: const Padding(padding: UIConstants.SMALL_PADDING, child: BoldText(text: "vazge??")),
      actions: [
        buildSaveAsTemplateButton(context),
        buildSendButton(context),
      ],
      body: buildBody(),
    );
  }

  AppTextButton buildSendButton(BuildContext context) {
    return AppTextButton(
      title: "g??nder",
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
      onPressed: () {
        AppSnackBar.showSnackBar(message: "yak??nda bu buton da ??al????acak.");
      },
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
          const Divider(),
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
        children: showEntryEditorTextField ? builEntryEditorTextField() : entryEditorButtons,
      ),
    );
  }

  List<Widget> builEntryEditorTextField() => [
        EntryEditorTextField(
          focusNode: entryEditorFocusNode,
          type: selectedEditorType!,
          onCompleted: (value, type) {
            entryController.text += value ?? "";
            setShowEntryEditorTextField(false);
          },
        )
      ];

  List<Widget> get entryEditorButtons {
    return [
      EntryEditorButton(flex: 3, title: "(bkz: hede)", onTapped: () => onEditorSelected(EntryEditorType.REFERENCE)),
      EntryEditorButton(flex: 2, title: "hede", onTapped: () => onEditorSelected(EntryEditorType.TITLE)),
      EntryEditorButton(title: "*", onTapped: () {}),
      EntryEditorButton(flex: 3, title: "-spoiler-", onTapped: () {}),
      EntryEditorButton(flex: 2, title: "http://", onTapped: () {}),
      EntryEditorButton(flex: 2, title: "g??rsel", onTapped: () {}),
      EntryEditorButton(flex: 3, title: "??nizleme", onTapped: () => setState(() => previewMode = !previewMode)),
    ];
  }

  void onEditorSelected(EntryEditorType type) {
    previewMode = false;
    selectedEditorType = type;
    setShowEntryEditorTextField(true);
  }

  Widget buildEntryTextFieldArea() {
    if (previewMode) {
      return NewEntryPreviewMode(
        message: generateEntryMessage(),
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
      message: generateEntryMessage(),
    );

    final Entry? savedEntry = await entryRepository.save(entryDTO);

    if (savedEntry != null) {
      context.rootNavigator.pop(true);
      AppSnackBar.showSnackBar(
        message: "entry ba??ar??yla kaydedildi efendimiz!",
        type: SnackBarType.SUCCESS,
      );
    }
  }

  // TODO: ??ok fazla String atamas?? kullan??l??yor. Bunun yerine StringBuffer kullan??lacak.
  String generateEntryMessage() {
    final newLineRegex = RegExp(AppConstants.NEW_LINE_REGEX);
    final entryReferenceRegex = RegExp(AppConstants.REFERENCE_REGEX);
    final entryTitleRegex = RegExp(AppConstants.TITLE_REGEX);

    String entry = entryController.text.trim().toLowerCase();

    entry = entry.replaceAll(newLineRegex, "<br>");

    entryReferenceRegex.allMatches(entry).forEach((match) {
      entry = entry.replaceAll("${match.group(0)}", "(bkz: <a>${match.group(1)?.trim()}</a>)");
    });

    entryTitleRegex.allMatches(entry).forEach((match) {
      entry = entry.replaceAll("${match.group(0)}", "<a>${match.group(1)?.trim()}</a>");
    });

    return entry;
  }
}
