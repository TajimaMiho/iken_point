import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycloud/config/styles.dart';
import 'package:mycloud/models/point.dart';
import 'package:mycloud/service/providers_provider.dart';
import 'package:mycloud/service/will_pop_callback.dart';

class TopPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Point point = ref.watch(pointProvider).point;
    final Size size = MediaQuery.of(context).size;
    double shortestSide = size.shortestSide;
    double iconSize = shortestSide / 7.5;

    return WillPopScope(
      //前のページに戻らせたくない時に使う
      onWillPop: willPopCallback,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: ListView(
            children: [
              //buildNewsBand(shortestSide),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildPointBand(shortestSide, point),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //buildQRAndPointIcons(iconSize, context),
                      Align(
                        alignment: Alignment.topRight,
                        child: buildNameBand(shortestSide, point),
                      ),
                    ],
                  ),
                  /*Row(
                    children: [
                      ThumbnailImage(
                        shortestSide * 0.5,
                        shortestSide * 0.5,
                        Assets.images.common.dish.path,
                      ),
                      Column(
                        children: [
                          ThumbnailImage(
                            shortestSide * 0.5,
                            shortestSide * 0.5 / 3,
                            Assets.images.common.orihimeBus.path,
                          ),
                          ThumbnailImage(
                            shortestSide * 0.5,
                            shortestSide / 3,
                            Assets.images.common.roadsideStation.path,
                          )
                        ],
                      )
                    ],
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*Widget buildQRAndPointIcons(double iconSize, BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, right: 13),
            child: Column(
              children: [
                GestureDetector(
                  child: SvgPicture.asset(
                    Assets.images.common.icon.qrIc,
                    width: iconSize,
                    height: iconSize,
                    color: Styles.secondaryColor,
                  ),
                  onTap: () async {
                    await Navigator.of(context).pushNamed('/qr');
                  },
                ),
                const Text(
                  '二次元コード\nスキャン',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 25, left: 13),
          //   child:
          //   Column(
          //     children: [
          //       SvgPicture.asset(
          //         Assets.images.common.icon.pointSend,
          //         width: iconSize,
          //         height: iconSize,
          //         color: Styles.secondaryColor,
          //       ),
          //       const Text(
          //         'ポイント\n送受信',
          //         style: TextStyle(fontWeight: FontWeight.bold),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }*/

  /*Widget buildNewsBand(double shortestSide) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        width: shortestSide,
        height: 70,
        color: Styles.primaryColor700,
        child: Center(
          child: Text('【中能登町】実証実験は8/2〜8/19です。',
              style: TextStyle(
                  fontSize: shortestSide / 25,
                  color: Styles.commonTextColor,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }*/

  Widget buildNameBand(double shortestSide, Point point) {
    return Container(
      decoration: const BoxDecoration(
        color: Styles.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
        ),
      ),
      width: shortestSide / 1.9,
      height: 50,
      child: Text(
        point.name,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: shortestSide / 19,
            color: Styles.commonTextColor,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildPointBand(double shortestSide, Point point) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 6,
          color: Styles.primaryColor,
        ),
      ),
      height: shortestSide / 3.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '　ポイント\n　残高',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: shortestSide / 20,
                    color: Styles.commonTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: VerticalDivider(
                thickness: 1,
                width: 3,
                color: Styles.commonTextColor,
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    point.point.toString(),
                    style: TextStyle(
                        fontSize: shortestSide / 12,
                        fontWeight: FontWeight.bold,
                        color: Styles.commonTextColor),
                  ),
                  Text(
                    'pt',
                    style: TextStyle(
                        fontSize: shortestSide / 18,
                        fontWeight: FontWeight.bold,
                        color: Styles.commonTextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
