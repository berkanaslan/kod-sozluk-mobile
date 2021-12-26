import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/constant/logger.dart';
import 'package:kod_sozluk_mobile/view/topic_view/topic_view.dart';
import 'package:kod_sozluk_mobile/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  static const String PATH = "/home";

  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late final HomeViewModel viewModel;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<HomeViewModel>();
    _tabController = TabController(length: 0, vsync: this);
    Future.microtask(() => viewModel.getAllHeads());
  }

  @override
  void didChangeDependencies() {
    _tabController = TabController(length: viewModel.heads.length, vsync: this);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Logger.buildLogger("HomeView");
    return safeArea;
  }

  Widget get safeArea => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              tabBar,
              body,
            ],
          ),
        ),
      );

  TabBar get tabBar {
    return TabBar(
      physics: const BouncingScrollPhysics(),
      labelPadding: const EdgeInsets.only(left: 20, right: 20),
      controller: _tabController,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      isScrollable: true,
      indicatorWeight: 3,
      indicatorSize: TabBarIndicatorSize.label,
      tabs: context.watch<HomeViewModel>().heads.map((head) => Tab(text: head.name)).toList(),
    );
  }

  Widget get body {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: List.generate(context.watch<HomeViewModel>().heads.length, (index) {
          if (index == 0) return const TopicView();
          return Center(child: Text(LocaleKeys.nothing_found.locale));
        }),
      ),
    );
  }
}
