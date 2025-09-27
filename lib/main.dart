import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:ttt_merchant_flutter/firebase_options.dart';
import 'package:ttt_merchant_flutter/provider/general_provider.dart';
import 'package:ttt_merchant_flutter/provider/user_provider.dart';
import 'package:ttt_merchant_flutter/services/navigation.dart';
import 'package:ttt_merchant_flutter/services/notification.dart';
import 'package:ttt_merchant_flutter/src/auth/user_set_password_page.dart';
import 'package:ttt_merchant_flutter/src/auth/forget_password_page.dart';
import 'package:ttt_merchant_flutter/src/auth/login_page.dart';
import 'package:ttt_merchant_flutter/src/auth/set_password_page.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/distributor_income/income_distributor_detail.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/inspector_list/search_vehicle.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/storeman_income/income_storeman_confirm_page.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/storeman_income/income_storeman_detail.dart';
import 'package:ttt_merchant_flutter/src/purchase_request_page/create_payment.dart';
// import 'package:ttt_merchant_flutter/src/purchase_request_page/purchase_request_tools/qpay_payment.dart';
import 'package:ttt_merchant_flutter/src/not_found_user.dart';
import 'package:ttt_merchant_flutter/src/purchase_request_page/purchase_history_page.dart';
import 'package:ttt_merchant_flutter/src/purchase_request_page/purchase_request_tools/user_card_request_page.dart';
import 'package:ttt_merchant_flutter/src/sales_list_page/confirm_sale_request.dart';
import 'package:ttt_merchant_flutter/src/sales_list_page/sale_detail_page.dart';
import 'package:ttt_merchant_flutter/src/sales_list_page/sale_payment.dart';
import 'package:ttt_merchant_flutter/src/sales_list_page/sales_request_page.dart';
// import 'package:ttt_merchant_flutter/src/purchase_request_page/confirm_purchase_request.dart';
import 'package:ttt_merchant_flutter/src/purchase_request_page/purchase_request_page.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/distributor_income/income_confirm_page.dart';
import 'package:ttt_merchant_flutter/src/main_page.dart';
import 'package:ttt_merchant_flutter/src/notify_page/notify_page.dart';
import 'package:ttt_merchant_flutter/src/purchase_request_page/purchase_request_tools/qr_read_screen.dart';
// import 'package:ttt_merchant_flutter/src/income_list_page/income_list_page.dart';
import 'package:ttt_merchant_flutter/src/profile_page/profile_detail_page.dart';
import 'package:ttt_merchant_flutter/src/splash_page/splash_page.dart';
import 'package:ttt_merchant_flutter/src/wallet_page/wallet_qpay_charge.dart';
import 'package:ttt_merchant_flutter/src/wallet_page/wallet_recharge.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotifyService().initNotify();
  await FirebaseMessaging.instance.requestPermission();
  await Upgrader.clearSavedSettings();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    NotifyService().showNotification(
      title: message.notification?.title,
      body: message.notification?.body,
    );
  });
  locator.registerLazySingleton(() => NavigationService());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => GeneralProvider()),
        ],
        child: MyApp(),
      ),
    );
  });
}

GetIt locator = GetIt.instance;

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static int invalidTokenCount = 0;

  static setInvalidToken(int count) {
    invalidTokenCount = count;
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    String? token = await _firebaseMessaging.getToken();
    String? APNStoken = await _firebaseMessaging.getAPNSToken();
    print('TOKEN==== $token');
    print('APNSTOKEN==== $APNStoken');
    if (token != null) {
      userProvider.setDeviceToken(token);
    }
  }

  // void initState() {
  //   super.initState();
  //   loadTranslations();
  // }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        builder: (context, child) {
          return MediaQuery.withNoTextScaling(child: child ?? const SizedBox());
        },
        title: 'TTT Борлуулагч',
        theme: ThemeData(useMaterial3: false),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashPage.routeName,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case SplashPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const SplashPage();
                },
              );
            case MainPage.routeName:
              MainPageArguments arguments =
                  settings.arguments as MainPageArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return MainPage(
                    changeIndex: arguments.changeIndex,
                    userType: arguments.userType,
                  );
                },
              );
            case LoginPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const LoginPage();
                },
              );
            case ForgetPasswordPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const ForgetPasswordPage();
                },
              );
            case SalesRequestPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const SalesRequestPage();
                },
              );
            case NotifyPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const NotifyPage();
                },
              );
            case QrReadScreen.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return QrReadScreen();
                },
              );
            case PurchaseHistoryPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const PurchaseHistoryPage();
                },
              );
            // case PurchaseRequestHistoryPage.routeName:
            //   return MaterialPageRoute(
            //     builder: (context) {
            //       return const PurchaseRequestHistoryPage();
            //     },
            //   );
            case PurchaseRequestPage.routeName:
              PurchaseRequestPageArguments arguments =
                  settings.arguments as PurchaseRequestPageArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return PurchaseRequestPage(
                    data: arguments.data,
                    payType: arguments.payType,
                  );
                },
              );

            // case PurchaseRequestDetailPage.routeName:
            //   return MaterialPageRoute(
            //     builder: (context) {
            //       return const PurchaseRequestDetailPage();
            //     },
            //   );
            case ProfileDetailPage.routeName:
              ProfileDetailPageArguments arguments =
                  settings.arguments as ProfileDetailPageArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return ProfileDetailPage(data: arguments.data);
                },
              );
            // case OrderAcceptPage.routeName:
            //   return MaterialPageRoute(
            //     builder: (context) {
            //       return const OrderAcceptPage();
            //     },
            //   );
            case SetPasswordPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const SetPasswordPage();
                },
              );
            // case ConfirmPurchaseRequest.routeName:
            //   ConfirmPurchaseRequestArguments arguments =
            //       settings.arguments as ConfirmPurchaseRequestArguments;
            //   return MaterialPageRoute(
            //     builder: (context) {
            //       return ConfirmPurchaseRequest(
            //         data: arguments.data,
            //         payType: arguments.payType,
            //       );
            //     },
            //   );
            // case IncomeDetailPage.routeName:
            //   IncomeDetailPageArguments arguments =
            //       settings.arguments as IncomeDetailPageArguments;
            //   return MaterialPageRoute(
            //     builder: (context) {
            //       return IncomeDetailPage(data: arguments.data);
            //     },
            //   );
            case IncomeConfirmPage.routeName:
              IncomeConfirmPageArguments arguments =
                  settings.arguments as IncomeConfirmPageArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return IncomeConfirmPage(data: arguments.data);
                },
              );
            case ConfirmSaleRequest.routeName:
              ConfirmSaleRequestArguments arguments =
                  settings.arguments as ConfirmSaleRequestArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return ConfirmSaleRequest(data: arguments.data);
                },
              );
            case UserSetPasswordPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const UserSetPasswordPage();
                },
              );
            case SaleDetailPage.routeName:
              SaleDetailPageArguments arguments =
                  settings.arguments as SaleDetailPageArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return SaleDetailPage(id: arguments.id);
                },
              );
            // case QpayPaymentPage.routeName:
            //   QpayPaymentPageArguments arguments =
            //       settings.arguments as QpayPaymentPageArguments;
            //   return MaterialPageRoute(
            //     builder: (context) {
            //       return QpayPaymentPage(id: arguments.id);
            //     },
            //   );
            case WalletRecharge.routeName:
              WalletRechargeArguments arguments =
                  settings.arguments as WalletRechargeArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return WalletRecharge(
                    textController: arguments.textController,
                  );
                },
              );
            case WalletQpayCharge.routeName:
              WalletQpayChargeArguments arguments =
                  settings.arguments as WalletQpayChargeArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return WalletQpayCharge(data: arguments.data);
                },
              );
            case CreatePayment.routeName:
              CreatePaymentArguments arguments =
                  settings.arguments as CreatePaymentArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return CreatePayment(
                    id: arguments.id,
                    data: arguments.data,
                    totalAmount: arguments.totalAmount,
                  );
                },
              );
            case SalePayment.routeName:
              SalePaymentArguments arguments =
                  settings.arguments as SalePaymentArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return SalePayment(
                    payAmount: arguments.payAmount,
                    id: arguments.id,
                  );
                },
              );
            case NotFoundUser.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const NotFoundUser();
                },
              );
            case IncomeDistributorDetail.routeName:
              IncomeDistributorDetailArguments arguments =
                  settings.arguments as IncomeDistributorDetailArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return IncomeDistributorDetail(id: arguments.id);
                },
              );
            case IncomeStoremanDetail.routeName:
              IncomeStoremanDetailArguments arguments =
                  settings.arguments as IncomeStoremanDetailArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return IncomeStoremanDetail(id: arguments.id);
                },
              );
            case IncomeStoremanConfirmPage.routeName:
              IncomeStoremanConfirmPageArguments arguments =
                  settings.arguments as IncomeStoremanConfirmPageArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return IncomeStoremanConfirmPage(data: arguments.data);
                },
              );
            case SearchVehicle.routeName:
              SearchVehicleArguments arguments =
                  settings.arguments as SearchVehicleArguments;
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return SearchVehicle(
                    onClick: arguments.onClick,
                    textEditingController: arguments.textEditingController,
                    // onSearch: arguments.onSearch,
                  );
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(
                        begin: begin,
                        end: end,
                      ).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                transitionDuration: Duration(milliseconds: 300),
              );
            case UserCardRequestPage.routeName:
              UserCardRequestPageArguments arguments =
                  settings.arguments as UserCardRequestPageArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return UserCardRequestPage(data: arguments.data);
                },
              );
            default:
              return MaterialPageRoute(builder: (_) => const SplashPage());
          }
        },
      ),
    );
  }
}
