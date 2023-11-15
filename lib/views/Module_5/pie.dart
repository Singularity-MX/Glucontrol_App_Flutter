import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

import '../../configBackend.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gráfico de Pie'),
        ),
        body: PieChartScreen(),
      ),
    );
  }
}

class PieChartScreen extends StatefulWidget {
  @override
  _PieChartScreenState createState() => _PieChartScreenState();
}

class _PieChartScreenState extends State<PieChartScreen> {
  List<dynamic> foods = [];

  @override
  void initState() {
    super.initState();
    getFoods();
  }

  Future<void> getFoods() async {
    try {
      final response = await http.get(
          Uri.parse(ApiConfig.backendUrl + '/api/Module4/GetMostRegisteredFID'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          foods = jsonData;
        });
        print('Número de lecturas: ${foods.length}');
      } else {
        // Manejar errores si la solicitud no fue exitosa
        print('Error al obtener alimentos: ${response.statusCode}');
      }
    } catch (error) {
      // Manejar errores en la solicitud
      print('Error en la solicitud: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PieChart(
        PieChartData(
          sections: buildPieChartSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> buildPieChartSections() {
    List<PieChartSectionData> sections = [];
    for (var food in foods) {
      sections.add(
        PieChartSectionData(
          color: getRandomColor(),
          value: double.parse(food['Numero_Registros'].toString()),
          title: food['FID'].toString(),
          radius: 50,
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    }
    return sections;
  }

  Color getRandomColor() {
    List<Color> colors = [Colors.blue, Colors.green, Colors.orange, Colors.red];
    return colors[Random().nextInt(colors.length)];
  }
}
