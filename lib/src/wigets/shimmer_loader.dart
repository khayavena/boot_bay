import 'package:flutter/material.dart';

class CardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      height: 166,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 52,
            decoration: BoxDecoration(
              color: Color(0xfff4f4f4),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Row(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(right: 12),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(bottom: 6, top: 13),
                          width: 135,
                          height: 12,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2))),
                      Container(
                          width: 32,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2)))
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 29, bottom: 8, left: 16),
              width: 155,
              height: 12,
              decoration: BoxDecoration(
                  color: Color(0xfff4f4f4),
                  borderRadius: BorderRadius.circular(2))),
          Container(
              margin: EdgeInsets.only(left: 16),
              width: 83,
              height: 12,
              decoration: BoxDecoration(
                  color: Color(0xfff4f4f4),
                  borderRadius: BorderRadius.circular(2)))
        ],
      ),
    );
  }
}

Widget loadProductShimmers() {
  List children = [];
  children.add("value");
  children.add("value");
  children.add("value");
  children.add("value");
  children.add("value");
  return Expanded(
    child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .7 / 1,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8),
        padding: EdgeInsets.only(left: 8),
        scrollDirection: Axis.vertical,
        children: children.map((product) => CardShimmer()).toList()),
  );
}
