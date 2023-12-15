import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:roqqu_test_app/src/common/common.dart';

Future<CryptoAssetsData> readJson(String name) async {
  final String response = await rootBundle.loadString('assets/data/$name');
  final result = CryptoAssetsData.fromJson(json.decode(response));
  return result;
}
