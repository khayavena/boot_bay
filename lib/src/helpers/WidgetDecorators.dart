import 'package:bootbay/src/helpers/costom_color.dart';
import 'package:flutter/cupertino.dart';

final buttonDecorator = new BoxDecoration(
  color: Color(0xff2783a9),
  borderRadius: BorderRadius.circular(4),
  boxShadow: [BoxShadow(color: Color(0x7f103747), offset: Offset(2, 2), blurRadius: 8, spreadRadius: 0)],
);

final smallButtonDecorator = new BoxDecoration(
  color: Color(0xff2783a9),
  borderRadius: BorderRadius.circular(1),
  boxShadow: [BoxShadow(color: Color(0x7f103747), offset: Offset(2, 2), blurRadius: 2, spreadRadius: 0)],
);

final smallButtonDecoratorGrey = new BoxDecoration(
  color: Color(0xff9f9f9f),
  borderRadius: BorderRadius.circular(1),
  boxShadow: [BoxShadow(color: Color(0x7f103747), offset: Offset(2, 2), blurRadius: 2, spreadRadius: 0)],
);

final tileDecorator = new BoxDecoration(
  color: CustomColor().pureWhite,
  boxShadow: [BoxShadow(color: CustomColor().pureWhite, offset: Offset(1, 1), spreadRadius: 0)],
);