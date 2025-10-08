import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ttt_merchant_flutter/api/sales_api.dart';
import 'package:ttt_merchant_flutter/components/controller/refresher.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/dialog/error_dialog.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/card_models/card_balance.dart';
// import 'package:ttt_merchant_flutter/models/check_card.dart';
import 'package:ttt_merchant_flutter/models/general/general_init.dart';
import 'package:ttt_merchant_flutter/models/purchase_models/product_purchase_model.dart';
import 'package:ttt_merchant_flutter/models/purchase_models/purchase_request.dart';
import 'package:ttt_merchant_flutter/models/payment_models/qpay_payment.dart';
import 'package:ttt_merchant_flutter/provider/general_provider.dart';
import 'package:ttt_merchant_flutter/src/purchase_request_page/create_payment.dart';

class PurchaseRequestPageArguments {
  final CardBalance data;
  final String payType;
  PurchaseRequestPageArguments({required this.data, required this.payType});
}

class PurchaseRequestPage extends StatefulWidget {
  final CardBalance data;
  final String payType;

  static const routeName = "PurchaseRequestPage";
  const PurchaseRequestPage({
    super.key,
    required this.data,
    required this.payType,
  });

  @override
  State<PurchaseRequestPage> createState() => _PurchaseRequestPageState();
}

class _PurchaseRequestPageState extends State<PurchaseRequestPage>
    with AfterLayoutMixin {
  // Controller-ууд хадгалах List
  List<TextEditingController> controllers = [];

  bool isLoading = false;
  int purchaseIndex = 0;
  GeneralInit general = GeneralInit();
  bool isLoadingPage = true;
  List<int> quantities = [];

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    print('======TestCARD=====');
    print(widget.data.card?.availableLimit);
    print(widget.data.card?.cardNo);
    print(widget.data.appUserId);
    print('======TestCARD=====');

    try {
      general = await Provider.of<GeneralProvider>(
        context,
        listen: false,
      ).init();
      if (general.residual != null) {
        quantities = List.filled(general.residual!.length, 0);
        controllers = List.generate(
          general.residual!.length,
          (i) => TextEditingController(text: '0'),
        );
      }
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  onSubmit() async {
    if (totalQuantity == 0) {
      ErrorDialog(context: context).show('Бараа сонгоно уу.');
    } else {
      try {
        setState(() {
          isLoading = true;
        });
        List<ProductPurchaseModel> products = [];
        List<ProductPurchaseModel> productsShow = [];

        for (int i = 0; i < general.residual!.length; i++) {
          if (quantities[i] > 0) {
            products.add(
              ProductPurchaseModel(
                productId: general.residual![i].id,
                quantity: quantities[i],
                // name: general.residual![i].name,
                // price: general.productTypes![i].price,
                // residual: general.residual![i].residual,
              ),
            );
            productsShow.add(
              ProductPurchaseModel(
                productId: general.residual![i].id,
                quantity: quantities[i],
                name: general.residual![i].name,
                price: general.productTypes![i].price,
                residual: general.residual![i].residual,
                mainImage: general.residual![i].mainImage != null
                    ? general.residual![i].mainImage
                    : null,
              ),
            );
          }
        }

        PurchaseRequest request = PurchaseRequest();
        request.cardNumber = widget.data.card?.cardNo;
        request.products = products;
        request.salesType = widget.payType;
        request.device = widget.data.device;
        if (widget.payType == "QR") {
          request.appUserId = widget.data.appUserId;
        }

        // await Navigator.of(context).pushNamed(
        //   ConfirmPurchaseRequest.routeName,
        //   arguments: ConfirmPurchaseRequestArguments(data: request),
        // );
        QpayPayment qpayPayment = QpayPayment();
        qpayPayment = await SalesApi().postPurchaseRequest(request);
        await Navigator.of(context).popAndPushNamed(
          CreatePayment.routeName,
          arguments: CreatePaymentArguments(
            id: qpayPayment.id!,
            data: productsShow,
            totalAmount: qpayPayment.amount!,
          ),
        );
        // widget.data.appUserId != null ?

        // await ProductApi().postPurchaseRequest(request);
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print(e);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  int get totalQuantity => quantities.fold(0, (sum, q) => sum + q);

  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      isLoadingPage = true;
    });
    general = await Provider.of<GeneralProvider>(context, listen: false).init();
    if (general.residual != null) {
      quantities = List.filled(general.residual!.length, 0);
      controllers = List.generate(
        general.residual!.length,
        (i) => TextEditingController(text: '0'),
      );
    }
    setState(() {
      isLoadingPage = false;
    });
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(
      context,
    );
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          centerTitle: false,
          elevation: 1,
          automaticallyImplyLeading: false,
          titleSpacing: 12,
          title: Text(
            'Борлуулах',
            style: TextStyle(
              color: black950,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 16),
                SvgPicture.asset('assets/svg/arrow_left_wide.svg'),
              ],
            ),
          ),
        ),
        backgroundColor: white50,
        body: isLoadingPage == true
            ? CustomLoader()
            : Stack(
                children: [
                  Refresher(
                    color: orange,
                    refreshController: refreshController,
                    onRefresh: onRefresh,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            general.residual != null
                                ? GridView.builder(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: general.residual!.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 16,
                                          mainAxisSpacing: 16,
                                          childAspectRatio: 0.55,
                                        ),
                                    itemBuilder: (context, index) {
                                      final resData = general.residual![index];
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          color: white,
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child: resData.mainImage != null
                                                  ? Image.network(
                                                      '${resData.mainImage!.url}',
                                                      height: 168,
                                                      width: 168,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(
                                                      'assets/images/default.jpg',
                                                      height: 168,
                                                      width: 168,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              resData.name!,
                                              style: TextStyle(
                                                color: black950,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Үлдэгдэл: ',
                                                  style: TextStyle(
                                                    color: resData.residual == 0
                                                        ? redColor
                                                        : black600,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  '${resData.residual}',
                                                  style: TextStyle(
                                                    color: resData.residual == 0
                                                        ? redColor
                                                        : black950,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: white,
                                                border: Border.all(
                                                  color: white100,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    // onTap: () {
                                                    //   setState(() {
                                                    //     if (quantities[index] > 0) {
                                                    //       quantities[index]--;
                                                    //     }
                                                    //   });
                                                    // },
                                                    onTap: isLoading == true
                                                        ? () {}
                                                        : () {
                                                            if (resData
                                                                    .residual ==
                                                                0) {
                                                              ErrorDialog(
                                                                context:
                                                                    context,
                                                              ).show(
                                                                'Борлуулагчийн үлдэгдэл хүрэлцэхгүй байна.',
                                                              );
                                                            }
                                                            if (resData
                                                                    .residual! >
                                                                0) {
                                                              setState(() {
                                                                if (quantities[index] >
                                                                    0) {
                                                                  quantities[index]--;
                                                                  controllers[index]
                                                                          .text =
                                                                      quantities[index]
                                                                          .toString();
                                                                }
                                                              });
                                                            }
                                                          },
                                                    // onTap: () {
                                                    //   setState(() {
                                                    //     if (quantities[index] >
                                                    //         0) {
                                                    //       quantities[index]--;
                                                    //       controllers[index]
                                                    //               .text =
                                                    //           quantities[index]
                                                    //               .toString();
                                                    //     }
                                                    //   });
                                                    // },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: white50,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                              topLeft:
                                                                  Radius.circular(
                                                                    8,
                                                                  ),
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                    8,
                                                                  ),
                                                            ),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 6,
                                                            horizontal: 7,
                                                          ),
                                                      child: SvgPicture.asset(
                                                        'assets/svg/minus.svg',
                                                        height: 20,
                                                        width: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  // Expanded(
                                                  //   child: Container(
                                                  //     color: white,
                                                  //     alignment: Alignment.center,
                                                  //     padding:
                                                  //         const EdgeInsets.symmetric(
                                                  //           vertical: 6,
                                                  //         ),
                                                  //     child: Text(
                                                  //       '${quantities[index]}',
                                                  //       style: TextStyle(
                                                  //         color: black950,
                                                  //         fontSize: 16,
                                                  //         fontWeight:
                                                  //             FontWeight.w600,
                                                  //       ),
                                                  //       textAlign: TextAlign.center,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 6,
                                                          ),
                                                      child: TextField(
                                                        readOnly:
                                                            isLoading == true
                                                            ? true
                                                            : false,
                                                        controller:
                                                            controllers[index],
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        textAlign:
                                                            TextAlign.center,
                                                        enabled:
                                                            resData.residual! >
                                                            0,
                                                        style: TextStyle(
                                                          color:
                                                              resData.residual! >
                                                                  0
                                                              ? black950
                                                              : black400,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        decoration:
                                                            const InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              isDense: true,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                            ),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            int parsed =
                                                                int.tryParse(
                                                                  value,
                                                                ) ??
                                                                0;

                                                            if (parsed < 0)
                                                              parsed = 0;
                                                            if (parsed >
                                                                resData
                                                                    .residual!) {
                                                              parsed = resData
                                                                  .residual!
                                                                  .toInt();
                                                              // хэрэглэгч их бичсэн тохиолдолд шууд зөв утгаар солино
                                                              controllers[index]
                                                                  .text = parsed
                                                                  .toString();
                                                              controllers[index]
                                                                      .selection =
                                                                  TextSelection.fromPosition(
                                                                    TextPosition(
                                                                      offset: controllers[index]
                                                                          .text
                                                                          .length,
                                                                    ),
                                                                  );
                                                            }

                                                            quantities[index] =
                                                                parsed;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),

                                                  InkWell(
                                                    // onTap: () {
                                                    //   setState(() {
                                                    //     quantities[index]++;
                                                    //   });
                                                    // },
                                                    onTap: isLoading == true
                                                        ? () {}
                                                        : () {
                                                            if (resData
                                                                    .residual ==
                                                                0) {
                                                              ErrorDialog(
                                                                context:
                                                                    context,
                                                              ).show(
                                                                'Борлуулагчийн үлдэгдэл хүрэлцэхгүй байна.',
                                                              );
                                                            }
                                                            if (resData
                                                                    .residual! >
                                                                0) {
                                                              setState(() {
                                                                if (quantities[index] <
                                                                    resData
                                                                        .residual!) {
                                                                  quantities[index]++;
                                                                  controllers[index]
                                                                          .text =
                                                                      quantities[index]
                                                                          .toString();
                                                                }
                                                              });
                                                            }
                                                          },
                                                    // onTap: () {
                                                    //   setState(() {
                                                    //     quantities[index]++;
                                                    //     controllers[index].text =
                                                    //         quantities[index]
                                                    //             .toString();
                                                    //   });
                                                    // },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: white50,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                              topRight:
                                                                  Radius.circular(
                                                                    8,
                                                                  ),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                    8,
                                                                  ),
                                                            ),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 6,
                                                            horizontal: 7,
                                                          ),
                                                      child: SvgPicture.asset(
                                                        'assets/svg/plus.svg',
                                                        height: 20,
                                                        width: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                : SizedBox(),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).padding.bottom + 200,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  !isKeyboardVisible
                      ? Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Container(
                            color: white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 16,
                                right: 16,
                                left: 16,
                                bottom: Platform.isIOS
                                    ? MediaQuery.of(context).padding.bottom
                                    : MediaQuery.of(context).padding.bottom +
                                          16,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: white,
                                      border: Border.all(color: white100),
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Хэрэглэгчийн үлдэгдэл',
                                              style: TextStyle(
                                                color: black400,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              '${widget.data.card?.availableLimit ?? 0} шуудай эрх',
                                              style: TextStyle(
                                                color: orange,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Нийт тоо:',
                                        style: TextStyle(
                                          color: black800,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        '${totalQuantity} шуудай нүүрс',
                                        style: TextStyle(
                                          color: black950,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: isLoading == true
                                              ? () {}
                                              : () {
                                                  onSubmit();
                                                },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: orange,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                isLoading == true
                                                    ? Container(
                                                        // margin: EdgeInsets.only(right: 15),
                                                        width: 17,
                                                        height: 17,
                                                        child:
                                                            Platform.isAndroid
                                                            ? Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                      color:
                                                                          white,
                                                                      strokeWidth:
                                                                          2.5,
                                                                    ),
                                                              )
                                                            : Center(
                                                                child:
                                                                    CupertinoActivityIndicator(
                                                                      color:
                                                                          white,
                                                                    ),
                                                              ),
                                                      )
                                                    : Text(
                                                        'Үргэлжлүүлэх',
                                                        style: TextStyle(
                                                          color: white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
      ),
    );
  }
}

class Product {
  Product({
    required this.name,
    required this.stockText,
    required this.image,
    this.qty = 0,
  });

  final String name;
  final String stockText;
  final String image;
  int qty;
}
