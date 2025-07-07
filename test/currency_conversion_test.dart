// test/currency_conversion_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker_app/features/expenses/data/data_sources/currenct_api_service.dart';

void main() {
  test('Should fetch USD to EGP rate from API', () async {
    final api = CurrencyApiServiceImpl();
    final rate = await api.fetchRate('USD', 'EGP');
    expect(rate, greaterThan(0));
  });
}
