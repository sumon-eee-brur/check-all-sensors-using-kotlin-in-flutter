import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const platform = MethodChannel('com.example.sensorlist');

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _sensorList = 'Fetching sensor list...';

  @override
  void initState() {
    super.initState();
    _getSensorList();
  }

  Future<void> _getSensorList() async {
    try {
      final List<dynamic> result = await MyApp.platform.invokeMethod('getSensorList');
      setState(() {
        _sensorList = result.join(', ');
      });

      print(_sensorList);
    } on PlatformException catch (e) {
      setState(() {
        _sensorList = "Failed to get sensor list: '${e.message}'.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor List'),
      ),
      body: Center(
        child: Text(_sensorList),
      ),
    );
  }
}