import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/general/general_init.dart';
import 'package:ttt_merchant_flutter/models/purchase/products_model.dart';
import 'package:ttt_merchant_flutter/models/purchase_request.dart';
import 'package:ttt_merchant_flutter/provider/general_provider.dart';
import 'package:ttt_merchant_flutter/src/home_page/purchase_request_tools/confirm_purchase_request.dart';

class PurchaseRequestPageArguments {
  final String cardNumber;
  PurchaseRequestPageArguments({required this.cardNumber});
}

class PurchaseRequestPage extends StatefulWidget {
  final String cardNumber;

  static const routeName = "PurchaseRequestPage";
  const PurchaseRequestPage({super.key, required this.cardNumber});

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
        isLoadingPage = false;
      });
    }
  }

  onSubmit() async {
    try {
      setState(() {
        isLoading = true;
      });
      List<Products> products = [];

      for (int i = 0; i < general.residual!.length; i++) {
        if (quantities[i] > 0) {
          products.add(
            Products(
              product: general.residual![i].id,
              quantity: quantities[i],
              name: general.residual![i].name,
            ),
          );
        }
      }
      PurchaseRequest request = PurchaseRequest();
      request.cardNumber = widget.cardNumber;
      request.products = products;
      await Navigator.of(context).pushNamed(
        ConfirmPurchaseRequest.routeName,
        arguments: ConfirmPurchaseRequestArguments(
          data: request,
          payType: "CARD",
        ),
      );
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

  int get totalQuantity => quantities.fold(0, (sum, q) => sum + q);

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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          general.residual != null
                              ? GridView.builder(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
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
                                        borderRadius: BorderRadius.circular(6),
                                        color: white,
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            child: Image.asset(
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
                                                  color: black600,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                '${resData.residual}',
                                                style: TextStyle(
                                                  color: black950,
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
                                                GestureDetector(
                                                  // onTap: () {
                                                  //   setState(() {
                                                  //     if (quantities[index] > 0) {
                                                  //       quantities[index]--;
                                                  //     }
                                                  //   });
                                                  // },
                                                  onTap: () {
                                                    if (resData.residual! > 0) {
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
                                                    color: white50,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 6,
                                                          horizontal: 7,
                                                        ),
                                                    child: SvgPicture.asset(
                                                      'assets/svg/minus.svg',
                                                      height: 24,
                                                      width: 24,
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
                                                    alignment: Alignment.center,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 6,
                                                        ),
                                                    child: TextField(
                                                      controller:
                                                          controllers[index],
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textAlign:
                                                          TextAlign.center,
                                                      enabled:
                                                          resData.residual! > 0,
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
                                                            border: InputBorder
                                                                .none,
                                                            isDense: true,
                                                            contentPadding:
                                                                EdgeInsets.zero,
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
                                                                .residual!;
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

                                                GestureDetector(
                                                  // onTap: () {
                                                  //   setState(() {
                                                  //     quantities[index]++;
                                                  //   });
                                                  // },
                                                  onTap: () {
                                                    if (resData.residual! > 0) {
                                                      setState(() {
                                                        if (quantities[index] <
                                                            resData.residual!) {
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
                                                    color: white50,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 6,
                                                          horizontal: 7,
                                                        ),
                                                    child: SvgPicture.asset(
                                                      'assets/svg/plus.svg',
                                                      height: 24,
                                                      width: 24,
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
                            height: MediaQuery.of(context).padding.bottom + 200,
                          ),
                        ],
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
                                              '0 шуудай эрх',
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
                                          onTap: () {
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
