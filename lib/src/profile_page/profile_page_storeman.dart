import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ttt_merchant_flutter/api/auth_api.dart';
import 'package:ttt_merchant_flutter/components/app_bar/custom_app_bar.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/general/general_init.dart';
import 'package:ttt_merchant_flutter/models/user.dart';
import 'package:ttt_merchant_flutter/provider/general_provider.dart';
import 'package:ttt_merchant_flutter/src/profile_page/profile_detail_page.dart';

class ProfilePageStoreman extends StatefulWidget {
  final Function(int) onChangePage;
  static const routeName = "ProfilePageStoreman";
  const ProfilePageStoreman({super.key, required this.onChangePage});

  @override
  State<ProfilePageStoreman> createState() => _ProfilePageStoremanState();
}

class _ProfilePageStoremanState extends State<ProfilePageStoreman>
    with AfterLayoutMixin {
  User user = User();
  bool isLoadingPage = true;
  GeneralInit general = GeneralInit();

  @override
  afterFirstLayout(BuildContext context) async {
    try {
      user = await AuthApi().me(false);
      general = await Provider.of<GeneralProvider>(
        context,
        listen: false,
      ).init();
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      backgroundColor: white50,
      body: isLoadingPage == true
          ? CustomLoader()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        ProfileDetailPage.routeName,
                        arguments: ProfileDetailPageArguments(data: general),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/svg/profile.svg'),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${user.firstName} ${user.lastName}',
                                  style: TextStyle(
                                    color: black950,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${general.inventory?.name ?? '-'}',
                                  style: TextStyle(
                                    color: black800,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SvgPicture.asset('assets/svg/arrow_right.svg'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pushNamed(IncomeListPage.routeName);
                      user.userType == "STORE_MAN"
                          ? widget.onChangePage(1)
                          : widget.onChangePage(2);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/svg/board.svg'),
                              SizedBox(width: 12),
                              Text(
                                'Түлш тээвэрлэлт',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SvgPicture.asset('assets/svg/arrow_right.svg'),
                        ],
                      ),
                    ),
                  ),

                  // SizedBox(height: 16),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: white,
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   padding: EdgeInsets.all(12),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           SvgPicture.asset('assets/svg/board.svg'),
                  //           SizedBox(width: 12),
                  //           Text(
                  //             'Татан авах хүсэлт',
                  //             style: TextStyle(
                  //               color: black950,
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.w500,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       SvgPicture.asset('assets/svg/arrow_right.svg'),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
    );
  }
}
