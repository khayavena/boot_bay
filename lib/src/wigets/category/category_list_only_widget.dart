import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/costom_color.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/viewmodel/CategaryViewModel.dart';
import 'package:bootbay/src/wigets/category/category_entry_item_widget.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
import 'package:bootbay/src/wigets/shared/nested_scroll_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class CategoryListOnlyWidget extends StatefulWidget {
  final Merchant merchant;

  CategoryListOnlyWidget({@required this.merchant});

  @override
  _CategoryListOnlyWidgetState createState() {
    return _CategoryListOnlyWidgetState();
  }
}

class _CategoryListOnlyWidgetState extends State<CategoryListOnlyWidget> {
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.merchant != null) {
        Provider.of<CategoryViewModel>(context, listen: false).getCategoriesById(widget.merchant.id);
      } else {
        Provider.of<CategoryViewModel>(context, listen: false).getAllCategories();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor().appBackground,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Consumer<CategoryViewModel>(builder: (BuildContext context, CategoryViewModel value, Widget child) {
        switch (value.loader) {
          case Loader.idl:
          case Loader.complete:
            return _buildCategories(value);
          case Loader.busy:
            return ColorLoader4();
          case Loader.error:
            Center(
              child: Text("Something went wrong"),
            );
        }
        return SizedBox();
      }),
    );
  }

  Widget _buildCategories(CategoryViewModel value) {
    return ListView.separated(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      separatorBuilder: (context, index) => getAppDivider(),
      itemCount: value.getCategories.length,
      itemBuilder: (context, index) => CategoryEntryItemWidget(value.getCategories[index], widget.merchant),
    );
  }
}
