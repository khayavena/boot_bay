import 'package:bootbay/src/helpers/costom_color.dart';
import 'package:flutter/material.dart';

Widget buildCollapsingWidget(
    {@required Widget bodyWidget,
    List<Widget> actions,
    @required String headerIcon,
    @required Widget backButton,
    @required String title}) {
  return NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverAppBar(
          leading: backButton,
          backgroundColor: CustomColor().pureWhite,
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          actions: actions == null ? [] : actions,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                title.toUpperCase(),
                style: TextStyle(
                  color: CustomColor().originalBlack,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: Image.network(
                headerIcon,
                fit: BoxFit.cover,
              )),
        ),
      ];
    },
    body: bodyWidget,
  );
}

Widget buildDefaultCollapsingWidget(
    {@required Widget bodyWidget, List<Widget> actions, @required Widget backButton, @required String title}) {
  return NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverAppBar(
          leading: backButton,
          backgroundColor: CustomColor().pureWhite,
          expandedHeight: 150.0,
          floating: false,
          pinned: true,
          title:Text( title),
          actions: actions == null ? [] : actions,
          flexibleSpace: FlexibleSpaceBar(centerTitle: true, background: getDefaultBackground(title)),
        ),
      ];
    },
    body: bodyWidget,
  );
}

Widget getDefaultBackground(String title) {
  return // Group 2 Copy
// splashc
      Stack(children: [
    // Mask
    PositionedDirectional(
      top: 0,
      start: 0,
      child: Container(width: 375, height: 204, decoration: BoxDecoration(color:  Color(0xffd8d8d8))),
    ),
    // Football3.3
    PositionedDirectional(
      top: 0,
      start: 0,
      child: Container(width: 375, height: 204),
    ),
    // Rectangle
    PositionedDirectional(
      top: 85,
      start: 0,
      child: Opacity(
        opacity: 0.09751998546511628,
        child: Container(
            width: 375,
            height: 119,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment(0.13648371883650204, 0.29639567233383773),
                    end: Alignment(0.05216666666666671, 1.0000000000000002),
                    colors: [Color(0x008f54e7),  Color(0xff54a1f8)]))),
      ),
    ),
    // Rectangle
    PositionedDirectional(
      top: 85,
      start: 0,
      child: Opacity(
        opacity: 0.05975199854651163,
        child: Container(
            width: 375,
            height: 159,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment(0.13648371883650204, 0.29639567233383773),
                    end: Alignment(0.05216666666666671, 1.0000000000000002),
                    colors: [Color(0x008d4ded),  Color(0xff54a1f8)]))),
      ),
    ),
    // RUGBY
    PositionedDirectional(
      top: 97,
      start: 16,
      child: Text(title.toUpperCase(),
          style:  TextStyle(
              color: CustomColor.cta_blue,
              fontWeight: FontWeight.w700,
              fontFamily: "SFCompactDisplay",
              fontStyle: FontStyle.normal,
              fontSize: 24.0)),
    ),
    // Util/Miscellaneous/Line/EdgeToEdge
    PositionedDirectional(
      top: 203,
      start: 0,
      child:
          // Line 2
          Container(
              width: 375,
              height: 1,
              decoration: BoxDecoration(border: Border.all(color:  Color(0xffeeeeee), width: 1))),
    )
  ]);
}


Widget getAppDivider() {
  return Container(
    height: 1,
    decoration: BoxDecoration(
      border: Border.all(
        color: Color(0xffeeeeee),
        width: 1,
      ),
    ),
  );
}
