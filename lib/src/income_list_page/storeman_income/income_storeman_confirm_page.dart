// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/dist_confirm_income.dart';
import 'package:ttt_merchant_flutter/models/income_models/storeman_income_models/storeman_income_model.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/income_list_tools/order_problem_modal.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/storeman_income/accept_order_modal_storeman_confirm.dart';

class IncomeStoremanConfirmPageArguments {
  final StoremanIncomeModel data;

  IncomeStoremanConfirmPageArguments({required this.data});
}

class IncomeStoremanConfirmPage extends StatefulWidget {
  final StoremanIncomeModel data;
  static const routeName = "IncomeStoremanConfirmPage";
  const IncomeStoremanConfirmPage({super.key, required this.data});

  @override
  State<IncomeStoremanConfirmPage> createState() =>
      _IncomeStoremanConfirmPageState();
}

class _IncomeStoremanConfirmPageState extends State<IncomeStoremanConfirmPage> {
  bool isLoading = false;
  bool isComplaint = false;
  bool isIssueNumber = false;
  final Map<int, TextEditingController> _controllers = {};
  final Map<int, int> _editedQuantities = {};
  String compNote = '';
  ConfirmIncomeRequest confirmRequest = ConfirmIncomeRequest();
  // List<Products>? receiveProdut;
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.data.products != null) {
      for (var i = 0; i < widget.data.products!.length; i++) {
        _controllers[i] = TextEditingController(
          text: widget.data.products![i].quantity.toString(),
        );
        _editedQuantities[i] = widget.data.products![i].quantity!;
      }
    }
  }

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
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
            'Баталгаажуулалт',
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
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.data.code ?? '#'}',
                              style: TextStyle(
                                color: black950,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${DateFormat('yyyy/MM/dd HH:mm').format(DateTime.parse(widget.data.inOutTypes?[0].date! ?? widget.data.createdAt!).toLocal())}',
                              style: TextStyle(
                                color: black400,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color:
                                widget.data.inOutType == "NEW" ||
                                    widget.data.inOutType == "PENDING"
                                ? orange.withOpacity(0.1)
                                : green.withOpacity(0.1),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 4,
                          ),
                          child: Text(
                            '${widget.data.inOutType == "NEW"
                                ? 'Хуваарилагдсан'
                                : widget.data.inOutType == "PENDING"
                                ? 'Агуулахаас гарсан'
                                : widget.data.inOutType == "DONE"
                                ? 'Хүлээн авсан'
                                : "-"}',
                            style: TextStyle(
                              color:
                                  widget.data.inOutType == "NEW" ||
                                      widget.data.inOutType == "PENDING"
                                  ? orange
                                  : green,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(100),
                        //     color: green.withOpacity(0.1),
                        //   ),
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: 9,
                        //     vertical: 4,
                        //   ),
                        //   child: Text(
                        //     '${widget.data.transportStatus}',
                        //     style: TextStyle(
                        //       color: green,
                        //       fontSize: 10,
                        //       fontWeight: FontWeight.w500,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: white50),
                        top: BorderSide(color: white50),
                      ),
                      color: white,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svg/truck_avatar.svg'),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.data.vehiclePlateNo?.toUpperCase()}',
                              style: TextStyle(
                                color: black950,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '${widget.data.driverName ?? '-'}',
                              style: TextStyle(
                                color: black950,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Тоо ширхэг:',
                          style: TextStyle(
                            color: black800,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${widget.data.quantity} Ш',
                          style: TextStyle(
                            color: orange,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: white,
                      border: Border.all(color: white100),
                    ),
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        widget.data.type == "OUT"
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // setState(() {
                                          //   isIssueNumber = !isIssueNumber;
                                          // });
                                        },
                                        child: isIssueNumber == false
                                            ? SvgPicture.asset(
                                                'assets/svg/check_complain.svg',
                                              )
                                            : Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                    color: gray300,
                                                  ),
                                                ),
                                                // child: Center(child: Icon(Icons.check, size: 16)),
                                              ),
                                      ),

                                      SizedBox(width: 6),
                                      Text(
                                        'Хяналтын тоологч хянасан',
                                        style: TextStyle(
                                          color: black950,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Хяналтын тоологч хянасан үед агуулахаас түлш зарлагадах боломжтой.',
                                    style: TextStyle(
                                      color: black950,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                ],
                              )
                            :
                              // Row(
                              //   children: [
                              //     GestureDetector(
                              //       onTap: () {
                              //         setState(() {
                              //           isIssueNumber = !isIssueNumber;
                              //         });
                              //       },
                              //       child: isIssueNumber == true
                              //           ? SvgPicture.asset(
                              //               'assets/svg/check_complain.svg',
                              //             )
                              //           : Container(
                              //               width: 20,
                              //               height: 20,
                              //               decoration: BoxDecoration(
                              //                 borderRadius: BorderRadius.circular(6),
                              //                 border: Border.all(color: gray300),
                              //               ),
                              //               // child: Center(child: Icon(Icons.check, size: 16)),
                              //             ),
                              //     ),
                              //     SizedBox(width: 6),
                              //     Text(
                              //       'Хянагч хянасан',
                              //       style: TextStyle(
                              //         color: black950,
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.w600,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(height: 30),
                              // widget.data.inOutType == "IN" ||
                              //         widget.data.inOutType == null
                              //     ?
                              //     : widget.data.inOutType == "OUT"
                              //     ? Column(
                              //         children: [
                              //           Row(
                              //             children: [
                              //               GestureDetector(
                              //                 onTap: () {
                              //                   // setState(() {
                              //                   //   isIssueNumber = !isIssueNumber;
                              //                   // });
                              //                 },
                              //                 child: isIssueNumber == true
                              //                     ? SvgPicture.asset(
                              //                         'assets/svg/check_complain.svg',
                              //                       )
                              //                     : Container(
                              //                         width: 20,
                              //                         height: 20,
                              //                         decoration: BoxDecoration(
                              //                           borderRadius:
                              //                               BorderRadius.circular(6),
                              //                           border: Border.all(
                              //                             color: gray300,
                              //                           ),
                              //                         ),
                              //                         // child: Center(child: Icon(Icons.check, size: 16)),
                              //                       ),
                              //               ),
                              //               SizedBox(width: 6),
                              //               Text(
                              //                 'Хяналтын тоологч хянасан',
                              //                 style: TextStyle(
                              //                   color: black950,
                              //                   fontSize: 14,
                              //                   fontWeight: FontWeight.w600,
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //           SizedBox(height: 6),
                              //           Text(
                              //             'Хяналтын тоологч хянасан үед агуулахаас түлш зарлагадах боломжтой.',
                              //             style: TextStyle(
                              //               color: black950,
                              //               fontSize: 12,
                              //               fontWeight: FontWeight.w400,
                              //             ),
                              //           ),
                              //           SizedBox(height: 16),
                              //         ],
                              //       )
                              //     : SizedBox(),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isIssueNumber = !isIssueNumber;
                                          });
                                        },
                                        child: isIssueNumber == true
                                            ? SvgPicture.asset(
                                                'assets/svg/check_complain.svg',
                                              )
                                            : Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                    color: gray300,
                                                  ),
                                                ),
                                                // child: Center(child: Icon(Icons.check, size: 16)),
                                              ),
                                      ),

                                      SizedBox(width: 6),
                                      Text(
                                        'Дутсан',
                                        style: TextStyle(
                                          color: black950,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Танд ирсэн бүтээгдэхүүний тоо дутсан бол та бэлэн ирсэн тоог оруулаарай.',
                                    style: TextStyle(
                                      color: black950,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                ],
                              ),
                        widget.data.products != null
                            ? Column(
                                children: widget.data.products!.asMap().entries.map((
                                  entry,
                                ) {
                                  final index = entry.key;
                                  final data = entry.value;

                                  return Container(
                                    padding: EdgeInsets.only(
                                      top: 4,
                                      left: 4,
                                      right: 16,
                                      bottom: 4,
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/default.jpg',
                                          height: 62,
                                          width: 62,
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${data.name}',
                                                style: TextStyle(
                                                  color: black950,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'Илгээсэн: ${data.quantity}ш',
                                                style: TextStyle(
                                                  color: black950,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: white50,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: white100,
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 29,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              // mainAxisSize: MainAxisSize.min,
                                              children: [
                                                isIssueNumber
                                                    ? Expanded(
                                                        child: TextField(
                                                          controller:
                                                              _controllers[index],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: black950,
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
                                                            final parsed =
                                                                int.tryParse(
                                                                  value,
                                                                ) ??
                                                                0;
                                                            setState(() {
                                                              _editedQuantities[index] =
                                                                  parsed; // зөвхөн түр хадгалах
                                                            });
                                                          },
                                                        ),
                                                      )
                                                    : Text(
                                                        '${data.quantity}',
                                                        style: TextStyle(
                                                          color: black400,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 150),
                ],
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
                              : MediaQuery.of(context).padding.bottom + 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: transparent,
                                  builder: (context) {
                                    return OrderProblemModal(
                                      controller: textController,
                                      note: (value) {
                                        setState(() {
                                          compNote = textController.text;
                                        });
                                      },
                                      images: [],
                                      chechIssue: (value) {
                                        setState(() {
                                          isComplaint = value;
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: white,
                                  border: Border.all(color: white100),
                                ),
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        isComplaint == true
                                            ? SvgPicture.asset(
                                                'assets/svg/check_complain.svg',
                                              )
                                            : Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                    color: gray300,
                                                  ),
                                                ),
                                              ),
                                        SizedBox(width: 6),
                                        Text(
                                          'Зөрчил мэдэгдэх',
                                          style: TextStyle(
                                            color: black950,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 4),
                                    Text(
                                      'Түлш дутуу ирсэн, эсвэл түлшний уут савлагаа гэмтсэн тохиолдолд зөрчил мэдэдглэж болно.',
                                      style: TextStyle(
                                        color: black400,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      // onSubmit();
                                      // Navigator.of(context).pushNamed(routeName)
                                      confirmRequest.receivedProducts =
                                          widget.data.products;
                                      confirmRequest.isComplaint =
                                          isIssueNumber;
                                      confirmRequest.note = compNote;
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: transparent,
                                        builder: (context) {
                                          return AcceptOrderModalStoremanConfirm(
                                            data: confirmRequest,
                                            id: widget.data.id!,
                                            editedQuantity: _editedQuantities,
                                            product: widget.data,
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
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
                                                  child: Platform.isAndroid
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                                color: white,
                                                                strokeWidth:
                                                                    2.5,
                                                              ),
                                                        )
                                                      : Center(
                                                          child:
                                                              CupertinoActivityIndicator(
                                                                color: white,
                                                              ),
                                                        ),
                                                )
                                              : Text(
                                                  'Баталгаажуулах',
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
