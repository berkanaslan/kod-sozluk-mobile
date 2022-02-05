import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/model/head.dart';
import 'package:kod_sozluk_mobile/view/topic_view/latest_topic_view.dart';

class HomeView extends StatefulWidget {
  static const String PATH = "/home";

  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  final List<Head> heads = [
    Head(name: "bugün", body: const LatestTopicView()),
    Head(name: "gündem"),
    Head(name: "debe"),
    Head(name: "sorunsallar"),
    Head(name: "takip"),
    Head(name: "tarihte bugün"),
    Head(name: "son"),
    Head(name: "kenar"),
    Head(name: "çaylaklar"),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: heads.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
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

  Widget get tabBar {
    return TabBar(
      physics: const BouncingScrollPhysics(),
      labelPadding: const EdgeInsets.only(left: 20, right: 20),
      controller: _tabController,
      isScrollable: true,
      indicatorWeight: 3,
      indicatorSize: TabBarIndicatorSize.label,
      tabs: heads.map((head) => Tab(text: head.name)).toList(),
    );
  }

  Widget get body {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: heads.map((head) => head.body ?? nothingFoundWidget).toList(),
      ),
    );
  }

  Center get nothingFoundWidget => Center(child: Text(LocaleKeys.nothing_found.locale));
}
