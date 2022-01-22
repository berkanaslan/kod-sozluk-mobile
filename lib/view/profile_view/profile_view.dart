import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';
import 'package:kod_sozluk_mobile/core/shared_preferences/shared_preferences.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_icon_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/slidable_buttons.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/social_media_buttons.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/sized_box/app_sized_box.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/bold_text.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/login_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/not_logged_profile_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/profile_view_header.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/register_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/profile_settings_view.dart';
import 'package:kod_sozluk_mobile/view/topic_view/topic_detail_view/components/about_entry.dart';
import 'package:kod_sozluk_mobile/viewmodel/login_viewmodel.dart';

class ProfileView extends StatefulWidget {
  static const String PATH = "/profile_view";

  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with TickerProviderStateMixin {
  final GlobalKey<ExtendedNestedScrollViewState> _key = GlobalKey<ExtendedNestedScrollViewState>();
  late final TabController primaryTC;

  // Current Index of tab
  int _currentIndex = 0;

  final list = List.generate(100, (index) => Text("First $index")).toList();
  final list2 = List.generate(100, (index) => Text("Second $index")).toList();
  final list3 = List.generate(100, (index) => Text("Third $index")).toList();

  @override
  void initState() {
    super.initState();
    primaryTC = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    primaryTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginViewModel, AuthState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {},
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return buildProfileView(context);
        }

        return NotLoggedProfileView(
          onLoginButtonPressed: () => context.navigator.pushNamed(LoginView.PATH),
          onRegisterButtonPressed: () => context.navigator.pushNamed(RegisterView.PATH),
        );
      },
    );
  }

  Widget buildProfileView(BuildContext context) {
    return ExtendedNestedScrollView(
      key: _key,
      onlyOneScrollInBody: true,
      pinnedHeaderSliverHeightBuilder: () => context.mediaQuery.padding.top + kToolbarHeight,
      headerSliverBuilder: buildSliverHeader,
      body: buildBody(),
    );
  }

  List<Widget> buildSliverHeader(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      buildAppBar(context, innerBoxIsScrolled),
      buildProfileHeader(),
      const SliverToBoxAdapter(child: SocialMediaButtons()),
    ];
  }

  SliverAppBar buildAppBar(BuildContext context, bool innerBoxIsScrolled) {
    return SliverAppBar(
      elevation: 0,
      pinned: true,
      titleSpacing: 8.0,
      // centerTitle: false,
      title: const Text("profil"),
      actions: [buildProfileSettingsViewIconButton(context)],
    );
  }

  Row buildAppBarTitle() {
    return Row(children: [
      UserAvatar(onAvatarPressed: () {}),
      const AppSizedBox(style: AppBoxStyle.HORIZONTAL),
      BoldText(text: SharedPrefs.getUser()!.username!),
    ]);
  }

  AppIconButton buildProfileSettingsViewIconButton(BuildContext context) {
    return AppIconButton(
      icon: AppIcons.settings,
      color: context.theme.primaryColor,
      onPressed: () => context.navigator.pushNamed(ProfileSettingsView.PATH),
    );
  }

  SliverToBoxAdapter buildProfileHeader() {
    return SliverToBoxAdapter(
      child: ProfileHeader(
        username: SharedPrefs.getUser()?.username ?? "",
        entryCount: "12",
        followings: "13",
        followers: "14",
      ),
    );
  }

  Padding buildBody() {
    return Padding(
      padding: UIConstants.SMALL_PADDING,
      child: Column(
        children: [
          buildButtons(),
          Expanded(
            child: Builder(
              builder: (context) {
                return TabBarView(
                  controller: primaryTC,
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    ProfileListView(children: list),
                    ProfileListView(children: list2),
                    ProfileListView(children: list3),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void animateToTop() {
    _key.currentState?.innerController.animateTo(
      context.mediaQuery.padding.top,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }

  // TODO: Translation - move to constants file in assets:
  Widget buildButtons() {
    return SlidableButtons(
      index: _currentIndex,
      firstButton: "entry'ler",
      secondButton: "favoriler",
      thirdButton: "istatistikler",
      onChanged: (int? index) {
        _currentIndex = index!;
        primaryTC.animateTo(_currentIndex);
        setState(() {});
      },
    );
  }
}

class ProfileListView extends StatefulWidget {
  final List<Widget> children;

  const ProfileListView({Key? key, required this.children}) : super(key: key);

  @override
  State<ProfileListView> createState() => _ProfileListViewState();
}

class _ProfileListViewState extends State<ProfileListView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return ListView(children: widget.children);
  }
}
