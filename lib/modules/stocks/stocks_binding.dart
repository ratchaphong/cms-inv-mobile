import 'package:cms_inv_mobile/services/products_service.dart';
import 'package:cms_inv_mobile/services/stocks_service.dart';
import 'package:get/get.dart';
import 'stocks_view_model.dart';

class StocksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StocksService());
    Get.lazyPut(() => ProductsService());
    Get.lazyPut(() => StocksViewModel());
  }
}
