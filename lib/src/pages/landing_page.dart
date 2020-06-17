import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/ProductQuery.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/themes/light_color.dart';
import 'package:bootbay/src/themes/theme.dart';
import 'package:bootbay/src/viewmodel/CategaryViewModel.dart';
import 'package:bootbay/src/viewmodel/ProductViewModel.dart';
import 'package:bootbay/src/wigets/category_card.dart';
import 'package:bootbay/src/wigets/category_card_loader.dart';
import 'package:bootbay/src/wigets/product_card.dart';
import 'package:bootbay/src/wigets/shared/color_loader_5.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    implements ClickCategory, ProductItemListener {
  ProductViewModel _productViewModel;
  CategoryViewModel categoryViewModel;

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }

  Widget _categoryWidget() {
    return Consumer<CategoryViewModel>(
      builder: (BuildContext context, CategoryViewModel categoryViewModel,
          Widget child) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: AppTheme.fullWidth(context),
          height: 80,
          child: _buildCategories(categoryViewModel),
        );
      },
    );
  }

  Widget _productWidget() {
    return Consumer<ProductViewModel>(
      builder: (BuildContext context, ProductViewModel productViewModel,
          Widget child) {
        return _buildProducts(productViewModel);
      },
    );
  }

  Widget _search() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: LightColor.lightGrey.withAlpha(100),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Products",
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black54)),
              ),
            ),
          ),
          SizedBox(width: 20),
          _icon(Icons.filter_list, color: Colors.black54),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[_search(), _categoryWidget(), _productWidget()],
    );
  }

  void refreshCategory(String merchantId) async {
    await categoryViewModel.getCategoriesById(merchantId);
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      categoryViewModel =
          Provider.of<CategoryViewModel>(context, listen: false);
      _productViewModel = Provider.of<ProductViewModel>(context, listen: false);
      refreshCategory("5ee3bfbea1fbe46a462d6c4a");
    });
    super.initState();
  }

  void refreshProduct(String id, String merchantId) {
    _productViewModel.getMerchantProductsByCategory(id, merchantId);
  }

  void refreshFilter() {
    ProductQuery query = ProductQuery(
        categories: categoryViewModel
            .getSelectedCategories()
            .map((e) => e.id)
            .toList());
    _productViewModel.queryProducts(query);
  }

  Widget _buildCategories(CategoryViewModel categoryViewModel) {
    switch (categoryViewModel.loader) {
      case Loader.complete:
        ProductQuery query = ProductQuery(
            categories:
                categoryViewModel.getCategories.map((e) => e.id).toList());

        _productViewModel?.queryProducts(query);
        return ListView(
            scrollDirection: Axis.horizontal,
            children: categoryViewModel.getCategories
                .map((category) => CategoryCard(
                      model: category,
                      clickCategory: this,
                    ))
                .toList());
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
                  childAspectRatio: .7 / 1,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8),
              padding: EdgeInsets.only(left: 8),
              scrollDirection: Axis.vertical,
              children: productViewModel.getProducts
                  .map((product) => ProductCard(
                        product: product,productItemListener: this,
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
    refreshProduct(category.id, category.merchantId);
    categoryViewModel.saveCategory(category);
  }

  @override
  void onAdd(Product product) {
    _productViewModel.saveProduct(product);
  }

  @override
  void onRemove(Product product) {
    _productViewModel.deleteProduct(product);
  }
}
