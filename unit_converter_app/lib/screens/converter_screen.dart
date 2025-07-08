import 'package:flutter/material.dart';
import '../models/unit_model.dart';

class ConverterScreen extends StatefulWidget {
  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  int _categoryIndex = 0;
  int _fromIndex = 0;
  int _toIndex = 1;
  double _input = 0;
  String _result = '';
  final _inputController = TextEditingController();

  void _convert() {
    final category = allCategories[_categoryIndex];
    final fromUnit = category.units[_fromIndex];
    final toUnit = category.units[_toIndex];
    double? value = double.tryParse(_inputController.text);
    if (value == null) {
      setState(() => _result = 'Input tidak valid');
      return;
    }
    final base = fromUnit.toBase(value);
    final converted = toUnit.fromBase(base);
    setState(() => _result = converted.toStringAsFixed(4));
  }

  @override
  void initState() {
    super.initState();
    _inputController.text = '0';
  }

  @override
  Widget build(BuildContext context) {
    final category = allCategories[_categoryIndex];
    return Scaffold(
      appBar: AppBar(title: const Text('Unit Converter')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<int>(
              value: _categoryIndex,
              isExpanded: true,
              items: List.generate(
                allCategories.length,
                (i) => DropdownMenuItem(
                  value: i,
                  child: Text(allCategories[i].name),
                ),
              ),
              onChanged: (i) {
                setState(() {
                  _categoryIndex = i!;
                  _fromIndex = 0;
                  _toIndex = 1;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<int>(
                    value: _fromIndex,
                    isExpanded: true,
                    items: List.generate(
                      category.units.length,
                      (i) => DropdownMenuItem(
                        value: i,
                        child: Text(category.units[i].name),
                      ),
                    ),
                    onChanged: (i) => setState(() => _fromIndex = i!),
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.arrow_forward),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<int>(
                    value: _toIndex,
                    isExpanded: true,
                    items: List.generate(
                      category.units.length,
                      (i) => DropdownMenuItem(
                        value: i,
                        child: Text(category.units[i].name),
                      ),
                    ),
                    onChanged: (i) => setState(() => _toIndex = i!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nilai yang akan dikonversi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Konversi'),
            ),
            const SizedBox(height: 24),
            Text(
              _result.isEmpty ? 'Hasil akan muncul di sini' : 'Hasil: $_result',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
} 