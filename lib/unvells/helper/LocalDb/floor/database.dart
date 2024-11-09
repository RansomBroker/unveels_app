/*
 *


 *
 * /
 */

import 'dart:async';

import 'package:floor/floor.dart';
import 'package:test_new/unvells/helper/LocalDb/floor/dao/recent_product_dao.dart';
import 'package:test_new/unvells/helper/LocalDb/floor/entities/recent_product.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [RecentProduct])
abstract class AppDatabase extends FloorDatabase {
  RecentProductDao get recentProductDao;

  static AppDatabase? _database;

  static Future<AppDatabase> getDatabase() async {
    _database ??= await $FloorAppDatabase
        .databaseBuilder("magento2_database.db")
        .build();
    return _database!;
  }
}
