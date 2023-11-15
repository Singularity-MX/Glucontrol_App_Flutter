import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;

import '../../configBackend.dart';

class BarChartSample extends StatefulWidget {
  @override
  _BarChartSampleState createState() => _BarChartSampleState();
}

class _BarChartSampleState extends State<BarChartSample> {
  List<OrdinalSales> activities = [];
  String selectedActivity = '';
  int selectedActivityCount = 0;

  @override
  void initState() {
    super.initState();
    getActivities();
  }

  Future<void> getActivities() async {
    try {
      final response = await http.get(
          Uri.parse(ApiConfig.backendUrl + '/api/Module4/GetMostRegisteredAID'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<OrdinalSales> newActivities = [];
        for (var item in jsonData) {
          newActivities.add(OrdinalSales(item['AID'], int.parse(item['Numero_Registros'])));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actividades Registradas'),
      ),
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
                       charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tap),

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
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Actividad: $selectedActivity\nRegistros: $selectedActivityCount'),
                    ),
                ],
              ),
      ),
    );
  }

  List<charts.Series<OrdinalSales, String>> _createSampleData() {
    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
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
