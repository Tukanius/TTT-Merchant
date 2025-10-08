import 'package:flutter/material.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/general/general_init.dart';

class StoremanResidual extends StatefulWidget {
  final GeneralInit generalInit;
  const StoremanResidual({super.key, required this.generalInit});

  @override
  State<StoremanResidual> createState() => _StoremanResidualState();
}

class _StoremanResidualState extends State<StoremanResidual> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Үлдэгдэл',
              style: TextStyle(
                color: black400,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          widget.generalInit.residual != null
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: widget.generalInit.residual!
                        .map(
                          (data) => Row(
                            children: [
                              SizedBox(width: 12),

                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(8),
                                      child: data.mainImage != null
                                          ? Image.network(
                                              '${data.mainImage!.url}',
                                              height: 158,
                                              width: 158,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              height: 158,
                                              width: 158,
                                              'assets/images/default.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      '${data.name}',
                                      style: TextStyle(
                                        color: black950,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Үлдэгдэл: ${data.residual} ш',
                                      style: TextStyle(
                                        color: data.residual == 0
                                            ? redColor
                                            : black600,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Жин: ${data.weight ?? '-'}',
                                      style: TextStyle(
                                        color: black600,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                )
              : SizedBox(),
          //     ? Container(
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(100),
          //           color: white50,
          //         ),
          //         padding: EdgeInsets.symmetric(vertical: 4),
          //         child: DropdownButtonHideUnderline(
          //           child: DropdownButton2<String>(
          //             value: selectedResidual?.id,
          //             isDense: true,
          //             iconStyleData: IconStyleData(
          //               icon: Row(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   // const SizedBox(width: 6),
          //                   SvgPicture.asset(
          //                     'assets/svg/dropdown.svg',
          //                   ),
          //                   const SizedBox(width: 8),
          //                 ],
          //               ),
          //             ),

          //             selectedItemBuilder: (context) {
          //               return general.residual!.map((data) {
          //                 return Row(
          //                   mainAxisSize: MainAxisSize.min,
          //                   children: [
          //                     SvgPicture.asset(
          //                       'assets/svg/residual.svg',
          //                     ),
          //                     const SizedBox(width: 12),
          //                     Text(
          //                       data.name ?? '',
          //                       style: const TextStyle(
          //                         color: black950,
          //                         fontSize: 14,
          //                         fontWeight: FontWeight.w400,
          //                       ),
          //                       maxLines: 1,
          //                       overflow:
          //                           TextOverflow.ellipsis,
          //                     ),
          //                   ],
          //                 );
          //               }).toList();
          //             },
          //             onChanged: (newValue) {
          //               setState(() {
          //                 selectedResidual = general.residual!
          //                     .firstWhere(
          //                       (e) => e.id == newValue,
          //                     );
          //               });
          //             },
          //             dropdownStyleData: DropdownStyleData(
          //               decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.circular(
          //                   10,
          //                 ),
          //                 border: Border.all(color: white100),
          //               ),
          //               padding: EdgeInsets.all(6),
          //             ),
          //             menuItemStyleData: MenuItemStyleData(
          //               selectedMenuItemBuilder:
          //                   (context, child) {
          //                     return Container(
          //                       decoration: BoxDecoration(
          //                         color: orange,
          //                         borderRadius:
          //                             BorderRadius.circular(
          //                               6,
          //                             ),
          //                       ),
          //                       child: child,
          //                     );
          //                   },
          //             ),
          //             items: general.residual!.map((data) {
          //               final isSelected =
          //                   data.id == selectedResidual?.id;
          //               return DropdownMenuItem<String>(
          //                 value: data.id,
          //                 child: Text(
          //                   data.name ?? '',
          //                   style: TextStyle(
          //                     color: isSelected
          //                         ? white
          //                         : black950,
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.w400,
          //                   ),
          //                 ),
          //               );
          //             }).toList(),
          //           ),
          //         ),
          //       )
          //     : const SizedBox(),

          // SizedBox(height: 12),
          // Text(
          //   'Үлдэгдэл',
          //   style: TextStyle(
          //     color: black400,
          //     fontSize: 12,
          //     fontWeight: FontWeight.w400,
          //   ),
          // ),
          // SizedBox(height: 12),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           '${selectedResidual?.residual != null ? Utils().formatCurrencyDouble(selectedResidual!.residual!.toDouble()) : '-'} ш',
          //           style: TextStyle(
          //             color: orange,
          //             fontSize: 20,
          //             fontWeight: FontWeight.w700,
          //           ),
          //         ),
          //         SizedBox(height: 2),
          //         Text(
          //           '= ${selectedResidual?.weight ?? '-'}',
          //           style: TextStyle(
          //             color: black600,
          //             fontSize: 14,
          //             fontWeight: FontWeight.w400,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          // SizedBox(height: 12),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
