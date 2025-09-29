import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:ttt_merchant_flutter/api/auth_api.dart';
import 'package:ttt_merchant_flutter/api/product_api.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/dist_confirm_income.dart';
import 'package:ttt_merchant_flutter/models/income_models/storeman_income_models/storeman_income_model.dart';
import 'package:ttt_merchant_flutter/models/purchase_models/product_purchase_model.dart';
import 'package:ttt_merchant_flutter/models/user.dart';
import 'package:ttt_merchant_flutter/src/main_page.dart';

class AcceptOrderModalStoremanConfirm extends StatefulWidget {
  final ConfirmIncomeRequest data;
  final String id;
  final Map<int, int> editedQuantity;
  final StoremanIncomeModel product;
  const AcceptOrderModalStoremanConfirm({
    super.key,
    required this.data,
    required this.id,
    required this.editedQuantity,
    required this.product,
  });

  @override
  State<AcceptOrderModalStoremanConfirm> createState() =>
      _AcceptOrderModalStoremanConfirmState();
}

class _AcceptOrderModalStoremanConfirmState
    extends State<AcceptOrderModalStoremanConfirm>
    with AfterLayoutMixin {
  TextEditingController pinput = TextEditingController();
  bool validate = false;
  bool isLoading = false;
  final defaultPinTheme = PinTheme(
    width: 80,
    height: 62,
    textStyle: TextStyle(
      fontSize: 16,
      color: black,
      fontWeight: FontWeight.w700,
    ),
    decoration: BoxDecoration(
      color: white,
      border: Border.all(color: white100),
      borderRadius: BorderRadius.circular(8),
    ),
  );
  bool isLoadingPage = true;
  User user = User();
  @override
  afterFirstLayout(BuildContext context) async {
    try {
      user = await AuthApi().me(false);
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  void _saveEdits() {
    widget.editedQuantity.forEach((index, value) {
      widget.product.products![index].quantity = value;
    });
  }

  onSubmit() async {
    print(pinput.text);
    print('====pinput===text====');
    if (pinput.text != 'null' &&
        pinput.text.length <= 4 &&
        pinput.text.isEmpty == false) {
      _saveEdits();
      setState(() {
        validate = false;
        isLoading = true;
      });
      List<ProductPurchaseModel> products = widget.data.receivedProducts!
          .where((p) => (p.quantity ?? 0) > 0)
          .map((p) {
            print("✅ Product ID: ${p.productId}, Quantity: ${p.name}");
            return ProductPurchaseModel(
              id: p.id,
              price: p.price,
              quantity: p.quantity,
            );
          })
          .toList();
      ConfirmIncomeRequest request = ConfirmIncomeRequest()
        ..code = pinput.text
        ..isComplaint = widget.data.isComplaint
        ..receivedProducts = products;
      await ProductApi().incomeConfirm(request, widget.id);
      Navigator.of(context).pop();
      setState(() {
        isLoading = false;
      });
      teeverSuccess(context);
    } else {
      setState(() {
        isLoading = false;
        validate = true;
      });
    }
  }

  teeverSuccess(BuildContext context) {
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
                    // Navigator.of(context).pop();
                    // Navigator.of(context).pop();
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
                // SizedBox(height: 16),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.of(context).pop();
                //     Navigator.of(context).pop();
                //     Navigator.of(context).pop();
                //     Navigator.of(
                //       context,
                //     ).pushNamed(PurchaseHistoryPage.routeName);
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(12),
                //       color: white,
                //       border: Border.all(color: white100),
                //     ),
                //     padding: EdgeInsets.symmetric(vertical: 10),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text(
                //           'Листээс харах',
                //           style: TextStyle(
                //             color: black800,
                //             fontSize: 14,
                //             fontWeight: FontWeight.w600,
                //             decoration: TextDecoration.none,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: white50,
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: black300,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Баталгаажуулах',
                style: TextStyle(
                  color: black950,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Машины дугаар:',
                              style: TextStyle(
                                color: black800,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${widget.product.vehiclePlateNo ?? '-'}',
                              style: TextStyle(
                                color: black950,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Жолооч:',
                              style: TextStyle(
                                color: black800,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${widget.product.driverName ?? '-'}',
                              style: TextStyle(
                                color: black950,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Тоо ширхэг:',
                              style: TextStyle(
                                color: black800,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${widget.product.quantity ?? '-'}ш',
                              style: TextStyle(
                                color: black950,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [Text('Жолооч'), Text('А.Аадар')],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [Text('Шахмал түлш'), Text('200ш/ 5тн')],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [Text('Тоо ширхэг'), Text('200ш')],
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: white,
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Жолоочын бааталгаажуулах 4 оронтой кодыг оруулна уу.',
                        style: TextStyle(
                          color: black950,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Pinput(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        closeKeyboardWhenCompleted: true,
                        // onCompleted: (value) => checkOpt(value),
                        controller: pinput,
                        validator: (value) {
                          if (value == null || value.isEmpty || value == '') {
                            return "Код оруулна уу";
                          }
                          if (value.length < 4) {
                            return "Баталгаажуулах код оруулна уу";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            validate = false;
                          });
                        },
                        length: 4,
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        defaultPinTheme: defaultPinTheme,
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: errorColor),
                        ),
                        errorTextStyle: TextStyle(
                          color: errorColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      validate == true
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 12),
                                Text(
                                  'Баталгаажуулах код оруулна уу',
                                  style: TextStyle(
                                    color: redColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(height: 12),
                              ],
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: isLoading == true
                          ? () {}
                          : () {
                              onSubmit();
                            },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: orange,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isLoading == true
                                ? Container(
                                    // margin: EdgeInsets.only(right: 15),
                                    width: 17,
                                    height: 17,
                                    child: Platform.isAndroid
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: white,
                                              strokeWidth: 2.5,
                                            ),
                                          )
                                        : Center(
                                            child: CupertinoActivityIndicator(
                                              color: white,
                                            ),
                                          ),
                                  )
                                : Text(
                                    'Батлах',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        ),
      ),
    );
  }
}
// Padding(
              //   padding: const EdgeInsets.all(16),
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(12),
              //       color: white,
              //     ),
              //     padding: EdgeInsets.all(14),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Захиалгын мэдээлэл',
              //           style: TextStyle(
              //             color: black400,
              //             fontSize: 12,
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              //         SizedBox(height: 8),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Түлш төрөл:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               'Хатуу түлш',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 4),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Тоо, хэмжээ:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               '12,000 ш',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 16),
              //         Container(
              //           height: 1,
              //           color: black200,
              //           width: MediaQuery.of(context).size.width,
              //         ),
              //         SizedBox(height: 16),
              //         Text(
              //           'Тээврийн мэдээлэл',
              //           style: TextStyle(
              //             color: black400,
              //             fontSize: 12,
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              //         SizedBox(height: 8),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Улсын дугаар:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               'УБА 3213',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 4),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Тээврийн компани:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               'УБА 3213',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 4),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Марк:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               'М2',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 4),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Жолооч:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               'Б.Батбаяр',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 4),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Жолоочийн утасны дугаар:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               '88888888',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 16),
              //         Container(
              //           height: 1,
              //           color: black200,
              //           width: MediaQuery.of(context).size.width,
              //         ),
              //         SizedBox(height: 16),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Илгээсэн:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               '20,000 ш ',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 4),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Хүлээн авсан:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               '12,000 ш',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 4),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Дутсан :',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               '8,000 ш',
              //               style: TextStyle(
              //                 color: redColor,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 16),
              //         Container(
              //           height: 1,
              //           color: black200,
              //           width: MediaQuery.of(context).size.width,
              //         ),
              //         SizedBox(height: 16),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Үнэ:',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //             Text(
              //               '18,000.00₮',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 2),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               '1ш: 5,000₮',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //             Text(
              //               '4x5,000₮',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 16),
              //         Row(
              //           children: [
              //             Expanded(
              //               child: LayoutBuilder(
              //                 builder: (context, constraints) {
              //                   final boxWidth = constraints.constrainWidth();
              //                   const dashWidth = 20.0;
              //                   const dashSpace = 6.0;
              //                   final dashCount =
              //                       (boxWidth / (dashWidth + dashSpace))
              //                           .floor();

              //                   return Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: List.generate(dashCount, (_) {
              //                       return Container(
              //                         width: dashWidth,
              //                         height: 3,
              //                         decoration: BoxDecoration(
              //                           color: orange,
              //                           borderRadius: BorderRadius.circular(
              //                             100,
              //                           ),
              //                         ),
              //                       );
              //                     }),
              //                   );
              //                 },
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 16),
              //         Text(
              //           'Нийт хүлээн авсан тоо:',
              //           style: TextStyle(
              //             color: black950,
              //             fontSize: 16,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //         SizedBox(height: 4),
              //         Row(
              //           children: [
              //             Text(
              //               '12 тон ',
              //               style: TextStyle(
              //                 color: orange,
              //                 fontSize: 26,
              //                 fontWeight: FontWeight.w700,
              //               ),
              //             ),
              //             Text(
              //               '15ш',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),