import 'package:ebooksreader/app/view/tabs_views/estante_tab_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  String title = "Estante";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: const Color.fromARGB(255, 255, 253, 133),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.book)),
              Tab(icon: Icon(Icons.directions_transit)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            EstanteTabView(),
            EstanteTabView(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
