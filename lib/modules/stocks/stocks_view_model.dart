import 'package:cms_inv_mobile/models/entities/product_model.dart';
import 'package:cms_inv_mobile/models/entities/stock_item_model.dart';
import 'package:cms_inv_mobile/models/requests/stock_item_request.dart';
import 'package:cms_inv_mobile/services/products_service.dart';
import 'package:cms_inv_mobile/services/stocks_service.dart';
import 'package:cms_inv_mobile/shared/enums/stock_action.dart';
import 'package:get/get.dart';

class StocksViewModel extends GetxController {
  final _stocksService = Get.find<StocksService>();
  final _productsService = Get.find<ProductsService>();

  var stockItems = <StockItemModel>[].obs;
  var products = <ProductModel>[].obs;
  var isLoading = false.obs;
  var showAddForm = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    try {
      final fetchedStocks = await _stocksService.fetchStockItems();
      final fetchedProducts = await _productsService.fetchProducts();
      stockItems.assignAll(fetchedStocks);
      products.assignAll(fetchedProducts);
    } catch (e) {
      Get.snackbar('Error', 'ไม่สามารถโหลดข้อมูลได้');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addStock({
    required int productId,
    required StockAction action,
    required int quantity,
    String? note,
  }) async {
    try {
      final stockItemReq = StockItemRequest(
        productId: productId,
        type: action,
        quantity: quantity,
        note: note,
      );

      final item = await _stocksService.addStockItem(stockItemReq);
      stockItems.insert(0, item);
      toggleAddForm();
      Get.snackbar('สำเร็จ', 'เพิ่มการเคลื่อนไหวสต็อกเรียบร้อย');
    } catch (e) {
      Get.snackbar('ผิดพลาด', 'ไม่สามารถเพิ่มได้');
    }
  }

  void toggleAddForm() => showAddForm.value = !showAddForm.value;
}
