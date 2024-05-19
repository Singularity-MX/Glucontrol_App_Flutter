import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../configBackend.dart';
import 'package:flutter/material.dart';
import 'package:Glucontrol/views/Module_4/Glucosa/modifyGlucose.dart';
import 'package:Glucontrol/views/Module_3/home.dart';

import 'RegistroGlucosa.dart';

import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GlucosaScreen(),
    );
  }
}

class GlucosaScreen extends StatefulWidget {
  @override
  _GlucosaScreenState createState() => _GlucosaScreenState();
}

class _GlucosaScreenState extends State<GlucosaScreen> {
  List<dynamic> readings = []; // Lista para almacenar los alimentos

  TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    // Llamar a la función para obtener alimentos cuando se carga la pantalla
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

  Future<void> eliminarLectura(String RID) async {
    try {
      // Construye la URL con el FID como parámetro
      final url = Uri.parse(
          '${ApiConfig.backendUrl}/api/Module4/DeleteGlucoseReading/$RID');

      // Realiza una solicitud al servidor para eliminar el alimento
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        // Si la eliminación se realiza correctamente, puedes actualizar la lista de alimentos
        getReadings();
      } else {
        // Maneja errores si la eliminación no fue exitosa
        print('Error al eliminar el alimento: ${response.statusCode}');
      }
    } catch (error) {
      // Maneja errores en la solicitud
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
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                ),
              ],
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.asset(
                    'lib/assets/ICONS_CARD/glucosaIcon.png',
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Visor de registros',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF323232),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '¡No olvides tener un chequeo continuo!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF141010),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          /////////////////////////////////////////////////-> TXT BUSCAR
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              controller: _searchController,
              onChanged: (text) {
                setState(() {
                  _searchText = text;
                });
              }, // Asignar el controlador
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF575757),
                letterSpacing: 0.5,
              ),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                hintText: 'Buscar categoría...',
                hintStyle: TextStyle(
                  color: Color(0xFF575757),
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color(0xFFFF3B3B),
                  ),
                ),
                prefixIcon: Icon(
                  Icons.search_sharp,
                  color: Color(0xFF777777),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: readings.length,
              itemBuilder: (context, index) {
                final reversedIndex = readings.length - 1 - index;
                final glucoseData = readings[reversedIndex];

                // Filtra los alimentos que coinciden con la cadena de búsqueda
                if (_searchText.isNotEmpty &&
                    (glucoseData['Category'] == null ||
                        !glucoseData['Category']
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()))) {
                  return Container(); // Oculta el elemento si no coincide
                }

                return ListTile(
                  title: Text(glucoseData['Glucose_level'].toString() +
                          ' mg/dL' +
                          ' (' +
                          glucoseData['Category'] +
                          ')' ??
                      'Sin nombre'),
                  subtitle: Text(
                    glucoseData['Registration_date'] != null
                        ? DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                glucoseData['Registration_date'])) +
                            ' -> ' +
                            glucoseData['Hour']
                        : 'Sin clasificación',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.visibility), // Icono para "Ver"
                        onPressed: () {
                          // Acción para ver el alimento
                          // Puedes navegar a una pantalla de detalle aquí.
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Detalles de lectura'),
                                content: Text(
                                  'Fecha: ' +
                                      glucoseData['Registration_date']
                                          .toString() +
                                      '\n' +
                                      'Hora: ' +
                                      glucoseData['Hour'].toString() +
                                      '\n' +
                                      'Lectura: ' +
                                      glucoseData['Glucose_level'].toString() +
                                      ' mg/dL' +
                                      '\n' +
                                      'Categoria: ' +
                                      glucoseData['Category'] +
                                      '\n' +
                                      'Comida: ' +
                                      glucoseData['FID'] +
                                      ' ' +
                                      glucoseData['Cantidad'].toString() +
                                      ' gramos' +
                                      '\n' +
                                      'Actividad: ' +
                                      glucoseData['AID'] +
                                      ' ' +
                                      glucoseData['Duration'].toString() +
                                      ' minutos',
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: Text('Aceptar'),
                                    onPressed: () {
                                      // Aquí debes eliminar el alimento utilizando el FID
                                      Navigator.of(context)
                                          .pop(); // Cerrar el cuadro de diálogo
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit), // Icono para "Editar"
                        onPressed: () {
                          // Acción para editar el alimento
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ModifyGlucose(food: glucoseData),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete), // Icono para "Eliminar"
                        onPressed: () {
                          // Mostrar un cuadro de diálogo de confirmación
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Eliminar registro'),
                                content: Text(
                                  '¿Estás seguro de que deseas eliminar este registro?',
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Cerrar el cuadro de diálogo
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text('Eliminar'),
                                    onPressed: () {
                                      // Aquí debes eliminar el alimento utilizando el FID
                                      final aid = glucoseData[
                                          'RID']; // Obtener el FID del alimento
                                      eliminarLectura(
                                          aid); // Llama a la función para eliminar el alimento
                                      Navigator.of(context)
                                          .pop(); // Cerrar el cuadro de diálogo
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 20),
          /////////////////////////////////////////////////-> buttons

          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Alinea los botones en los extremos
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *
                        0.37, // 37% del ancho de la pantalla
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Acción para el botón con icono
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        padding: EdgeInsets.all(13.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      icon: Icon(
                        // Aquí especifica el icono que deseas mostrar
                        Icons
                            .home, // Puedes cambiar esto al icono que prefieras
                        size: 25,
                        color: Color.fromARGB(255, 97, 199, 190),// Tamaño del icono
                      ),
                      label: Text(
                        '',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width *
                        0.37, // 37% del ancho de la pantalla
                    child: ElevatedButton(
                      onPressed: () {
                        // Acción para el segundo botón
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistroGlucosaScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 97, 199, 190),
                        padding: EdgeInsets.all(13.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Icon(
                        Icons.add, // Icono de un signo de suma
                        size: 25, // Tamaño del icono
                        color: Colors.white, // Color del icono
                      ),
                    ),
                  )
                ],
              )),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
