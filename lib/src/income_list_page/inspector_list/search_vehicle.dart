// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ttt_merchant_flutter/api/product_api.dart';
import 'package:ttt_merchant_flutter/components/cards/income_page_cards/inspector_list_card.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/components/ui/form_textfield.dart';
import 'package:ttt_merchant_flutter/models/result.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/inspector_list/income_inspector_detail.dart';

class SearchVehicleArguments {
  final TextEditingController textEditingController;
  final Function(Result, String) onClick;
  // final Function(Properties) onSearch;
  SearchVehicleArguments({
    required this.textEditingController,
    required this.onClick,
    // required this.onSearch,
  });
}

class SearchVehicle extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(Result, String) onClick;
  // final Function(Properties) onSearch;

  static const routeName = "SearchVehicle";
  const SearchVehicle({
    super.key,
    required this.textEditingController,
    required this.onClick,
    // required this.onSearch,
  });

  @override
  State<SearchVehicle> createState() => _SearchVehicleState();
}

class _SearchVehicleState extends State<SearchVehicle> with AfterLayoutMixin {
  int page = 1;
  int limit = 100;
  Timer? timer;
  bool isLoadingList = true;
  Result inspectorList = Result();
  bool isLoadingPage = true;

  listOfInspector(page, limit, {String? query}) async {
    inspectorList = await ProductApi().getInspectorList(
      ResultArguments(
        offset: Offset(page: page, limit: limit),
        filter: Filter(query: query),
      ),
    );
    setState(() {
      isLoadingList = false;
    });
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      await listOfInspector(page, limit);
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

  onChange(String query) {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      if (query != '') {
        listOfInspector(page, limit, query: query);
      }
      // setState(() {
      //   isLoadingStays = false;
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          color: white50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 16),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        'assets/svg/arrow_left.svg',
                        color: black950,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: FormTextField(
                        controller: widget.textEditingController,
                        inputType: TextInputType.text,
                        contentPadding: EdgeInsets.all(12),
                        dense: true,
                        colortext: black,
                        color: white,
                        name: 'vehicleNumberFilter',
                        hintTextStyle: TextStyle(
                          color: black400,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        autoFocus: true,
                        hintText: 'Улсын дугаар хайх',
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 12),
                            SvgPicture.asset('assets/svg/search.svg'),
                            SizedBox(width: 8),
                          ],
                        ),

                        suffixIcon: null,
                        hintTextColor: gray103,
                        onChanged: (value) {
                          onChange(value);
                        },
                        onComplete: () {
                          // setState(() {
                          //   if (widget.textEditingController.text != '') {
                          //     Navigator.of(context).pop(true);
                          //     FocusScope.of(context).unfocus();
                          //     widget.onClick(
                          //       stays,
                          //       widget.textEditingController.text,
                          //     );
                          //   } else {
                          //     Navigator.of(context).pop(false);
                          //     FocusScope.of(context).unfocus();
                          //   }
                          //   // showSearchSection = false;
                          // });
                        },
                        onTap: () {
                          setState(() {
                            // _getBoundsFromProperties();
                            // showSearchSection = true;
                            // showSearchSection == true
                            // ? searchFocus.requestFocus()
                            // : FocusScope.of(context).unfocus();
                          });

                          // FocusScope.of(context)
                          //     .FocusScope
                          //     .of(context)
                          //     .requestFocus(searchFocus);
                          // showModalBottomSheet(
                          //   context: context,
                          //   isScrollControlled: true,
                          //   // shape: RoundedRectangleBorder(
                          //   //   borderRadius: BorderRadius.only(
                          //   //     topLeft: Radius.circular(16),
                          //   //     topRight: Radius.circular(16),
                          //   //   ),
                          //   // ),
                          //   isDismissible: false,
                          //   // backgroundColor: transparent,
                          //   builder: (context) {
                          //     return SearchOnMap();
                          //   },
                          // );
                          // widget.onChange();
                          //   showDialog(
                          //   context: context,
                          //   useSafeArea: false,
                          //   builder: (context) {
                          //     return SearchDetailPage();
                          //   },
                          // );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                isLoadingPage == true
                    ? CustomLoader()
                    : Expanded(
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: SingleChildScrollView(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            child: Column(
                              children: [
                                SizedBox(height: 16),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    isLoadingList == true
                                        ? CustomLoader()
                                        : inspectorList.rows?.isEmpty == true ||
                                              inspectorList.rows == null
                                        ? Column(
                                            children: [
                                              SizedBox(height: 12),
                                              Center(
                                                child: const Text(
                                                  'Түүх алга байна',
                                                  style: TextStyle(
                                                    color: black600,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child: Column(
                                              children: List.generate(
                                                inspectorList.rows!.length,
                                                (index) {
                                                  final item = inspectorList
                                                      .rows![index];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        // if (selectedIndexTile ==
                                                        //     index) {
                                                        //   selectedIndexTile =
                                                        //       null;
                                                        // } else {
                                                        //   selectedIndexTile =
                                                        //       index;
                                                        // }
                                                        //r
                                                      });
                                                      Navigator.of(
                                                        context,
                                                      ).pushNamed(
                                                        IncomeInspectorDetail
                                                            .routeName,
                                                        arguments:
                                                            IncomeInspectorDetailArguments(
                                                              id: item.id,
                                                            ),
                                                      );
                                                    },
                                                    child: InspectorListCard(
                                                      isExtended: false,
                                                      data: item,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
