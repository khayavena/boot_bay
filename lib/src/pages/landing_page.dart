import 'package:bootbay/res.dart';
import 'package:bootbay/src/config/route.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/model/ProductQuery.dart';
import 'package:bootbay/src/model/category.dart';
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

class _LandingPageState extends State<LandingPage> implements ClickCategory {
  ProductViewModel _productViewModel;
  CategoryViewModel categoryViewModel;

  Widget _categoryWidget() {
    return Consumer<CategoryViewModel>(
      builder: (BuildContext context, CategoryViewModel categoryViewModel, Widget child) {
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
      builder: (BuildContext context, ProductViewModel productViewModel, Widget child) {
        return _buildProducts(productViewModel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryWhite,
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Text(
          widget.title.toUpperCase(),
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: 15,
            fontFamily: 'SFProText',
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: <Widget>[
          IconButton(icon: ImageIcon(AssetImage(Res.search_ic)), color: primaryBlackColor, onPressed: () {}),
          Container(
            child: IconButton(
                icon: ImageIcon(AssetImage(Res.cart_ic)),
                color: primaryBlackColor,
                onPressed: () {
                  Navigator.of(context).pushNamed(CustomRoutes.cart_list);
                }),
          )
        ],
        leading: IconButton(icon: ImageIcon(AssetImage(Res.leading_icon)), color: primaryBlackColor, onPressed: () {}),
        centerTitle: true,
      ),
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
    await categoryViewModel.getCategoriesById(merchantId);
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      categoryViewModel = Provider.of<CategoryViewModel>(context, listen: false);
      _productViewModel = Provider.of<ProductViewModel>(context, listen: false);
      refreshCategory("5ee3bfbea1fbe46a462d6c4a");
    });
    super.initState();
  }

  void refreshProduct(String id, String merchantId) {
    _productViewModel.getMerchantProductsByCategory(id, merchantId);
  }

  void refreshFilter() {
    ProductQuery query = ProductQuery(categories: categoryViewModel.getSelectedCategories().map((e) => e.id).toList());
    _productViewModel.queryProducts(query);
  }

  Widget _buildCategories(CategoryViewModel categoryViewModel) {
    switch (categoryViewModel.loader) {
      case Loader.complete:
        ProductQuery query = ProductQuery(categories: categoryViewModel.getCategories.map((e) => e.id).toList());

        _productViewModel?.queryProducts(query);
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
                  crossAxisCount: 2, childAspectRatio: .6 / 1, mainAxisSpacing: 8, crossAxisSpacing: 8),
              padding: EdgeInsets.only(left: 8, right: 8),
              scrollDirection: Axis.vertical,
              children: productViewModel.getProducts
                  .map((product) => ProductCard(
                        product: product,
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
          child: Text("We currently experiencing problems, please try Again later "),
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
