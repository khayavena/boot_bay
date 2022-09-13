import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/pages/category/viewmodel/categary_view_model.dart';
import 'package:bootbay/src/pages/category/widget/category_card.dart';
import 'package:bootbay/src/pages/category/widget/category_card_loader.dart';
import 'package:bootbay/src/pages/product/viewmodel/product_view_model.dart';
import 'package:bootbay/src/themes/theme.dart';
import 'package:bootbay/src/wigets/product_card.dart';
import 'package:bootbay/src/wigets/shared/custom_app_bar.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_5.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class CategoryProductPage extends StatefulWidget {
  final Category category;

  CategoryProductPage({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryProductPageState createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage>
    implements ClickCategory {
  late ProductViewModel _productViewModel;
  late CategoryViewModel _categoryViewModel;

  Widget _categoryWidget() {
    return Consumer<CategoryViewModel>(
      builder: (BuildContext context, CategoryViewModel categoryViewModel,
          Widget? child) {
        return Container(
          width: AppTheme.fullWidth(context),
          height: 38,
          child: _buildCategories(categoryViewModel),
        );
      },
    );
  }

  Widget _productWidget() {
    return Consumer<ProductViewModel>(
      builder: (BuildContext context, ProductViewModel productViewModel,
          Widget? child) {
        return _buildProducts(productViewModel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(widget.category.name, context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          horizontalDivider(),
          _categoryWidget(),
          horizontalDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  child: Text(
                'SORT',
                style: TextStyle(
                  color: Color(0xff999999),
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              )),
              Container(
                height: 38,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffeeeeee),
                    width: 1,
                  ),
                ),
              ),
              Container(
                child: Text(
                  'FILTER',
                  style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
          horizontalDivider(),
          _productWidget()
        ],
      ),
    );
  }

  void refreshCategory(String merchantId) async {
    await _categoryViewModel.getCategoriesById(merchantId);
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _categoryViewModel =
          Provider.of<CategoryViewModel>(context, listen: false);
      _productViewModel = Provider.of<ProductViewModel>(context, listen: false);
      refreshCategory(widget.category.merchantId);
    });
    super.initState();
  }

  void refreshProduct(String id, String merchantId) {
    _productViewModel.getMerchantProductsByCategory(id, merchantId);
  }

  Widget _buildCategories(CategoryViewModel categoryViewModel) {
    switch (categoryViewModel.loader) {
      case Loader.complete:
        return Container(
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: categoryViewModel.getCategories
                    .map((category) => CategoryCard(
                          model: category,
                          clickCategory: this,
                        ))
                    .toList()));
      case Loader.busy:
        return ListView(scrollDirection: Axis.horizontal, children: [
          CategoryCardLoader(),
          CategoryCardLoader(),
          CategoryCardLoader(),
          CategoryCardLoader(),
        ]);
      case Loader.error:
        return Container(
          child: Text(categoryViewModel.dataErrorMessage),
        );
      default:
        return Container(
          child: ColorLoader5(),
        );
    }
  }

  Widget _buildProducts(ProductViewModel productViewModel) {
    switch (productViewModel.loader) {
      case Loader.complete:
        return Expanded(
          child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .6 / 1,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8),
              padding: EdgeInsets.only(left: 8, right: 8),
              scrollDirection: Axis.vertical,
              children: productViewModel.getProducts
                  .map((product) => ProductCard(
                        product: product,
                        isEdit: true,
                      ))
                  .toList()),
        );
      case Loader.busy:
        return Container(
          height: 200,
          child: Center(child: ColorLoader5()),
        );
      case Loader.error:
        return Center(
          child: Text(
              "We currently experiencing problems, please try Again later "),
        );
      default:
        return Center(
          child: ColorLoader5(),
        );
    }
  }

  @override
  void onClick(final Category category) {
    refreshProduct(category.id ?? '', category.merchantId);
    _categoryViewModel.saveCategory(category);
  }

  Widget horizontalDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffeeeeee),
          width: 1,
        ),
      ),
    );
  }
}
