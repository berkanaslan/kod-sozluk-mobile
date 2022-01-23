// ignore_for_file: must_call_super
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/util/string_util.dart';
import 'package:kod_sozluk_mobile/core/shared_preferences/shared_preferences.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_icon_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/slidable_buttons.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/social_media_buttons.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/sized_box/app_sized_box.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/bold_text.dart';
import 'package:kod_sozluk_mobile/model/base/page.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';
import 'package:kod_sozluk_mobile/model/user.dart';
import 'package:kod_sozluk_mobile/repository/entry_repository.dart';
import 'package:kod_sozluk_mobile/repository/user_repository.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/login_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/not_logged_profile_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/profile_view_header.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/register_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/profile_settings_view.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/about_entry.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/single_entry_view.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProfileViewArgs {
  final String username;

  ProfileViewArgs({required this.username});
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

  User? user;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);

    Future.microtask(() async {
      _key.currentState?.outerController.addListener(listenScrollPosition);

      if (SharedPrefs.getUser() != null || StringUtil.isNotEmptyString(widget.args.username)) {
        user = await context.read<UserRepository>().getUserByUsername(widget.args.username);
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void listenScrollPosition() {
    bool isScrolled = _displayAppBar;
    if (_key.currentState!.outerController.offset <= 10.0) {
      isScrolled = false;
    } else if (_key.currentState!.outerController.offset >= 144.0) {
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
      buildProfileHeader(),
      const SliverToBoxAdapter(child: SocialMediaButtons()),
    ];
  }

  SliverAppBar buildAppBar(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      pinned: true,
      titleSpacing: 4.0,
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
      onPressed: () => context.navigator.pushNamed(ProfileSettingsView.PATH),
    );
  }

  SliverToBoxAdapter buildProfileHeader() {
    return SliverToBoxAdapter(
      child: ProfileHeader(
        username: user?.username ?? "",
        entryCount: "12",
        followings: "13",
        followers: "14",
      ),
    );
  }

  Widget buildBody() => Column(children: [buildTabBarButtons(), buildTabBarViews()]);

  Expanded buildTabBarViews() {
    return Expanded(
      child: Builder(
        builder: (context) {
          return TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const <Widget>[
              ProfileTabBarView(),
              ProfileTabBarView(),
              ProfileTabBarView(),
            ],
          );
        },
      ),
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

class ProfileTabBarView extends StatefulWidget {
  final void Function(VisibilityInfo info)? onEndOfDrag;

  const ProfileTabBarView({Key? key, this.onEndOfDrag}) : super(key: key);

  @override
  State<ProfileTabBarView> createState() => _ProfileTabBarViewState();
}

class _ProfileTabBarViewState extends State<ProfileTabBarView> {
  late final EntryRepository entryRepository;
  int pageNumber = 0;
  int? totalPages;
  List<Entry> entries = [];

  @override
  void initState() {
    super.initState();
    entryRepository = context.read<EntryRepository>();
    Future.microtask(getEntriesByTopicId);
  }

  Future<void> getEntriesByTopicId() async {
    // TODO: Change function
    Page<Entry>? response =
        await entryRepository.getEntriesByTopicId(topicId: 1, pageNumber: pageNumber, totalPages: totalPages);

    if (response != null) {
      pageNumber++;
      totalPages = response.totalPages;
      entries.addAll(response.content!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      ...entries.map((e) => SingleEntryView(entry: e)).toList(),
      if (widget.onEndOfDrag != null) buildVisibilityDetector(),
    ]);
  }

  Widget buildVisibilityDetector() {
    return VisibilityDetector(
      key: Key("UK_$hashCode"),
      onVisibilityChanged: widget.onEndOfDrag!,
      child: const AppSizedBox(),
    );
  }
}

class UserEntriesView extends StatefulWidget {
  final bool wantKeepAlive;

  const UserEntriesView({
    Key? key,
    this.wantKeepAlive = true,
  }) : super(key: key);

  @override
  _UserEntriesViewState createState() => _UserEntriesViewState();
}

class _UserEntriesViewState extends State<UserEntriesView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.wantKeepAlive;

  @override
  Widget build(BuildContext context) {
    return ProfileTabBarView(
      onEndOfDrag: (info) {
        if (info.visibleFraction == 1.0) {
          // TODO: Pagination
        }
      },
    );
  }
}
