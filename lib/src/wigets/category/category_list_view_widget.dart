import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/globals.dart';
import 'package:bootbay/src/helpers/theme.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/viewmodel/CategaryViewModel.dart';
import 'package:bootbay/src/wigets/shared/custom_app_bar.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class CategoryListViewWidget extends StatefulWidget {
  final Merchant merchant;

  CategoryListViewWidget({@required this.merchant});

  @override
  _CategoryListViewWidgetState createState() {
    return _CategoryListViewWidgetState();
  }
}

class _CategoryListViewWidgetState extends State<CategoryListViewWidget> {
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.merchant != null) {
        Provider.of<CategoryViewModel>(context, listen: false)
            .getCategoriesById(widget.merchant.id);
      } else {
        Provider.of<CategoryViewModel>(context, listen: false)
            .getAllCategories();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme().appBackground,
      appBar: CustomAppBar.build("Edit Categories", context),
      body: Container(
        child: Column(
          children: [getDropdown()],
        ),
      ),
    );
  }

  Widget getDropdown() {
    return Container(
      child: Consumer<CategoryViewModel>(builder:
          (BuildContext context, CategoryViewModel value, Widget child) {
        switch (value.loader) {
          case Loader.idl:
          case Loader.complete:
            return _buildCategories(value);
          case Loader.busy:
            return ColorLoader4();
          case Loader.error:
            Center(
              child: Text("Add your own cat"),
            );
        }
        return SizedBox();
      }),
    );
  }

  Widget _buildCategories(CategoryViewModel value) {
    return Column(
        children: value.getCategories
            .map((model) => Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: EntryItem(
                    model,
                  ),
                ))
            .toList());
  }
}

class EntryItem extends StatelessWidget {
  EntryItem(this.entry);

  BuildContext _context;
  final Category entry;

  Widget _buildTiles(Category root) {
    if (!root.hasChildren)
      return Container(
        color: CustomTheme().pureWhite,
        child: ListTile(
          leading: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                      baseUrl + '/media/content/${root.id}'),
                ),
              )),
          title: Text(root.name),
          trailing: GestureDetector(
              onTap: () {
                _settingModalBottomSheet(_context, root);
              },
              child: Image.asset('assets/images/edit_action_ic.png')),
        ),
      );
    return ExpansionTile(
      key: PageStorageKey<Category>(root),
      title: Text(root.name),
      children: root.categories.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return _buildTiles(entry);
  }

  void _settingModalBottomSheet(context, Category root) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.delete),
                    title: Text(root.name),
                    onTap: () => Navigator.pushNamed(
                        bc, AppRouting.addEditCategory,
                        arguments: root)),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text(root.name),
                  onTap: () => {
                    Navigator.pushNamed(bc, AppRouting.addEditCategory,
                        arguments: root)
                  },
                ),
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text("Add Items"),
                  onTap: () => {},
                )
              ],
            ),
          );
        });
  }
}
