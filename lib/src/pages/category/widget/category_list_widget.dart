import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/costom_color.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/pages/category/viewmodel/categary_view_model.dart';
import 'package:bootbay/src/pages/category/widget/category_entry_item_widget.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
import 'package:bootbay/src/wigets/shared/nested_scroll_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class CategoryListWidget extends StatefulWidget {
  final Merchant merchant;

  CategoryListWidget({@required this.merchant});

  @override
  _CategoryListWidgetState createState() {
    return _CategoryListWidgetState();
  }
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
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
            return WidgetLoader();
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
