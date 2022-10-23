import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycloud/models/point.dart';
import 'package:mycloud/models/point_state.dart';
import 'package:mycloud/provider/login_provider.dart';

final pointProvider = StateNotifierProvider<PointStateProvider, PointState>(
  (ref) => PointStateProvider(
    ref,
  ),
);

class PointStateProvider extends StateNotifier<PointState> {
  PointStateProvider(this._reader) : super(const PointState()) {
    init();
  }

  final firePointService = FirePointService();

  Future<void> init() async {
    String email = _reader.watch(loginProvider).user.email;
    final fetchedPoint = await firePointService.fetchPoint(email);
    state = state.copyWith(point: fetchedPoint);
  }

  void updatePoint(Point point) {
    state = state.copyWith(point: point);
  }

  final StateNotifierProviderRef _reader;
}

// StreamProviderを使うことでStreamも扱うことができる
// ※ autoDisposeを付けることで自動的に値をリセットできます
final postsQueryProvider = StreamProvider.autoDispose((ref) {
  return FirebaseFirestore.instance
      .collection('posts')
      .orderBy('date')
      .snapshots();
});

class FirePointService {
  final _fireStore = FirebaseFirestore.instance;

  Future<Point> fetchPoint(String email) async {
    final document =
        await FirebaseFirestore.instance.collection('users').doc(email).get();

    return const Point().copyWith(
        usedPoint: document['used_point'] as int,
        point: document['point'] as int,
        name: document['name']);
  }
}
