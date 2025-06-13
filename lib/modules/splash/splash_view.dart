// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../app/routes/app_pages.dart';
// import '../../shared/widgets/bstore_logo.dart';

// class SplashView extends StatefulWidget {
//   const SplashView({super.key});

//   @override
//   State<SplashView> createState() => _SplashViewState();
// }

// class _SplashViewState extends State<SplashView> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 2), () {
//       Get.offAllNamed(AppRoutes.login); // ✅ ไปหน้า Login
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: BStoreLogo(size: LogoSize.lg),
//       ),
//     );
//   }
// }

import 'package:cms_inv_mobile/shared/widgets/bstore_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashViewModel>();

    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BStoreLogo(size: LogoSize.lg),
      ),
    );
  }
}
