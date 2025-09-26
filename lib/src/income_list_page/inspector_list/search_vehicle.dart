// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ttt_merchant_flutter/api/product_api.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/components/ui/form_textfield.dart';
import 'package:ttt_merchant_flutter/models/inspector_models/search_vehicle.dart';
import 'package:ttt_merchant_flutter/models/result.dart';

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

class _SearchVehicleState extends State<SearchVehicle> {
  bool isLoadingStays = false;

  Result result = Result();
  int page = 1;
  int limit = 100;
  Timer? timer;
  listStays(page, limit, query) async {
    SearchByPlateNo data = SearchByPlateNo();

    setState(() {
      isLoadingStays = true;
    });
    data.vehiclePlateNo = query;
    result = await ProductApi().searchVehicle(data);
    // stays = await ProductApi().getStaysList(
    //   query != ''
    //       ? ResultArguments(page: page, limit: limit, query: query)
    //       : ResultArguments(page: page, limit: limit),
    // );
    // _getBoundsFromProperties();
    setState(() {
      isLoadingStays = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  onChange(String query) {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      if (query != '') {
        listStays(page, limit, query);
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
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
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
                  SizedBox(height: 16),
                  Expanded(
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
                                isLoadingStays == true
                                    ? CustomLoader()
                                    : result.rows?.isEmpty == 0 ||
                                          result.rows == null
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
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemCount: result.rows!.length,
                                        itemBuilder: (context, index) {
                                          final item = result.rows![index];
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                Navigator.of(context).pop(true);
                                                FocusScope.of(
                                                  context,
                                                ).unfocus();
                                                // widget.onSearch(item);
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 15,
                                              ),
                                              child: Text(item),
                                            ),
                                          );
                                        },
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
      ),
    );
  }
}
