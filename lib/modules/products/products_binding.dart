import 'package:cms_inv_mobile/services/products_service.dart';
import 'package:get/get.dart';
import 'products_view_model.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsService());
    Get.lazyPut(() => ProductsViewModel());
  }
}
