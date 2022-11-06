import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mycloud/models/user/user.dart';
import 'package:mycloud/provider/login_provider.dart';
import 'package:mycloud/service/providers_provider.dart';

const firstTableRow = TableRow(children: [
  TableCell(child: Text('日付', textAlign: TextAlign.center)),
  TableCell(child: Text('詳細', textAlign: TextAlign.center)),

  TableCell(child: Text('収入', textAlign: TextAlign.center)),
  TableCell(child: Text('支出', textAlign: TextAlign.center)),
  // TableCell(child: Text('メアド', textAlign: TextAlign.center)),
  TableCell(child: Text('所持', textAlign: TextAlign.center)),
]);

class HistoryPoint extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User user = ref.watch(loginProvider).user;
    final AsyncValue<QuerySnapshot> asyncPostsQuery =
        ref.watch(postsQueryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ポイント履歴'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Text('ログイン情報：${user.email}'),
            ),
            asyncPostsQuery.when(
              data: (QuerySnapshot query) {
                final List<QueryDocumentSnapshot<Object?>> queryList = query
                    .docs
                    .toList()
                    .where((document) => document['email'] == user.email)
                    .toList();

                final List<TableRow> historyPointTileList = [firstTableRow];
                for (QueryDocumentSnapshot<Object?> document in queryList) {
                  historyPointTileList.add(historyPointTile(document));
                }
                return Table(
                    border: TableBorder.all(), children: historyPointTileList);
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
    );
  }
}

TableRow historyPointTile(QueryDocumentSnapshot<Object?> document) {
  bool isPay = document['transaction'].toString() == 'pay';
  // DateTime time = document['date'].toDate();
  final time = DateTime.parse(document['date'].toString());

  DateFormat outputFormat = DateFormat('yyyy-MM-dd HH:mm');

  return TableRow(children: [
    TableCell(
        child: Text(outputFormat.format(time), textAlign: TextAlign.center)),
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
