import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/logger.dart';
import 'package:kod_sozluk_mobile/view/topic_view/topic_view.dart';

class HomeView extends StatefulWidget {
  static const String PATH = "/home";

  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 9, vsync: this);
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
      tabs: const [
        // TODO: TO Constants
        Tab(text: "bugün"),
        Tab(text: "gündem"),
        Tab(text: "debe"),
        Tab(text: "sorunsallar"),
        Tab(text: "takip"),
        Tab(text: "tarihte bugün"),
        Tab(text: "son"),
        Tab(text: "kenar"),
        Tab(text: "çaylaklar"),
      ],
    );
  }

  Widget get body {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: List.generate(9, (index) => const TopicView()),
      ),
    );
  }
}
