import 'package:bootbay/res.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/ResFont.dart';
import 'package:bootbay/src/model/pay_method/model/product.dart';
import 'package:bootbay/src/model/pay_method/model/token_request.dart';
import 'package:bootbay/src/model/pay_method/model/token_response.dart';
import 'package:bootbay/src/model/pay_method/model/user_profile.dart';
import 'package:bootbay/src/pages/checkout/drop_in/yoco_web_drop_in_page.dart';
import 'package:bootbay/src/pages/checkout/viewmodel/payment_view_model.dart';
import 'package:bootbay/src/pages/checkout/viewmodel/yoco_view_model.dart';
import 'package:bootbay/src/pages/checkout/widget/bill_product_row_widget.dart';
import 'package:bootbay/src/pages/checkout/widget/card_to_spend_widget.dart';
import 'package:bootbay/src/pages/checkout/widget/payment_metho_action_widget.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
import 'package:bootbay/src/wigets/title_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../helpers/image_helper.dart';
import '../../../wigets/safe_area_wrapper.dart';

class CheckoutCartPage extends StatefulWidget {
  final double finalAmount;
  final String itemIds;
  final String currency;
  final String merchantId;
  final UserProfile profile;
  final List<Product> products;

  @override
  _CheckoutCartPageState createState() => _CheckoutCartPageState();

  CheckoutCartPage({required this.finalAmount,
    required this.itemIds,
    required this.currency,
    required this.merchantId,
    required this.profile,
    required this.products});
}

class _CheckoutCartPageState extends State<CheckoutCartPage> {
  late PaymentViewModel _paymentViewModel;
  late TokenResponse _tokenResponse;
  late YocoViewModel _yokoViewModel;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _paymentViewModel = Provider.of<PaymentViewModel>(
        context,
        listen: false,
      );
      _yokoViewModel = Provider.of<YocoViewModel>(
        context,
        listen: false,
      );
      _paymentViewModel.getToken(TokenRequest(
          merchantId: widget.merchantId,
          customerId: widget.profile.customerId,
          isAfrica: false));
      _paymentViewModel.products = widget.products;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaWrapper(
      child: Scaffold(
        body: Container(child: Consumer<PaymentViewModel>(
            builder: (BuildContext context, paymentViewModel, Widget? child) {
              switch (paymentViewModel.loader) {
                case Loader.busy:
                  return WidgetLoader();
                case Loader.complete:
                  if (paymentViewModel.paymentStatus == PaymentStatus.auth) {
                    _tokenResponse = paymentViewModel.getTokenResponse;
                    return Stack(
                      children: [
                        _buildBillWidget(
                          context,
                          paymentViewModel,
                          'Authorized',
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 30.0, horizontal: 8.0),
                            width: double.maxFinite,
                            child: ElevatedButton(
                              onPressed: () {
                                beginPayment();
                              },
                              child: Text(
                                "Continue Pay",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 24),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  if (paymentViewModel.paymentStatus == PaymentStatus.payment) {
                    return _buildPaymentSuccess(paymentViewModel);
                  }
                  break;
                case Loader.error:
                  switch (paymentViewModel.paymentStatus) {
                    case PaymentStatus.auth:
                      return Container(
                        child: Center(child: paymentStatus('Auth failed')),
                      );
                    default:
                      return Container(
                        child: Center(child: paymentStatus('Payment failed')),
                      );
                  }
              }
              return paymentStatus('Please wait, loading');
            })),
      ),
    );
  }

  Widget paymentStatus(String status, {bool isSuccess = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Center(
          child: TitleText(
            text: status,
            fontSize: 22,
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        isSuccess == false ? WidgetLoader() : SizedBox()
      ],
    );
  }

  Widget _buildPaymentSuccess(PaymentViewModel paymentViewModel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: double.maxFinite,
              height: 270,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                      getImageUri(widget.merchantId)),
                ),
              )),
        ),
        Center(
            child: paymentStatus(paymentViewModel.getPaymentResponse.message,
                isSuccess: paymentViewModel.getPaymentResponse.status)),
        Container(width: 100, height: 100, child: Image.asset(Res.success)),
        SizedBox(
          height: 30,
        ),
        Center(
          child: TitleText(
              text: paymentViewModel.getPaymentResponse.currency +
                  "-" +
                  paymentViewModel.getPaymentResponse.totalAmount
                      .toStringAsFixed(2)
                      .toString(),
              fontWeight: FontWeight.w700,
              fontSize: 24),
        ),
        SizedBox(
          height: 8,
        ),
        Center(
          child: TitleText(
            text: "Payment Id: " + paymentViewModel.getPaymentResponse.id,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.maxFinite,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/");
              },
              child: Text("Continue Shopping"),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBillWidget(BuildContext context, PaymentViewModel payViewModel,
      String status) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 50, bottom: 16),
            child: Text('YOUR BILL',
                style: TextStyle(
                  color: Color(0xff2783a9),
                  fontSize: 25,
                  fontWeight: mediumFont,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.6400000000000001,
                )),
          ),
        ),
        CardToSpend(leftToSpend: widget.finalAmount, currency: widget.currency),
        Consumer<YocoViewModel>(
            builder: (BuildContext context, yocoViewModel, Widget? child) {
              if (yocoViewModel.yocoPayMethod != null) {
                yocoViewModel.buildPay(
                    _tokenResponse,
                    widget.finalAmount,
                    widget.currency,
                    widget.itemIds,
                    widget.merchantId,
                    yocoViewModel.yocoPayMethod?.result.id);
              }

              return InkWell(
                onTap: () async {
                  final url = await Provider.of<YocoViewModel>(
                    context,
                    listen: false,
                  ).buildUrl(widget.finalAmount, widget.currency);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          YocoWebDropInPage(
                              finalAmount: widget.finalAmount,
                              itemIds: widget.itemIds,
                              currency: widget.currency,
                              merchantId: widget.merchantId,
                              url: url),
                    ),
                  );
                },
                child: SelectPayMethodRow(
                  title: yocoViewModel.yocoPayMethod?.result.source.brand ??
                      'Select Payment Method',
                  cardMask: yocoViewModel.yocoPayMethod?.result.source
                      .maskedCard ??
                      '***************',
                ),
              );
            }),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: payViewModel.products
                .map((e) =>
                BillProductRow(
                  expense: e,
                  currency: widget.currency,
                  onDismissed: onDismissed,
                  onUpdated: onUpdate,
                ))
                .toList(),
          ),
        ),
      ],
    );
  }

  void beginPayment() {
    _paymentViewModel.pay(_yokoViewModel.finalRequest);
  }

  void onDismissed(Product p1) {

  }

  void onUpdate(Product p1) {

  }
}
