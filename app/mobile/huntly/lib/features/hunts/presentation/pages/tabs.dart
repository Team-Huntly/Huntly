import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return TaskScreen();
  }
}

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tab = [
    Tab(text: 'Sunday'),
    Tab(text: 'Monday'),
  ];
  final List<Widget> _tabMenu = [
    Text('This is Sunday'),
    Text('This is Monday'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tab.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FlatButton(
            onPressed: () {
              setState(() {
                _tab.add(
                  Tab(
                    text: '1',
                  ),
                );
                _tabMenu.add(
                  Text('1'),
                );
                _tabController =
                    TabController(length: _tab.length, vsync: this);
              });
              print('tab ${_tab.length}');
              print('tabMenu ${_tabMenu.length}');
            },
            child: Text('add')),
        Container(
          color: Colors.blue,
          padding: EdgeInsets.only(top: 10),
          child: TabBar(
            // isScrollable: true, 
            tabs: _tab.map((e) => e).toList(),
            controller: _tabController,
          ),
        ),
        Expanded(
          child: TabBarView(
            children: _tabMenu.map((e) => e).toList(),
            controller: _tabController,
          ),
        )
      ],
    );
  }
}