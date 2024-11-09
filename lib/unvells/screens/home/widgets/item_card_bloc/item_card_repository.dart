/*
 *


 *
 * /
 */

import 'package:test_new/unvells/models/base_model.dart';

import '../../../../models/homePage/add_to_wishlist_response.dart';
import '../../../../models/productDetail/add_to_cart_response.dart';
import '../../../../network_manager/api_client.dart';

abstract class ItemCardRepository {
  Future<AddToWishlistResponse?> addToWishList(String productId);

  Future<BaseModel?> removeFromWishList(String productId);

  Future<AddToCartResponse?> addToCart(
      String productId, int qty, Map<String, dynamic> productParamsJSON);
}

class ItemCardRepositoryImp extends ItemCardRepository {
  /// ****AddToWishList**/
  @override
  Future<AddToWishlistResponse?> addToWishList(String productId) async {
    var wishlistAllAllCartData = await ApiClient().addToWishlist(productId);
    return wishlistAllAllCartData!;
  }

  /// ****RemoveFromWishList**/
  @override
  Future<BaseModel?> removeFromWishList(String productId) async {
    var responseData = await ApiClient().removeFromWishlist(productId);
    return responseData!;
  }

  /// ****Add to Cart**/
  @override
  Future<AddToCartResponse?> addToCart(
      String productId, int qty, Map<String, dynamic> productParamsJSON) async {
    var responseData =
        await ApiClient().addToCart(productId, qty, productParamsJSON, []);
    return responseData!;
  }
}
