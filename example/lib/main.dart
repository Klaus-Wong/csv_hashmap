
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:csv_hashmap/csv_hashmap.dart';

HashMap refHashMap;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  refHashMap = await CSV_HashMap().hashMapConvertor(refList: ["data","open", "high", "low", "close", "adjClose", "vol"],
      csvPath: "assets/chartData/TSLA/TSLA_Daily.csv");
  print(refHashMap["data"]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CSV_HashMap Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'CSV_HashMap Demo - TSLA'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final ScrollController _scrollController = ScrollController(initialScrollOffset: 0);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.greenAccent.withOpacity(.5),
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  keyColWidget(colName: "Data"),
                  keyColWidget(colName: "Open"),
                  keyColWidget(colName: "High"),
                  keyColWidget(colName: "Low"),
                  keyColWidget(colName: "Close"),
                  keyColWidget(colName: "Vol"),
                ],
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  color: Colors.white38,
                  child: Scrollbar(
                    isAlwaysShown: true,
                    controller: _scrollController,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      controller: _scrollController,
                      padding: const EdgeInsets.all(8),
                      itemCount: refHashMap["data"].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            keyColWidget(colName: refHashMap["data"][index].toString() ),
                            keyColWidget(colName: double.tryParse(refHashMap["open"][index]).toStringAsFixed(3)),
                            keyColWidget(colName: double.tryParse(refHashMap["high"][index]).toStringAsFixed(3)),
                            keyColWidget(colName: double.tryParse(refHashMap["low"][index]).toStringAsFixed(3)),
                            keyColWidget(colName: double.tryParse(refHashMap["close"][index]).toStringAsFixed(3)),
                            keyColWidget(colName: refHashMap["vol"][index].toString()),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 2.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget keyColWidget({@required String colName}){
  return Expanded(
    flex: 1,
    child: Text(colName, textAlign: TextAlign.center),
  );
}
