import 'package:flutter/material.dart';
import 'package:clicker/logic/constants.dart';

class InfoTab extends StatefulWidget {
  @override
  State<InfoTab> createState() => _InfoTabState();
}

class _InfoTabState extends State<InfoTab> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;

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

class GameMechanics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('Here I\'ll write the game mechanics')],
    );
  }
}

class AboutTheApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Hello and welcome to $kAppName! \n\nThis is my first app, a simple incremental clicker I\'ve developed on my free time. \n\nThere are no ads and no purchases. \n\nI hope you have fun with the game! \n\nBest wishes, \nStanislav',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}
