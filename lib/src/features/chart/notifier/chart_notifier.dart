import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roqqu_test_app/src/common/common.dart';
import 'package:roqqu_test_app/src/common/model/chart_model.dart';

final chartNotifier = ChangeNotifierProvider((ref) => ChartNotifier());

class ChartNotifier extends ChangeNotifier {
  late CryptoAssetsData _assetData = CryptoAssetsData();

  CryptoAssetsData get assetData => _assetData;

  getData() async {
    final data = await readJson('24_hour_interval.json');
    _assetData = data;
    notifyListeners();
  }
}
