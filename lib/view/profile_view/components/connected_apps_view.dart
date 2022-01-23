import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/app_constants.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';
import 'package:kod_sozluk_mobile/core/shared_preferences/shared_preferences.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/snackbar.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/rounded_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/scaffold/app_scaffold.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/app_text_field.dart';
import 'package:kod_sozluk_mobile/model/user.dart';
import 'package:kod_sozluk_mobile/repository/user_repository.dart';
import 'package:provider/provider.dart';

class ConnectedAppsView extends StatefulWidget {
  static const String PATH = "/profile/connected-apps";

  const ConnectedAppsView({Key? key}) : super(key: key);

  @override
  State<ConnectedAppsView> createState() => _ConnectedAppsViewState();
}

class _ConnectedAppsViewState extends State<ConnectedAppsView> {
  final TextEditingController facebookController = TextEditingController(
    text: ConnectedApplications.getJustUsernameOfLink(SharedPrefs.getUser()?.connectedApplications?.facebook),
  );

  final TextEditingController twitterController = TextEditingController(
    text: ConnectedApplications.getJustUsernameOfLink(SharedPrefs.getUser()?.connectedApplications?.twitter),
  );

  final TextEditingController instagramController = TextEditingController(
    text: ConnectedApplications.getJustUsernameOfLink(SharedPrefs.getUser()?.connectedApplications?.instagram),
  );

  final TextEditingController githubController = TextEditingController(
    text: ConnectedApplications.getJustUsernameOfLink(SharedPrefs.getUser()?.connectedApplications?.github),
  );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // TODO: Translation
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "bağlı hesaplar",
      body: Padding(
        padding: UIConstants.MEDIUM_PADDING,
        child: Form(
          key: formKey,
          child: listView,
        ),
      ),
    );
  }

  ListView get listView {
    return ListView(
      children: [
        facebookTextField(),
        TwitterTextField(),
        instagramTextField(),
        githubTextField(),
        saveButton,
      ],
    );
  }

  RoundedButton get saveButton => RoundedButton(title: "kaydet", onPressed: onSaveButtonPressed);

  Future<void> onSaveButtonPressed() async {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();

    final ConnectedApplications connectedApplications = ConnectedApplications(
      facebook: facebookController.text,
      twitter: twitterController.text,
      instagram: instagramController.text,
      github: githubController.text,
    );

    final requestBody = SharedPrefs.getUser()!..connectedApplications = connectedApplications;

    final User? savedUser = await context.read<UserRepository>().saveUser(requestBody);

    if (savedUser != null) {
      SharedPrefs.setUser(savedUser);
      AppSnackBar.showSnackBar(message: LocaleKeys.success.locale, type: SnackBarType.SUCCESS);
    }
  }

  AppTextField facebookTextField() {
    return AppTextField(
      controller: facebookController,
      icon: AppIcons.facebook,
      labelText: "facebook kullanıcı adı",
      validator: validateUsername,
    );
  }

  AppTextField TwitterTextField() {
    return AppTextField(
      controller: twitterController,
      icon: AppIcons.twitter,
      labelText: "twitter kullanıcı adı",
      validator: validateUsername,
    );
  }

  AppTextField instagramTextField() {
    return AppTextField(
      controller: instagramController,
      icon: AppIcons.instagram,
      labelText: "instagram kullanıcı adı",
      validator: validateUsername,
    );
  }

  AppTextField githubTextField() {
    return AppTextField(
      controller: githubController,
      icon: AppIcons.github,
      labelText: "github kullanıcı adı",
      validator: validateUsername,
    );
  }

  String? validateUsername(String? value) {
    if (value == null) return null;
    if (!RegExp(AppConstants.VALID_USERNAME_REGEX).hasMatch(value)) return "doğru kullanıcı adı girin.";
  }
}
