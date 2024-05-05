import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../configBackend.dart';
import '../Module_3/home.dart';
import '../Module_4/Glucosa/RegistroGlucosa.dart';
import '../Module_4/Glucosa/modifyGlucose.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gráfico de Nivel de Glucosa'),
        ),
        body: GlucoseChartScreenLine(),
      ),
    );
  }
}

class GlucoseChartScreenLine extends StatefulWidget {
  @override
  _GlucoseChartScreenLineState createState() => _GlucoseChartScreenLineState();
}

class _GlucoseChartScreenLineState extends State<GlucoseChartScreenLine> {
  List<dynamic> readings = []; // Lista para almacenar los alimentos
  TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  final List<String> sectionTexts = ['Sección 1', 'Sección 2', 'Sección 3'];

  String selectedFID = '';

  @override
  void initState() {
    super.initState();
    getReadings();
  }

  Future<void> getReadings() async {
    try {
      final response = await http.get(
          Uri.parse(ApiConfig.backendUrl + '/api/Module4/GetGlucoseReadings'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          readings = jsonData;
        });
        print('Número de lecturas: ${readings.length}');
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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 233, 233),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3.0,
                  spreadRadius: 2.0,
                  offset: Offset(0, 0),
                ),
              ],
              color: Colors.white,
            ),
            padding:
                EdgeInsets.only(top: 50), // Iniciar desde la parte superior
            child: Column(
              children: [
                Image.asset(
                  'lib/assets/logoHeader.png',
                  width: 170,
                  height: 32,
                ),
                SizedBox(height: 8),
                Container(
                  width: 80,
                  height: 2,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          Expanded(
            child: PageView.builder(
              itemCount: sectionTexts.length,
              itemBuilder: (context, index) {
                //////////////////////////////////////////////////////line
                if (index == 0) {
                  // Contenido para la primera sección
                  return Scaffold(
                    body: Center(
                      child: LineChart(
                        LineChartData(
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  DateTime date = DateTime.parse(
                                    readings[value.toInt()]
                                        ['Registration_date'],
                                  );
                                  return Text(
                                    '${date.hour}',
                                    style: TextStyle(fontSize: 10),
                                  );
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: true),
                          gridData: FlGridData(show: true),
                          minX: 0,
                          maxX: readings.length.toDouble() -
                              1, // Usar la longitud de los datos
                          minY: 00,
                          maxY: 200, // Ajusta según tus necesidades
                          lineBarsData: [
                            LineChartBarData(
                              isCurved: true,
                              spots: generateData(),
                              belowBarData: BarAreaData(show: false),
                              dotData: FlDotData(show: false),
                              color: const Color.fromARGB(255, 243, 33, 33),
                              barWidth: 4, // Ajusta el tamaño de la línea
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                //////////////////////////////////////////////////////pie grafica
                if (index == 1) {
                } else {
                  // Contenido para las otras secciones
                  return Center(
                    child: Text(
                      sectionTexts[index],
                      style: TextStyle(fontSize: 24),
                    ),
                  );
                }
              },
            ),
          ),

          ////////////////////////////////////////////-> aqui

          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Alinea los botones en los extremos
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *
                        0.80, // 37% del ancho de la pantalla
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Acción para el botón con icono
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 48, 48, 48),
                        padding: EdgeInsets.all(13.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      icon: Icon(
                        // Aquí especifica el icono que deseas mostrar
                        Icons
                            .home, // Puedes cambiar esto al icono que prefieras
                        size: 25, // Tamaño del icono
                      ),
                      label: Text(
                        '',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  List<FlSpot> generateData() {
    final List<FlSpot> data = readings.asMap().entries.map((entry) {
      final index = entry.key;
      final reading = entry.value;

      return FlSpot(
        index.toDouble(),
        reading['Glucose_level'].toDouble(),
      );
    }).toList();

    return data;
  }
}
////////////////// graficas
///
