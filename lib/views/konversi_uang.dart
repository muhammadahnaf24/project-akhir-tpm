import 'package:flutter/material.dart';
import 'package:project_akhir_tpm/controllers/konversi_uang_controller.dart';
import 'package:project_akhir_tpm/models/konversi_uang_model.dart';

class CurrencyConversionView extends StatefulWidget {
  @override
  _CurrencyConversionViewState createState() => _CurrencyConversionViewState();
}

class _CurrencyConversionViewState extends State<CurrencyConversionView> {
  final TextEditingController _amountController = TextEditingController();
  Currency _fromCurrency = Currency.IDR;
  Currency _toCurrency = Currency.USD;
  String _result = '';
  final CurrencyConversionController _controller = CurrencyConversionController();

  void _convertCurrency() {
    double? amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      setState(() {
        _result = 'Invalid amount. Please enter a positive number.';
      });
      return;
    }

    try {
      double convertedAmount = _controller.convertCurrency(
        fromCurrency: _fromCurrency,
        toCurrency: _toCurrency,
        amount: amount,
      );
      setState(() {
        _result = 'Converted Amount: ${convertedAmount.toStringAsFixed(2)} ${_toCurrency.toString().split('.').last}';
      });
    } catch (e) {
      setState(() {
        _result = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Currency Conversion',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal[800],
        elevation: 0, // remove shadow
        centerTitle: true,
        actions: [
          Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<Currency>(
              value: _fromCurrency,
              onChanged: (Currency? newValue) {
                setState(() {
                  _fromCurrency = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'From Currency',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
              items: Currency.values.map((Currency currency) {
                return DropdownMenuItem<Currency>(
                  value: currency,
                  child: Text(currency.toString().split('.').last),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<Currency>(
              value: _toCurrency,
              onChanged: (Currency? newValue) {
                setState(() {
                  _toCurrency = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'To Currency',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
              items: Currency.values.map((Currency currency) {
                return DropdownMenuItem<Currency>(
                  value: currency,
                  child: Text(currency.toString().split('.').last),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: Text('Convert'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            SizedBox(height: 16),
            Card(
              color: Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _result,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
