library csv_hashmap;

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CSV_HashMap {
  List<String> splitLines(String str) {
    return str.split(RegExp(r'\r?\n'));
  }

  Future<HashMap> hashMapConvertor(
      {@required List<String> refList,
      @required String csvPath,
      String delimiter}) async {
    String refDelimiter = ",";
    HashMap tempHashMap = new HashMap();

    if (delimiter != null) {
      refDelimiter = delimiter;
    }
    refList.forEach((element) {
      tempHashMap.putIfAbsent(element, () => new List<dynamic>());
    });

    final sData = await rootBundle.loadString(csvPath);
    List lineList = splitLines(sData);
    List dataList = lineList.toString().split(refDelimiter);
    for (int i = refList.length; i < dataList.length; i++) {
      int modValue = i % (refList.length);
      List<dynamic> tempList = tempHashMap[refList[modValue]];
      tempList.add(dataList[i]);
      tempHashMap.update(refList[modValue], (value) => tempList);
    }
    return tempHashMap;
  }
}
