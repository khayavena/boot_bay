import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/helpers/costom_color.dart';
import 'package:bootbay/src/helpers/globals.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryEntryItemWidget extends StatelessWidget {
  final Category entry;
  final Merchant merchant;

  CategoryEntryItemWidget(this.entry, this.merchant);

  Widget _buildTiles(Category root, context) {
    if (!root.hasChildren)
      return Container(
        color: CustomColor().pureWhite,
        child: ListTile(
          leading: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(baseUrl + '/media/content/${root.id}'),
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
              child: Image.asset(
                'assets/images/more_icon.png',
              )),
        ),
      );
    return ExpansionTile(
      key: PageStorageKey<Category>(root),
      title: Text(root.name,
          style: TextStyle(
              color: CustomColor().originalBlack,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              fontSize: 15.0)),
      children: root.categories.map((item) => _buildTiles(item, context)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry, context);
  }

  void _settingModalBottomSheet(context, Category root, Merchant merchant) {
    Map<String, dynamic> map = {'category': root, 'merchant': merchant};
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.delete),
                    title: Text(root.name),
                    onTap: () {
                      Navigator.pushNamed(bc, AppRouting.editCategory, arguments: map);
                    }),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text(root.name),
                  onTap: () => {Navigator.pushNamed(bc, AppRouting.editCategory, arguments: map)},
                ),
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text("Add New"),
                  onTap: () => Navigator.pushNamed(bc, AppRouting.addCategory, arguments: merchant),
                )
              ],
            ),
          );
        });
  }
}
