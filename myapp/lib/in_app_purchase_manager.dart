import 'package:flutter/foundation.dart';

/// [InAppPurchaseManager] is a class to manage in app purchases.
class InAppPurchaseManager {
  /// [purchase] is a method to purchase a product.
  ///
  /// [productId] is the id of the product to purchase.
  void purchase(String productId) {
    /// Debug mode check.
    if (kDebugMode) {
      /// Print the message indicating that a product is being purchased.
      print('Purchasing product: $productId');
    }
  }
}