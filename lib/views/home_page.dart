import 'package:flutter/material.dart';
import 'package:old_trustworthy/widgets/drawer_end_bar.dart';
import 'package:old_trustworthy/widgets/drawer_left_bar.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

initState(){
  
}

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(flex: 1, child: hijo1()),
            Flexible(flex: 1, child: hijo2()),
            Flexible(flex: 3, child: hijo3()),
            Flexible(flex: 2, child: hijo4()),
          ],
        ),
      ),
      drawer: DrawerLeftBar(),
      endDrawer: DrawerEndBar(),
    );
  }
}

Widget hijo1() {
  return Placeholder();
}

Widget hijo2() {
  return Placeholder();
}

Widget hijo3() {
  return Placeholder();
}

Widget hijo4() {
  return Placeholder();
}
