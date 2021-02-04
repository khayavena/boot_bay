import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/theme.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/viewmodel/CategaryViewModel.dart';
import 'package:bootbay/src/wigets/shared/custom_app_bar.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
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
          children: [addCategoryEditCard(), getDropdown()],
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
            return dropWidget(value);
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

  Widget addCategoryEditCard() {
    return Card(
      child: ListTile(
        title: buildEditText(),
        trailing: GestureDetector(
            onTap: () {
              String category = categoryController.text;
            },
            child: Icon(Icons.save)),
      ),
    );
  }

  Widget buildEditText({String value = ''}) {
    categoryController = TextEditingController();

    final email = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: categoryController,
      decoration: InputDecoration(
        hintText: 'Add Category',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    categoryController.text = value;
    return Container(
      child: email,
    );
  }

  Widget dropWidget(CategoryViewModel value) {
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
                    onTap: () => {}),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text(root.name),
                  onTap: () => {},
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
