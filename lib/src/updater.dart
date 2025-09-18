// import 'package:flutter/material.dart';
// // import 'package:new_version_plus/new_version_plus.dart';
// import 'package:package_info_plus/package_info_plus.dart';

// class VersionCheck {
//   static Future<void> checkVersion(BuildContext context) async {
//     final newVersion = NewVersionPlus(
//       androidId: "com.yourcompany.yourapp", // play store packageName
//       iOSId: "1234567890", // app store ID
//     );

//     final versionStatus = await newVersion.getVersionStatus();
//     final packageInfo = await PackageInfo.fromPlatform();
//     final currentVersion = packageInfo.version;

//     debugPrint("📌 Current version: $currentVersion");
//     debugPrint("📌 Store version: ${versionStatus?.storeVersion}");

//     if (versionStatus != null &&
//         versionStatus.storeVersion.trim() != currentVersion.trim()) {
//       // Patch ялгаатай байсан ч заавал update хийлгэнэ
//       _showForceUpdateDialog(context, versionStatus.appStoreLink);
//     }
//   }

//   static void _showForceUpdateDialog(BuildContext context, String appLink) {
//     showDialog(
//       context: context,
//       barrierDismissible: false, // хааж болохгүй
//       builder: (context) => AlertDialog(
//         title: const Text("Шинэ хувилбар заавал хэрэгтэй"),
//         content: const Text(
//             "Шинэ хувилбар гарсан тул update хийж байж үргэлжлүүлнэ."),
//         actions: [
//           TextButton(
//             onPressed: () {
//               NewVersionPlus.launchAppStore(appLink);
//             },
//             child: const Text("Update хийх"),
//           ),
//         ],
//       ),
//     );
//   }
// }
