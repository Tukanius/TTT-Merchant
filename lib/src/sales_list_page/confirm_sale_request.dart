import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ttt_merchant_flutter/api/auth_api.dart';
import 'package:ttt_merchant_flutter/api/sales_api.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/sales_models/request_product_post.dart';
import 'package:ttt_merchant_flutter/models/sales_models/sales_request.dart';
import 'package:ttt_merchant_flutter/models/user_models/user.dart';
import 'package:ttt_merchant_flutter/src/main_page.dart';
import 'package:ttt_merchant_flutter/utils/utils.dart';

class ConfirmSaleRequestArguments {
  final SalesRequest data;
  ConfirmSaleRequestArguments({required this.data});
}

class ConfirmSaleRequest extends StatefulWidget {
  final SalesRequest data;

  static const routeName = "ConfirmSaleRequest";
  const ConfirmSaleRequest({super.key, required this.data});

  @override
  State<ConfirmSaleRequest> createState() => _ConfirmSaleRequestState();
}

class _ConfirmSaleRequestState extends State<ConfirmSaleRequest>
    with AfterLayoutMixin {
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  bool isLoadingPage = true;
  List<TextEditingController> controllers = [];

  int get totalPrice {
    return (widget.data.requestProducts ?? [])
        .map((p) => (p.price ?? 0) * (p.totalCount ?? 0))
        .fold(0, (a, b) => a + b.toInt());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    widget.data.requestProducts?.map((p) {
      print("✅ Product ID: ${p.product}, ${p.totalCount}, ${p.price}");
      print('=====totalAmount=====');
    }).toList();
    controllers = (widget.data.requestProducts ?? [])
        .map((p) => TextEditingController(text: "${p.totalCount ?? 0}"))
        .toList();
    print(widget.data);
    super.initState();
  }

  User user = User();
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      user = await AuthApi().me(false);
      // general = await Provider.of<GeneralProvider>(
      //   context,
      //   listen: false,
      // ).init();
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
    try {
      setState(() {
        isLoading = true;
      });

      List<RequestProductPost> products = widget.data.requestProducts!
          .where((p) => (p.totalCount ?? 0) > 0)
          .map((p) {
            print("✅ Product ID: ${p.product}, Quantity: ${p.totalCount}");
            return RequestProductPost(
              product: p.product,
              totalCount: p.totalCount,
            );
          })
          .toList();
      SalesRequest request = SalesRequest()..requestProducts = products;
      await SalesApi().postSalesRequest(request);
      setState(() {
        isLoading = false;
      });
      await saleSuccess(context);
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  saleSuccess(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: white100),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SvgPicture.asset('assets/svg/success.svg'),
                SizedBox(height: 12),
                Text(
                  'Амжилттай',
                  style: TextStyle(
                    color: successColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Таны хүсэлт амжилттай илгээгдлээ.',
                  style: const TextStyle(
                    color: black500,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(
                      MainPage.routeName,
                      arguments: MainPageArguments(
                        changeIndex: 0,
                        userType: user.userType!,
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: orange,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Болсон',
                          style: TextStyle(
                            color: white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(
                      MainPage.routeName,
                      arguments: MainPageArguments(
                        changeIndex: 1,
                        userType: user.userType!,
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: white,
                      border: Border.all(color: white100),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Листээс харах',
                          style: TextStyle(
                            color: black800,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
            'Баталгаажуулах',
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
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.data.requestProducts != null
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      widget.data.requestProducts!.length,
                                  itemBuilder: (context, index) {
                                    final resData =
                                        widget.data.requestProducts![index];
                                    final residual = widget
                                        .data
                                        .requestProducts![index]
                                        .residual;
                                    final priceInfo = widget
                                        .data
                                        .requestProducts![index]
                                        .price;
                                    return Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(12),
                                          child: Dismissible(
                                            key: Key(
                                              resData.product.toString(),
                                            ),
                                            direction:
                                                DismissDirection.endToStart,
                                            background: Container(
                                              alignment: Alignment.centerRight,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                  ),
                                              color: redColor,
                                              child: SvgPicture.asset(
                                                'assets/svg/trash.svg',
                                              ),
                                            ),
                                            onDismissed: (direction) {
                                              setState(() {
                                                widget.data.requestProducts!
                                                    .removeAt(index);
                                              });

                                              if (widget
                                                  .data
                                                  .requestProducts!
                                                  .isEmpty) {
                                                Navigator.pop(context);
                                              }

                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  backgroundColor: orange,
                                                  content: Text(
                                                    "${resData.name} устлаа",
                                                    style: TextStyle(
                                                      color: white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: white,
                                              ),
                                              padding: const EdgeInsets.only(
                                                left: 4,
                                                right: 16,
                                                top: 4,
                                                bottom: 4,
                                              ),
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          6,
                                                        ),
                                                    child:
                                                        resData.mainImage !=
                                                            null
                                                        ? Image.network(
                                                            '${resData.mainImage!.url}',
                                                            height: 62,
                                                            width: 62,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'assets/images/default.jpg',
                                                            height: 62,
                                                            width: 62,
                                                            fit: BoxFit.cover,
                                                          ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          resData.name!,
                                                          style: TextStyle(
                                                            color: black950,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Үлдэгдэл: ',
                                                              style: TextStyle(
                                                                color: black600,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${residual} ш',
                                                              style: TextStyle(
                                                                color: black950,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Үнэ: ',
                                                              style: TextStyle(
                                                                color: black600,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${Utils().formatCurrencyDouble(priceInfo?.toDouble() ?? 0)} ₮',
                                                              style: TextStyle(
                                                                color: black950,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 12),
                                                  Expanded(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                        border: Border.all(
                                                          color: white100,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          InkWell(
                                                            // onTap: () {
                                                            //   setState(() {
                                                            //     if ((resData.totalCount ??
                                                            //             0) >
                                                            //         0) {
                                                            //       resData.totalCount =
                                                            //           resData
                                                            //               .totalCount! -
                                                            //           1;
                                                            //     }
                                                            //   });
                                                            // },
                                                            onTap:
                                                                isLoading ==
                                                                    true
                                                                ? () {}
                                                                : () {
                                                                    setState(() {
                                                                      if ((resData.totalCount ??
                                                                              0) >
                                                                          0) {
                                                                        resData.totalCount =
                                                                            (resData.totalCount ??
                                                                                0) -
                                                                            1;
                                                                        controllers[index]
                                                                            .text = resData
                                                                            .totalCount
                                                                            .toString(); // 🔥 энд шинэчилж өгнө
                                                                      }
                                                                    });
                                                                  },
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
                                                                    horizontal:
                                                                        7,
                                                                  ),
                                                              child: SvgPicture.asset(
                                                                'assets/svg/minus.svg',
                                                                height: 20,
                                                                width: 20,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding:
                                                                  const EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        12,
                                                                  ),
                                                              child: TextField(
                                                                controller:
                                                                    controllers[index], // тухайн мөрийн controller
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                  color:
                                                                      black950,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    final parsed =
                                                                        int.tryParse(
                                                                          value,
                                                                        ) ??
                                                                        0;
                                                                    widget
                                                                            .data
                                                                            .requestProducts![index]
                                                                            .totalCount =
                                                                        parsed;
                                                                  });
                                                                },
                                                                decoration: const InputDecoration(
                                                                  isDense: true,
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          // Expanded(
                                                          //   child: Container(
                                                          //     alignment: Alignment
                                                          //         .center,
                                                          //     padding:
                                                          //         const EdgeInsets.symmetric(
                                                          //           horizontal:
                                                          //               12,
                                                          //         ),
                                                          //     child: Text(
                                                          //       '${resData.totalCount ?? 0}',
                                                          //       style: TextStyle(
                                                          //         color: black950,
                                                          //         fontSize: 16,
                                                          //         fontWeight:
                                                          //             FontWeight
                                                          //                 .w600,
                                                          //       ),
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                          InkWell(
                                                            // onTap: () {
                                                            //   setState(() {
                                                            //     resData.totalCount =
                                                            //         (resData.totalCount ??
                                                            //             0) +
                                                            //         1;
                                                            //   });
                                                            // },
                                                            onTap:
                                                                isLoading ==
                                                                    true
                                                                ? () {}
                                                                : () {
                                                                    setState(() {
                                                                      resData.totalCount =
                                                                          (resData.totalCount ??
                                                                              0) +
                                                                          1;
                                                                      controllers[index]
                                                                          .text = resData
                                                                          .totalCount
                                                                          .toString(); // 🔥 энд бас
                                                                    });
                                                                  },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                color: white50,
                                                                borderRadius: BorderRadius.only(
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
                                                                    horizontal:
                                                                        7,
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
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                      ],
                                    );
                                  },
                                )
                              : const SizedBox(),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom + 150,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Нийт дүн:',
                                    style: TextStyle(
                                      color: black950,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${Utils().formatCurrencyDouble(totalPrice.toDouble())}₮',
                                    style: TextStyle(
                                      color: orange,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: isLoading == true
                                              ? () {}
                                              : () async {
                                                  await onSubmit();
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
                                                        'Баталгаажуулах',
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
