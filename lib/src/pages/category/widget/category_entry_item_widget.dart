import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/helpers/custom_color.dart';
import 'package:bootbay/src/helpers/image_helper.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryEntryItemWidget extends StatelessWidget {
  final Category entry;
  final Merchant merchant;

  CategoryEntryItemWidget(this.entry, this.merchant);

  Widget _buildTiles(Category root, context) {
    return ListTile(
      leading: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(getImageUri(root.id ?? '')),
            ),
          )),
      title: Text(
        root.name,
        style: TextStyle(
            color: CustomColor().originalBlack,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 15.0),
      ),
      trailing: GestureDetector(
          onTap: () {
            _settingModalBottomSheet(context, root, merchant);
          },
          child: Icon(
            Icons.keyboard_arrow_right,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry, context);
  }

  void _settingModalBottomSheet(context, Category root, Merchant merchant) {
    Navigator.pushNamed(context, AppRouting.editCategoryProductPage,
        arguments: root);
  }
}
