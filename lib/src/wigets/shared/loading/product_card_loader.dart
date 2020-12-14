import 'package:bootbay/src/themes/light_color.dart';
import 'package:flutter/material.dart';

class ProductCardLoader extends StatefulWidget {
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCardLoader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LightColor.background,
        borderRadius: BorderRadius.all(Radius.circular(2)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 15),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: LightColor.orange.withAlpha(40),
                  ),
                  Container(
                    width: 50,
                    height: 100,
                    color: Colors.white70,
                  )
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 20,
                color: Colors.white70,
              ),
              Text(
                "Boot Pay",
              ),
              Container(
                width: 35,
                height: 20,
                color: Colors.white70,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Text(''),
                color: LightColor.orange,
              )
            ],
          ),
        ],
      ),
    );
  }
}
