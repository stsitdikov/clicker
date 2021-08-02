import 'package:flutter/material.dart';
import 'package:clicker/components/about_the_app.dart';
import 'package:clicker/components/game_mechanics.dart';

class InfoTab extends StatefulWidget {
  @override
  State<InfoTab> createState() => _InfoTabState();
}

class _InfoTabState extends State<InfoTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                text: 'About the App',
              ),
              Tab(
                text: 'Game Mechanics',
              ),
            ],
          ),
          Expanded(child: TabBarView(children: panels)),
        ],
      ),
    );
  }
}

List<Widget> panels = <Widget>[
  AboutTheApp(),
  GameMechanics(),
];
