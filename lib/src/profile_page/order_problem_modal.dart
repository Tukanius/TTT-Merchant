import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/components/ui/form_textfield.dart';

class OrderProblemModal extends StatefulWidget {
  const OrderProblemModal({super.key});

  @override
  State<OrderProblemModal> createState() => _OrderProblemModalState();
}

class _OrderProblemModalState extends State<OrderProblemModal>
    with AfterLayoutMixin {
  TextEditingController pinput = TextEditingController();

  bool isLoading = false;

  @override
  afterFirstLayout(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Зөрчил мэдэгдэх',
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
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: white,
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormTextField(
                        contentPadding: EdgeInsets.all(12),
                        dense: true,
                        colortext: black,
                        color: white50,
                        name: 'cardNumber',
                        hintTextStyle: TextStyle(
                          color: black500,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        hintText: 'Тайлбар оруулна уу.',
                        labelText: 'Тайлбар',
                        labelColor: black600,
                        borderRadius: 12,
                        maxLines: 5,
                        // validator: FormBuilderValidators.compose([
                        //   (value) {
                        //     return validatePhoneNumber(context, value.toString());
                        //   },
                        // ]),
                      ),
                      SizedBox(height: 16),

                      Text(
                        'Бүтээгдэхүүний зураг',
                        style: TextStyle(
                          color: black600,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: white50,
                          border: Border.all(color: black200),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                SvgPicture.asset('assets/svg/add_image.svg'),
                                SizedBox(height: 12),
                                Text(
                                  'Зураг оруулах',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Хамгийн багадаа 3 ширхэг зураг оруулна уу.',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                      onTap: () {},
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
                                    'Илгээх',
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
