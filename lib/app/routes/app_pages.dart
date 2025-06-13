import 'package:cms_inv_mobile/app/middlewares/auth_middleware.dart';
import 'package:cms_inv_mobile/modules/dashboard/dashboard_binding.dart';
import 'package:cms_inv_mobile/modules/dashboard/dashboard_view.dart';
import 'package:cms_inv_mobile/modules/edit_profile/edit_profile_binding.dart';
import 'package:cms_inv_mobile/modules/edit_profile/edit_profile_view.dart';
import 'package:cms_inv_mobile/modules/login/login_binding.dart';
import 'package:cms_inv_mobile/modules/login/login_view.dart';
import 'package:cms_inv_mobile/modules/products/products_binding.dart';
import 'package:cms_inv_mobile/modules/products/products_view.dart';
import 'package:cms_inv_mobile/modules/profile/profile_binding.dart';
import 'package:cms_inv_mobile/modules/profile/profile_view.dart';
import 'package:cms_inv_mobile/modules/splash/splash_binding.dart';
import 'package:cms_inv_mobile/modules/splash/splash_view.dart';
import 'package:cms_inv_mobile/modules/stocks/stocks_binding.dart';
import 'package:cms_inv_mobile/modules/stocks/stocks_view.dart';
import 'package:cms_inv_mobile/modules/stocks_report/stocks_report_binding.dart';
import 'package:cms_inv_mobile/modules/stocks_report/stocks_report_view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const profile = '/profile';
  static const editProfile = '/edit-profile';
  static const products = '/products';
  static const stocks = '/stocks';
  static const report = '/report';
}

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    // ✅ Splash ไม่มี middleware
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),

    // ✅ Dashboard ใส่ middleware
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.products,
      page: () => const ProductsView(),
      binding: ProductsBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.stocks,
      page: () => const StocksView(),
      binding: StocksBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.report,
      page: () => const StocksReportView(),
      binding: StocksReportBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
