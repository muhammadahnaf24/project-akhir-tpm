import 'package:project_akhir_tpm/models/konversi_uang_model.dart';

class CurrencyConversionController {
  double convertCurrency({
    required Currency fromCurrency,
    required Currency toCurrency,
    required double amount,
  }) {
    CurrencyConversionModel conversionModel = CurrencyConversionModel(
      fromCurrency: fromCurrency,
      toCurrency: toCurrency,
      amount: amount,
    );
    return conversionModel.convert();
  }
}
