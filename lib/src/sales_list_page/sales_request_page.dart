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
import 'package:ttt_merchant_flutter/models/sales_models/request_product_post.dart';
import 'package:ttt_merchant_flutter/models/sales_models/sales_request.dart';
import 'package:ttt_merchant_flutter/provider/general_provider.dart';
import 'package:ttt_merchant_flutter/src/main_page.dart';
import 'package:ttt_merchant_flutter/src/sales_list_page/confirm_sale_request.dart';

class SalesRequestPage extends StatefulWidget {
  static const routeName = "SalesRequestPage";
  const SalesRequestPage({super.key});

  @override
  State<SalesRequestPage> createState() => _SalesRequestPageState();
}

class _SalesRequestPageState extends State<SalesRequestPage>
    with AfterLayoutMixin {
  bool isLoading = false;
  int purchaseIndex = 0;
  GeneralInit general = GeneralInit();
  bool isLoadingPage = true;
  List<int> quantities = [];
  List<TextEditingController> controllers = [];

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
      List<RequestProductPost> products = [];
      for (int i = 0; i < general.residual!.length; i++) {
        if (quantities[i] > 0) {
          products.add(
            RequestProductPost(
              product: general.residual![i].id,
              totalCount: quantities[i],
              name: general.residual![i].name,
            ),
          );
        }
      }
      SalesRequest request = SalesRequest()..requestProducts = products;

      await Navigator.of(context).pushNamed(
        ConfirmSaleRequest.routeName,
        arguments: ConfirmSaleRequestArguments(data: request),
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
                      arguments: MainPageArguments(changeIndex: 0),
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
                      arguments: MainPageArguments(changeIndex: 1),
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
            'ТАТАН АВАХ ХҮСЭЛТ',
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
                                                  //     if (quantities[index] >
                                                  //         0) {
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
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Нийт ширхэг:',
                                            style: TextStyle(
                                              color: black600,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '${totalQuantity} Ширхэг',
                                            style: TextStyle(
                                              color: black950,
                                              fontSize: 26,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
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
