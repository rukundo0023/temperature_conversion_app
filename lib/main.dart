import 'package:flutter/material.dart';

void main() {
  runApp(TempConverterApp());
}

class TempConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _tempController = TextEditingController();
  String _conversionType = 'F to C';
  double _convertedTemp = 0.0;
  List<String> _conversionHistory = [];

  void _convertTemperature() {
    double inputTemp = double.tryParse(_tempController.text) ?? 0.0;
    double result;

    if (_conversionType == 'F to C') {
      result = (inputTemp - 32) * 5 / 9;
    } else {
      result = inputTemp * 9 / 5 + 32;
    }

    setState(() {
      _convertedTemp = result;
      _conversionHistory.insert(0,
          '$_conversionType: ${inputTemp.toStringAsFixed(1)} => ${result.toStringAsFixed(1)}');
    });
  }

  void _clearHistory() {
    setState(() {
      _conversionHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.blue.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tempController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Choose the conversion type',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            SizedBox(height: 8.0),
            DropdownButton<String>(
              value: _conversionType,
              icon: Icon(Icons.arrow_downward, color: Colors.white),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _conversionType = newValue!;
                });
              },
              items: <String>['F to C', 'C to F']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _convertTemperature,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text('Convert'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Converted Temperature: ${_convertedTemp.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Conversion History',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: _clearHistory,
                  child: Text(
                    'Clear History',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: TextButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: _conversionHistory.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        title: Text(_conversionHistory[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
