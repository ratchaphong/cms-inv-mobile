import 'package:cms_inv_mobile/models/entities/product_model.dart';
import 'package:cms_inv_mobile/models/requests/product_request.dart';
import 'package:cms_inv_mobile/services/products_service.dart';
import 'package:cms_inv_mobile/shared/enums/product_status.dart';
import 'package:get/get.dart';

class ProductsViewModel extends GetxController {
  final products = <ProductModel>[].obs;
  final isLoading = false.obs;

  final _service = ProductsService();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    try {
      final result = await _service.fetchProducts();
      products.assignAll(result);
    } catch (_) {
      Get.snackbar("ผิดพลาด", "โหลดรายการสินค้าไม่สำเร็จ");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addProduct(String name, String category, int stock) async {
    final newProduct = ProductRequest(
      name: name,
      category: category,
      initialStock: stock,
      status: stock == 0 ? ProductStatus.outOfStock : ProductStatus.available,
    );

    try {
      final created = await _service.addProduct(newProduct);
      products.add(created);
      Get.snackbar("สำเร็จ", "เพิ่มสินค้าเรียบร้อยแล้ว");
    } catch (_) {
      Get.snackbar("ผิดพลาด", "ไม่สามารถเพิ่มสินค้าได้");
    }
  }
}
