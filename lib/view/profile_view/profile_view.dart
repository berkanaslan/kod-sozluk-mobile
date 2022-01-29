// ignore_for_file: must_call_super

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/shared_preferences/shared_preferences.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/appbar/appbar.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_icon_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/slidable_buttons.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/sized_box/app_sized_box.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/bold_text.dart';
import 'package:kod_sozluk_mobile/model/user.dart';
import 'package:kod_sozluk_mobile/repository/user_repository.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/login_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/not_logged_profile_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/profile_view_header.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/register_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/user_entries_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/user_favorites_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/user_statistic_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/profile_settings_view.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/about_entry.dart';

class ProfileViewArgs {
  final int userId;

  ProfileViewArgs({required this.userId});
}

class ProfileView extends StatefulWidget {
  static const String PATH = "/profile_view";

  final ProfileViewArgs args;

  const ProfileView({Key? key, required this.args}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with TickerProviderStateMixin {
  final GlobalKey<ExtendedNestedScrollViewState> _key = GlobalKey<ExtendedNestedScrollViewState>();

  late final TabController tabController;
  bool _displayAppBar = false;

  // Active index of tabs
  int _currentIndex = 0;

  late final int userId;
  User? user;

  @override
  void initState() {
    super.initState();
    userId = widget.args.userId;
    tabController = TabController(length: 3, vsync: this);

    initialTasks();
  }

  Future<void> initialTasks() async {
    Future.microtask(() async {
      _key.currentState?.outerController.addListener(listenScrollPosition);
      getUser();
    });
  }

  Future<void> getUser() async {
    if (SharedPrefs.getUser() != null) {
      user = await context.read<UserRepository>().getUserById(userId);
      setState(() {});
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    _key.currentState?.outerController.dispose();
    super.dispose();
  }

  void listenScrollPosition() {
    bool isScrolled = _displayAppBar;
    if (_key.currentState!.outerController.offset <= 10.0) {
      isScrolled = false;
    } else if (_key.currentState!.outerController.offset >= context.height * 0.15) {
      isScrolled = true;
    }

    if (_displayAppBar == isScrolled) return;

    _displayAppBar = isScrolled;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserRepository, AuthState>(
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
      buildAppBar(context),
      SliverToBoxAdapter(child: ProfileHeader(user: user)),
    ];
  }

  CustomSliverAppBar buildAppBar(BuildContext context) {
    return CustomSliverAppBar(
      title: buildAppBarTitle(),
      actions: [buildProfileSettingsViewIconButton(context)],
    );
  }

  Widget? buildAppBarTitle() {
    if (!_displayAppBar) return null;

    return Row(children: [
      UserAvatar(onAvatarPressed: () {}),
      const AppSizedBox(style: AppBoxStyle.HORIZONTAL),
      BoldText(text: user?.username ?? ""),
    ]);
  }

  AppIconButton buildProfileSettingsViewIconButton(BuildContext context) {
    return AppIconButton(
      icon: AppIcons.settings,
      color: context.theme.primaryColor,
      onPressed: () async {
        context.navigator.pushNamed(ProfileSettingsView.PATH).then((value) async {
          user = SharedPrefs.getUser();
          setState(() {});
        });
      },
    );
  }

  Widget buildBody() {
    return Column(children: [
      buildTabBarButtons(),
      Expanded(child: buildTabBarViews()),
    ]);
  }

  Widget buildTabBarViews() {
    return TabBarView(
      controller: tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        UserEntriesView(userId: userId, onRefresh: getUser),
        UserFavoritesView(userId: userId, onRefresh: getUser),
        UserStatisticView(userId: userId, onRefresh: getUser),
      ],
    );
  }

  // TODO: Use it via on tapped tab buttons.
  void animateToTop() {
    _key.currentState?.innerController.animateTo(
      context.mediaQuery.padding.top,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }

  // TODO: Translation - move to constants file in assets:
  Widget buildTabBarButtons() {
    return SlidableButtons(
      index: _currentIndex,
      firstButton: "entry'ler",
      secondButton: "favoriler",
      thirdButton: "istatistikler",
      onChanged: (int? index) {
        _currentIndex = index!;
        tabController.animateTo(_currentIndex);
        setState(() {});
      },
    );
  }
}
