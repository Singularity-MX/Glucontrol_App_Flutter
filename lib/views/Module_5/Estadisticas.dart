import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../configBackend.dart';
import '../Module_3/home.dart';
import '../Module_4/Glucosa/RegistroGlucosa.dart';
import '../Module_4/Glucosa/modifyGlucose.dart';
import 'bar.dart';

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

  List<OrdinalSales> activities = [];
  String selectedActivity = '';
  int selectedActivityCount = 0;

  List<dynamic> foods = [];

  @override
  void initState() {
    super.initState();
    getReadings();
    getActivities();
    getFoods();
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

  Future<void> getActivities() async {
    try {
      final response = await http.get(Uri.parse(
          ApiConfig.backendUrl + '/api/Module4/GetMostRegisteredAID'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<OrdinalSales> newActivities = [];
        for (var item in jsonData) {
          newActivities.add(
              OrdinalSales(item['AID'], int.parse(item['Numero_Registros'])));
        }
        setState(() {
          activities = newActivities;
        });
        print('Número de lecturas: ${activities.length}');
      } else {
        // Manejar errores si la solicitud no fue exitosa
        print('Error al obtener actividades: ${response.statusCode}');
      }
    } catch (error) {
      // Manejar errores en la solicitud
      print('Error en la solicitud: $error');
    }
  }

  Future<void> getFoods() async {
    try {
      final response = await http.get(Uri.parse(
          ApiConfig.backendUrl + '/api/Module4/GetMostRegisteredFID'));
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
                //////////////////////////////////////////////////////line grafica
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
                          lineTouchData: LineTouchData(
                            touchTooltipData: LineTouchTooltipData(
                              tooltipBgColor: Colors.blueAccent,
                              getTooltipItems:
                                  (List<LineBarSpot> touchedSpots) {
                                return touchedSpots
                                    .map((LineBarSpot touchedSpot) {
                                  final int index =
                                      touchedSpot.barIndex.toInt();
                                  final FlSpot dataPoint =
                                      generateData()[index];

                                  return LineTooltipItem(
                                    'Glucosa: ${readings[index]['Glucose_level']} \nAlimento: ${readings[index]['FID']}  ${readings[index]['Cantidad']}grs. \nActividad: ${readings[index]['AID']} ${readings[index]['Duration']}min.',
                                    TextStyle(color: Colors.white),
                                  );
                                }).toList();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }

                //////////////////////////////////////////////////////bar grafica
                if (index == 1) {
                  return Scaffold(
                    body: Center(
                      child: activities.isEmpty
                          ? CircularProgressIndicator()
                          : Column(
                              children: [
                                Expanded(
                                  child: charts.BarChart(
                                    _createSampleData(),
                                    animate: true,
                                    behaviors: [
                                      charts.SelectNearest(
                                          eventTrigger:
                                              charts.SelectionTrigger.tap),
                                      charts.DomainHighlighter(),
                                    ],
                                    selectionModels: [
                                      charts.SelectionModelConfig(
                                        type: charts.SelectionModelType.info,
                                        changedListener: _onSelectionChanged,
                                      ),
                                    ],
                                  ),
                                ),
                                if (selectedActivity.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Text(
                                        'Actividad: $selectedActivity\nRegistros: $selectedActivityCount'),
                                  ),
                              ],
                            ),
                    ),
                  );
                }
                //////////////////////////////////////////////////////pie grafica
                if (index == 2) {
return Center(
  child: PieChart(
    PieChartData(
      centerSpaceRadius: 100, // Ajusta este valor según tus necesidades
      sections: buildPieChartSections(),
    ),
  ),
);

                } 
                else {
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
                        primary: Color.fromARGB(255, 48, 48, 48),
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

  /// config line
  List<FlSpot> generateData() {
    readings.sort((a, b) {
      DateTime timeA = DateTime.parse(a['Registration_date']);
      DateTime timeB = DateTime.parse(b['Registration_date']);
      return timeA.compareTo(timeB);
    });

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

//pie chart
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
    List<Color> colors = [const Color.fromARGB(255, 71, 149, 212), Color.fromARGB(255, 245, 76, 76), const Color.fromARGB(255, 231, 167, 70), Color.fromARGB(255, 48, 48, 48)];
    return colors[Random().nextInt(colors.length)];
  }


//bar config

  List<charts.Series<OrdinalSales, String>> _createSampleData() {
    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
            Color.fromARGB(255, 233, 60, 60)), // Cambia el color aquí
        domainFn: (OrdinalSales sales, _) => sales.nombre,
        measureFn: (OrdinalSales sales, _) => sales.cantidad,
        data: activities,
      )
    ];
  }

  void _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    if (selectedDatum.isNotEmpty) {
      setState(() {
        selectedActivity = selectedDatum.first.datum.nombre;
        selectedActivityCount = selectedDatum.first.datum.cantidad;
      });
    }
  }
}

class OrdinalSales {
  final String nombre;
  final int cantidad;

  OrdinalSales(this.nombre, this.cantidad);
}


////////////////// graficas
///
