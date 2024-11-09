/*
 *


 *
 * /
 */

import 'package:floor/floor.dart';
import '../entities/recent_product.dart';

@dao
abstract class RecentProductDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRecentProduct(RecentProduct product);

  // @Query("SELECT * FROM RecentProduct LIMIT 5 ")
  @Query("SELECT * FROM RecentProduct")
  Future<List<RecentProduct>> getProducts();

  @Query("DELETE FROM RecentProduct")
  Future<void> deleteRecentProducts();
}
