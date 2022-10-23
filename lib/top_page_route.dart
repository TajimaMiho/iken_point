import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycloud/config/styles.dart';
import 'package:mycloud/gen/assets.gen.dart';
import 'package:mycloud/view/top/my_page.dart';
import 'package:mycloud/view/top/top_page.dart';

class TopPageRoute extends ConsumerWidget {
  final _pageWidgets = [TopPage(), ConfigPage()];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int _currentIndex = ref.watch(currentIndexProvider); //下のバーの番号取得
    final Size size =
        MediaQuery.of(context).size; //様々なデバイス、設定（文字の大きさ、スマホの向きなど）のサイズを取得
    final double iconSize = size.shortestSide / 10; //上のやつに合わせた大きさにする
    return Scaffold(
      body: _pageWidgets.elementAt(_currentIndex), //下のバーの何番（どのページ）をbodyにする
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 3, //太さ
              color: Styles.primaryColor, //色
            ),
          ),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                //違う画面にいる時
                icon: _buildNavigationIconWithName(
                  Icon(Icons.home,
                      size: iconSize, color: Styles.secondaryColor),
                  'ホーム',
                ),
                //ホーム画面にいるとき
                activeIcon: _buildNavigationIconWithName(
                    Icon(Icons.home,
                        size: iconSize, color: Styles.primaryColor),
                    'ホーム',
                    isFocus: true),
                label: 'ホーム'),
            BottomNavigationBarItem(
                icon: _buildNavigationIconWithName(
                    Icon(Icons.list,
                        size: iconSize, color: Styles.secondaryColor),
                    '設定'),
                activeIcon: _buildNavigationIconWithName(
                    Icon(Icons.list,
                        size: iconSize, color: Styles.primaryColor),
                    '設定',
                    isFocus: true),
                label: '設定'),
          ],
          currentIndex: _currentIndex,
          fixedColor: Styles.accentColor,
          onTap: (int index) {
            ref.read(currentIndexProvider.state).state = index;
          },
          type: BottomNavigationBarType.shifting,
        ),
      ),
    );
  }

  Widget _buildNavigationIconWithName(Widget icon, String label,
      {bool isFocus = false}) {
    return Column(
      children: [
        icon,
        Text(label,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: isFocus ? Styles.secondaryColor : Styles.primaryColor)),
      ],
    );
  }
}

final currentIndexProvider = StateProvider((ref) {
  return 0;
});
