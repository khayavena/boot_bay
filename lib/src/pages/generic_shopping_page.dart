import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/helpers/ResSize.dart';
import 'package:bootbay/src/pages/merchant/merchant_landing_page.dart';
import 'package:bootbay/src/wigets/cart/cart_action_widget.dart';
import 'package:bootbay/src/wigets/shared/search_action.dart';
import 'package:flutter/material.dart';

import '../../res.dart';

class GenericShoppingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShoppingState();
}

class _ShoppingState extends State<GenericShoppingPage> {
  bool isMan = true;
  BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                    isMan ? Res.men_landing_ic : Res.women_landing_ic),
                fit: BoxFit.cover,
              ))),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildColumn(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: _buildHeading(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: _buildSearchAndCart(),
          )
        ],
      ),
    );
  }

  Widget _buildColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[optionsWidget(), _buildViewAction()],
    );
  }

  Widget optionsWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          child: buildMaleWidget(),
          onTap: () {
            _changeState();
          },
        ),
        GestureDetector(
          child: buildWomenWidget(),
          onTap: () {
            _changeState();
          },
        )
      ],
    );
  }

  Widget _buildViewAction() {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   _buildContext,
        //   MaterialPageRoute(
        //       builder: (context) => LandingPage(
        //             title: isMan ? "Men" : "Women",
        //           )),
        // );
      },
      child: Container(
        margin: EdgeInsets.only(top: 25, bottom: 25),
        width: 93,
        height: 43,
        child: Center(
          child: Text(
            'View',
            style: TextStyle(
              color: primaryWhite,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: isMan ? secondaryBlueColor : primaryRedColor,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: isMan ? secondaryGreenDark : secondaryRedColor,
              offset: Offset(2, 2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWomenWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'WOMEN',
              style: TextStyle(
                color: primaryWhite,
                fontSize: isMan ? smallFontSize : xlargeFontSize,
                fontWeight: FontWeight.w700,
              ),
            )),
        isMan
            ? SizedBox()
            : Padding(
                padding: EdgeInsets.only(left: 16, top: 6),
                child: Container(
                  width: 60,
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ))
      ],
    );
  }

  Widget buildMaleWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 16),
            child: Text(
              'MEN',
              style: TextStyle(
                color: primaryWhite,
                fontSize: isMan ? xlargeFontSize : midFontSize,
                fontWeight: FontWeight.w700,
              ),
            )),
        isMan
            ? Padding(
                padding: EdgeInsets.only(right: 16, top: 6),
                child: Container(
                  width: 34,
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ))
            : SizedBox()
      ],
    );
  }

  void _changeState() {
    setState(() {
      isMan = !isMan;
    });
  }

  Widget _buildHeading() {
    return Padding(
        padding: EdgeInsets.only(top: 34, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Boot Bay',
              style: TextStyle(
                color: primaryWhite,
                fontSize: 12,
                fontFamily: 'AvenirNext',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'by Vena Digital',
              style: TextStyle(
                color: primaryWhite,
                fontSize: 9,
                fontFamily: 'AvenirNext',
              ),
            )
          ],
        ));
  }

  Widget _buildSearchAndCart() {
    return Padding(
      padding: EdgeInsets.only(right: 16, top: 39),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SearchAction(),
          SizedBox(
            width: 16,
          ),
          CartAction()
        ],
      ),
    );
  }
}
