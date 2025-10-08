// // ignore_for_file: deprecated_member_use

// import 'dart:async';

// import 'package:after_layout/after_layout.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:ttt_merchant_flutter/api/sales_api.dart';
// import 'package:ttt_merchant_flutter/components/cards/home_page_cards/sale_history_card.dart';
// import 'package:ttt_merchant_flutter/components/controller/refresher.dart';
// import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
// // import 'package:ttt_merchant_flutter/components/table_calendar/table_calendar.dart';
// import 'package:ttt_merchant_flutter/components/ui/color.dart';
// import 'package:ttt_merchant_flutter/models/general/general_init.dart';
// import 'package:ttt_merchant_flutter/models/result.dart';
// import 'package:ttt_merchant_flutter/provider/general_provider.dart';

// class PurchaseHistoryPage extends StatefulWidget {
//   static const routeName = "PurchaseHistoryPage";
//   const PurchaseHistoryPage({super.key});

//   @override
//   State<PurchaseHistoryPage> createState() => _PurchaseHistoryPageState();
// }

// class _PurchaseHistoryPageState extends State<PurchaseHistoryPage>
//     with AfterLayoutMixin {
//   int selectedIndex = 0;
//   int? selectedIndexTile;
//   final List<String> tabs = ['Нийт', 'Өнөөдөр', '7 Хоног', '1 Сар', '1 Жил'];
//   final Map<String, String> tabFilters = {
//     'Нийт': 'ALL',
//     'Өнөөдөр': 'TODAY',
//     '7 Хоног': 'WEEK',
//     '1 Сар': 'MONTH',
//     '1 Жил': 'YEAR',
//   };
//   bool isLoadingPage = true;
//   String? selectedValue;
//   GeneralInit general = GeneralInit();
//   Result salesHistory = Result();
//   bool isLoadingHistory = true;
//   int page = 1;
//   int limit = 10;

//   listOfHistory(page, limit, {String? startDate, String? endDate}) async {
//     final String selectedTab = tabs[selectedIndex];
//     final String dateType = tabFilters[selectedTab] ?? 'ALL';
//     salesHistory = await SalesApi().getPurchaseHistory(
//       ResultArguments(
//         offset: Offset(page: page, limit: limit),
//         filter: Filter(dateType: dateType),
//       ),
//     );
//     setState(() {
//       isLoadingHistory = false;
//     });
//   }

//   @override
//   FutureOr<void> afterFirstLayout(BuildContext context) async {
//     try {
//       general = await Provider.of<GeneralProvider>(
//         context,
//         listen: false,
//       ).init();
//       await listOfHistory(page, limit);
//       setState(() {
//         isLoadingPage = false;
//       });
//     } catch (e) {
//       print(e);
//       setState(() {
//         isLoadingPage = false;
//       });
//     }
//   }

//   final RefreshController refreshController = RefreshController(
//     initialRefresh: false,
//   );

//   onRefresh() async {
//     await Future.delayed(const Duration(milliseconds: 1000));
//     if (!mounted) return;
//     setState(() {
//       isLoadingHistory = true;
//       isLoadingPage = true;
//       limit = 10;
//     });
//     general = await Provider.of<GeneralProvider>(context, listen: false).init();
//     setState(() {
//       isLoadingPage = false;
//     });
//     await listOfHistory(page, limit);
//     refreshController.refreshCompleted();
//   }

//   onLoading() async {
//     if (!mounted) return;
//     setState(() {
//       limit += 10;
//     });
//     await listOfHistory(page, limit);
//     refreshController.loadComplete();
//   }

//   DateTime? startDate;
//   DateTime? endDate;

//   String get formattedDate {
//     if (startDate == null && endDate == null) {
//       final now = DateTime.now();
//       return "${now.year}/${now.month.toString().padLeft(2, '0')}";
//     } else if (startDate != null && endDate == null) {
//       return "${startDate!.year}/${startDate!.month.toString().padLeft(2, '0')}/${startDate!.day.toString().padLeft(2, '0')}";
//     } else if (startDate != null && endDate != null) {
//       return "${startDate!.year}/${startDate!.month.toString().padLeft(2, '0')}/${startDate!.day.toString().padLeft(2, '0')} - "
//           "${endDate!.year}/${endDate!.month.toString().padLeft(2, '0')}/${endDate!.day.toString().padLeft(2, '0')}";
//     }
//     return "";
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: white,
//         centerTitle: false,
//         elevation: 1,
//         automaticallyImplyLeading: false,
//         titleSpacing: 12,
//         title: Text(
//           'Борлуулалтын түүх',
//           style: TextStyle(
//             color: black950,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.of(context).pop();
//           },
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(width: 16),
//               SvgPicture.asset('assets/svg/arrow_left_wide.svg'),
//             ],
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(8 + 16),
//           child: Container(
//             alignment: Alignment.centerLeft,
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: List.generate(tabs.length, (index) {
//                   final bool isSelected = selectedIndex == index;
//                   return GestureDetector(
//                     onTap: () async {
//                       setState(() {
//                         selectedIndex = index;
//                         isLoadingHistory = true;
//                       });

//                       await listOfHistory(page, limit);
//                     },
//                     child: Container(
//                       margin: EdgeInsets.only(right: 10),
//                       padding: EdgeInsets.symmetric(
//                         vertical: 6,
//                         horizontal: 10,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         color: isSelected ? orange : Colors.white,
//                         border: Border.all(
//                           color: isSelected ? orange : white100,
//                         ),
//                       ),
//                       child: Text(
//                         tabs[index],
//                         style: TextStyle(
//                           color: isSelected ? white : black600,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           ),
//         ),
//       ),
//       backgroundColor: white50,
//       body: isLoadingPage == true
//           ? CustomLoader()
//           : Refresher(
//               color: orange,
//               refreshController: refreshController,
//               onLoading: onLoading,
//               onRefresh: onRefresh,
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Борлуулалтын түүх',
//                         style: TextStyle(
//                           color: black600,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       isLoadingHistory == true
//                           ? CustomLoader()
//                           : ClipRRect(
//                               borderRadius: BorderRadius.circular(12),
//                               child: Column(
//                                 children: List.generate(
//                                   salesHistory.rows!.length,
//                                   (index) {
//                                     final isExpanded =
//                                         selectedIndexTile == index;
//                                     final item = salesHistory.rows![index];
//                                     return GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           if (selectedIndexTile == index) {
//                                             selectedIndexTile = null;
//                                           } else {
//                                             selectedIndexTile = index;
//                                           }
//                                         });
//                                       },
//                                       child: SaleHistoryCard(
//                                         isExtended: isExpanded,
//                                         data: item,
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),

//                       SizedBox(height: mediaQuery.padding.bottom + 50),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }
