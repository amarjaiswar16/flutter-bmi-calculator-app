import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'Bmi app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        //primarySwatch: Colors.orange,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        
      ),
      home: const DashBoard(),
    );
  }
}

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() {
    return _DashBoardState();
  }
}

class _DashBoardState extends State<DashBoard> {
  final TextEditingController _wtController = TextEditingController();
  final TextEditingController _htController = TextEditingController();
  final TextEditingController _inController = TextEditingController();

  var msg = '';
  var result = '';
  var bgColor = Colors.orange.shade200;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        actions: [
          IconButton(
              onPressed: clearResult,
              icon: const Icon(
                Icons.refresh,
                size: 28,
              )),
        ],
      ),
      body: Container(
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'BMI',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _wtController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: const Text('Enter your weight in kgs'),
                      prefixIcon: const Icon(Icons.line_weight),
                      prefixIconColor: Colors.blue,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  TextField(
                    controller: _htController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: const Text('Enter your height in (in feet)'),
                      prefixIcon: const Icon(Icons.height),
                      prefixIconColor: Colors.blue,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  TextField(
                    controller: _inController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: const Text('Enter your height(in inch)'),
                      prefixIcon: const Icon(Icons.height),
                      prefixIconColor: Colors.blueAccent,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: bmiCalculation,
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Calculate'),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    result,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void bmiCalculation() {
    var wt = _wtController.text.toString();
    var ht = _htController.text.toString();
    var inch = _inController.text.toString();

    if (wt != '' && ht != '' && inch != '') {
      var iwt = int.parse(wt);
      var iht = int.parse(ht);
      var iInch = int.parse(inch);

      var tInch = (iht * 12) + iInch;

      var tcm = tInch * 2.54;
      var tmt = tcm / 100;

      var bmi = iwt / (tmt * tmt);

      if (bmi < 1) {
        msg = 'Please check the values';
        bgColor = Colors.redAccent;
      } else if (bmi < 18.5) {
        msg = "Underweight";
        bgColor = Colors.red.shade200;
      } else if (bmi <= 24.5) {
        msg = "Healthy";
        bgColor = Colors.green.shade200;
      } else if (bmi <= 29.9) {
        msg = "Overweight";
        bgColor = Colors.green.shade200;
      } else if (bmi <= 34.9) {
        msg = 'Obesity Class I';
        bgColor = Colors.yellow.shade200;
      } else if (bmi <= 39.9) {
        msg = 'Obesity Class II';
        bgColor = Colors.yellow.shade200;
      } else {
        msg = 'Obesity Class III';
        bgColor = Colors.yellow.shade200;
      }

      setState(() {
        result = '$msg \nYour BMI is ${bmi.toStringAsFixed(2)}';
      });
    } else {
      setState(() {
        result = 'Please fill all the required fields!';
      });
    }
  }

  void clearResult() {
    setState(() {
      msg = '';
      result = '';
      bgColor = Colors.orange.shade200;
      _wtController.clear();
      _htController.clear();
      _inController.clear();
    });
  }
}
