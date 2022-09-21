import 'package:flutter/cupertino.dart';

import '../helpers/custom_color.dart';

class SafeAreaWrapper extends StatelessWidget {
  final Widget child;

  const SafeAreaWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor().pureWhite,
      child: SafeArea(
        top: true,
        bottom: true,
        child: child,
      ),
    );
  }
}
