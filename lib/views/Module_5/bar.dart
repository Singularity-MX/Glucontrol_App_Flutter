import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChartSample extends StatelessWidget {
  final List<charts.Series<OrdinalSales, String>> seriesList = _createSampleData();

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      OrdinalSales('Ejemplo1', 2),
      OrdinalSales('Ejemplo2', 5),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.nombre,
        measureFn: (OrdinalSales sales, _) => sales.cantidad,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}

class OrdinalSales {
  final String nombre;
  final int cantidad;

  OrdinalSales(this.nombre, this.cantidad);
}
