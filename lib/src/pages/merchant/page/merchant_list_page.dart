import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/pages/merchant/viewmodel/merchant_view_model.dart';
import 'package:bootbay/src/wigets/merchant/merchant_card_widget.dart';
import 'package:bootbay/src/wigets/shared/custom_app_bar.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_5.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class MerchantListPage extends StatefulWidget {
  MerchantListPage({Key? key}) : super(key: key);

  @override
  _MerchantListPageState createState() => _MerchantListPageState();
}

class _MerchantListPageState extends State<MerchantListPage> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<MerchantViewModel>(context, listen: false).getAllMerchants();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.build("Boot-Bay", context),
        body: Container(child: _productWidget()));
  }

  Widget _productWidget() {
    return Consumer<MerchantViewModel>(
      builder: (BuildContext context, MerchantViewModel merchantViewModel,
          Widget? child) {
        return _buildProducts(merchantViewModel);
      },
    );
  }

  Widget _buildProducts(MerchantViewModel merchantViewModel) {
    switch (merchantViewModel.loader) {
      case Loader.complete:
        merchantViewModel.resetLoader();
        return GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .6 / 1,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8),
            padding: EdgeInsets.only(left: 8, right: 8),
            scrollDirection: Axis.vertical,
            children: merchantViewModel.getMerchants
                .map((merchant) => MerchantCardWidget(
                      merchant: merchant,
                    ))
                .toList());
      case Loader.busy:
        merchantViewModel.resetLoader();
        return Container(
          height: 200,
          child: Center(child: ColorLoader5()),
        );
      case Loader.error:
        merchantViewModel.resetLoader();
        return Center(
          child: Text(
              "We currently experiencing problems, please try Again later"),
        );
      default:
        return Center(
          child: ColorLoader5(),
        );
    }
  }
}
