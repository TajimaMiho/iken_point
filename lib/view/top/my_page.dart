import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mycloud/config/styles.dart';
import 'package:mycloud/models/user/user.dart';
import 'package:mycloud/provider/login_provider.dart';
import 'package:mycloud/service/providers_provider.dart';

const firstTableRow = TableRow(children: [
  TableCell(
      child: Text(
    '日付',
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.white),
  )),
  TableCell(
      child: Text(
    '詳細',
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.white),
  )),

  TableCell(
      child: Text(
    '収入',
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.white),
  )),
  TableCell(
      child: Text(
    '支出',
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.white),
  )),
  // TableCell(child: Text('メアド', textAlign: TextAlign.center)),
  TableCell(
      child: Text(
    '所持',
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.white),
  )),
]);

class HistoryPoint extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User user = ref.watch(loginProvider).user;
    final AsyncValue<QuerySnapshot> asyncPostsQuery =
        ref.watch(postsQueryProvider);
    final List<TableRow> historyPointTitleTileList = [firstTableRow];
    return Scaffold(
      appBar: AppBar(
          shape:
              Border(bottom: BorderSide(color: Styles.primaryColor, width: 3)),
          title: Container(
            width: 150,
            height: 30,
            child: Image.asset(
              'images/Icon.png',
              fit: BoxFit.contain,
            ),
          ),
          backgroundColor: Colors.white),
      body: SingleChildScrollView(
        //はみ出ないようにしている
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Text('ログイン情報：${user.email}'),
              ),
              Container(
                  decoration: const BoxDecoration(
                    color: Styles.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Table(
                      //border: TableBorder.all(),
                      children: historyPointTitleTileList)),
              asyncPostsQuery.when(
                data: (QuerySnapshot query) {
                  final List<QueryDocumentSnapshot<Object?>> queryList = query
                      .docs
                      .toList()
                      .where((document) => document['email'] == user.email)
                      .toList();
                  //白色のtableの部分
                  final List<TableRow> historyPointTileList = [];
                  for (QueryDocumentSnapshot<Object?> document in queryList) {
                    historyPointTileList.add(historyPointTile(document));
                  }
                  //一行目以降をhistoryPointTile関数から取ってきて追加する
                  return Container(
                      color: Colors.white,
                      child: Table(
                          border: TableBorder.all(),
                          children: historyPointTileList));
                },
                loading: () {
                  return const Center(
                    child: Text('読込中...'),
                  );
                },
                error: (e, stackTrace) {
                  return Center(
                    child: Text(e.toString()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TableRow historyPointTile(QueryDocumentSnapshot<Object?> document) {
  bool isPay = document['transaction'].toString() == 'pay';
  // DateTime time = document['date'].toDate();
  final time = DateTime.parse(document['date'].toString());
  //'date'→string→DateTime

  DateFormat outputFormat = DateFormat('yyyy-MM-dd HH:mm');

  return TableRow(children: [
    TableCell(
        child: Text(outputFormat.format(time), textAlign: TextAlign.center)),
    //outputFormatの表示方法（'yyyy-MM-dd HH:mm')にした time
    TableCell(child: Text(document['way'], textAlign: TextAlign.center)),
    TableCell(
        child: isPay
            ? const Text('', textAlign: TextAlign.center)
            : Text(document['point_of_change'].toString(),
                textAlign: TextAlign.center)),
    isPay
        ? Text(document['point_of_change'].toString(),
            textAlign: TextAlign.center)
        : const Text('', textAlign: TextAlign.center),

    // TableCell(child: Text(document['email'], textAlign: TextAlign.center)),
    TableCell(
        child: Text(document['current_point'].toString(),
            textAlign: TextAlign.center)),
  ]);
}
