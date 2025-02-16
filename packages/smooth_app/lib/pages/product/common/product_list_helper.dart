import 'dart:async';
import 'dart:io';

import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:smooth_app/data_models/product_list.dart';
import 'package:smooth_app/database/dao_product.dart';
import 'package:smooth_app/database/dao_product_list.dart';
import 'package:smooth_app/database/local_database.dart';
import 'package:smooth_app/pages/product/common/product_refresher.dart';

// ignore: avoid_classes_with_only_static_members
class ProductListHelper {
  static const String EXPORT_SEPARATOR = ';';

  static Future<String> exportList(
    ProductList list,
    LocalDatabase localDatabase,
  ) async {
    final StringBuffer csv = StringBuffer();

    void addLine(String barcode, String name, String brand) {
      csv.writeln(
        '$barcode'
        '$EXPORT_SEPARATOR'
        '$name'
        '$EXPORT_SEPARATOR'
        '$brand',
      );
    }

    addLine('Barcode', 'Name', 'Brand');

    for (final String barcode in list.barcodes) {
      if (barcode.length != 8 ||
          barcode.length != 13 ||
          int.tryParse(barcode) == null) {
        continue;
      }

      final Product? product = await DaoProduct(localDatabase).get(barcode);
      if (product != null) {
        final String name =
            (product.productName ?? '').replaceAll(EXPORT_SEPARATOR, '');
        final String brand =
            (product.brands ?? '').replaceAll(EXPORT_SEPARATOR, '');
        addLine(barcode, name, brand);
      }
    }

    return csv.toString();
  }

  static Future<void> importList(
      File file, ProductList list, LocalDatabase localDatabase) async {
    final String content = file.readAsStringSync();

    final List<String> lines = content.split('\n');
    final List<String> barcodes = <String>[];

    for (final String line in lines) {
      final List<String> parts = line.split(EXPORT_SEPARATOR);
      if (parts.length < 3) {
        continue;
      }
      final String barcode = parts[0].replaceAll('"', '');
      barcodes.add(barcode);
    }

    // TODOhow should we handle different product types?
    final List<String> existingBarcodes =
        await ProductRefresher().silentFetchAndRefreshListWithFeedback(
              barcodes: barcodes,
              localDatabase: localDatabase,
              productType: ProductType.food,
            ) ??
            <String>[];

    await DaoProductList(localDatabase).bulkSet(
      list,
      existingBarcodes,
      include: true,
    );
  }
}
