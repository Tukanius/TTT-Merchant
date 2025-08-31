import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:ttt_merchant_flutter/provider/general_provider.dart';
import 'package:ttt_merchant_flutter/provider/user_provider.dart';
import 'package:ttt_merchant_flutter/services/navigation.dart';
import 'package:ttt_merchant_flutter/src/auth/forget_password_page.dart';
import 'package:ttt_merchant_flutter/src/auth/login_page.dart';
import 'package:ttt_merchant_flutter/src/auth/set_password_page.dart';
import 'package:ttt_merchant_flutter/src/home_page/purchase_request_page.dart';
import 'package:ttt_merchant_flutter/src/home_page/add_sales/confirm_request.dart';
import 'package:ttt_merchant_flutter/src/home_page/add_sales/sale_request_page.dart';
import 'package:ttt_merchant_flutter/src/home_page/sales_history_page.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/income_confirm_page.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/income_detail_page.dart';
import 'package:ttt_merchant_flutter/src/main_page.dart';
import 'package:ttt_merchant_flutter/src/notify_page/notify_page.dart';
import 'package:ttt_merchant_flutter/src/home_page/add_sales/qr_read_screen.dart';
import 'package:ttt_merchant_flutter/src/profile_page/order_accept_page.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/income_list_page.dart';
import 'package:ttt_merchant_flutter/src/profile_page/profile_detail_page.dart';
import 'package:ttt_merchant_flutter/src/profile_page/purchase_request_detail_page.dart';
import 'package:ttt_merchant_flutter/src/profile_page/purchase_request_history_page.dart';
import 'package:ttt_merchant_flutter/src/splash_page/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await NotifyService().initNotify();

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   NotifyService().showNotification(
  //     title: message.notification?.title,
  //     body: message.notification?.body,
  //   );
  // });
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
          // ChangeNotifierProvider(create: (_) => SocketProvider()),
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
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // FirebaseMessaging.instance.requestPermission();
    // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    // String? token = await _firebaseMessaging.getToken();
    // print('TOKEN==== $token');
    // if (token != null) {
    //   userProvider.setDeviceToken(token);
    // }
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
        // builder: (context, widget) => Navigator(
        //   onGenerateRoute: (settings) => MaterialPageRoute(
        //     builder: (context) =>
        //         DialogManager(child: loading(context, widget)),
        //   ),
        // ),
        title: 'TTT Merchant',
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
                  return MainPage(changeIndex: arguments.changeIndex);
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
            case PurchaseRequestPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const PurchaseRequestPage();
                },
              );
            case NotifyPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const NotifyPage();
                },
              );
            case QrReadScreen.routeName:
              QrReadScreenArguments arguments =
                  settings.arguments as QrReadScreenArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return QrReadScreen(onNavigateMain: arguments.onNavigateMain);
                },
              );
            case SalesHistoryPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const SalesHistoryPage();
                },
              );
            case PurchaseRequestHistoryPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const PurchaseRequestHistoryPage();
                },
              );
            case SaleRequestPage.routeName:
              SaleRequestPageArguments arguments =
                  settings.arguments as SaleRequestPageArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return SaleRequestPage(cardNumber: arguments.cardNumber);
                },
              );

            case PurchaseRequestDetailPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const PurchaseRequestDetailPage();
                },
              );
            case ProfileDetailPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const ProfileDetailPage();
                },
              );
            case IncomeListPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const IncomeListPage();
                },
              );
            case OrderAcceptPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const OrderAcceptPage();
                },
              );
            case SetPasswordPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const SetPasswordPage();
                },
              );
            case ConfirmRequest.routeName:
              ConfirmRequestArguments arguments =
                  settings.arguments as ConfirmRequestArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return ConfirmRequest(data: arguments.data);
                },
              );
            case IncomeDetailPage.routeName:
              IncomeDetailPageArguments arguments =
                  settings.arguments as IncomeDetailPageArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return IncomeDetailPage(data: arguments.data);
                },
              );
            case IncomeConfirmPage.routeName:
              IncomeConfirmPageArguments arguments =
                  settings.arguments as IncomeConfirmPageArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return IncomeConfirmPage(data: arguments.data);
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
