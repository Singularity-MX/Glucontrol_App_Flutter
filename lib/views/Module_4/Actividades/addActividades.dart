import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // Importa la librería intl para dar formato a la fecha
import 'package:Glucontrol/models/Module1/RegistroModel.dart';
import 'package:Glucontrol/controllers/Module4/ActivitiesController.dart';
import 'package:Glucontrol/views/Module_2/login.dart';
import 'package:http/http.dart' as http;
import '../../../configBackend.dart';
import 'package:Glucontrol/views/Module_4/Actividades/ActivitiesScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AgregarActividadScreen(),
    );
  }
}

class AgregarActividadScreen extends StatefulWidget {
  @override
  _AgregarActividadScreenState createState() => _AgregarActividadScreenState();
}

class _AgregarActividadScreenState extends State<AgregarActividadScreen> {
  TextEditingController nombrePlatilloController = TextEditingController();
  String? classification; // Cambiado a String?

  List<String> clasificaciones = [
    "Trabajo",
    "Ejercicio",
    "Deporte",
    "Reposo",
    "Tareas del Hogar",
    "Conducción",
    "Estudio",
    "Actividades al Aire Libre",
    "Actividades Sociales"
  ];
  String? selectedClasificacion = "Ejercicio";
  String datos = "ad";
  late ActivitiesController controlador;

  @override
  void initState() {
    super.initState(); // Asegúrate de llamar a super.initState() aquí
    // Inicializar el controlador en el initState
    controlador = ActivitiesController();
  }

  Future<void> addActivitie(String formData) async {
    try {
      final response = await http.post(
        Uri.parse(backendUrl + '/api/Module4/CreateActivity'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: formData,
      );

      if (response.statusCode == 200) {
        // Éxito: Navegar a la pantalla de inicio de sesión
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ActividadesScreen()),
        );
      } else {
        // Error: Mostrar un SnackBar con el mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error de servidor: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      print('Error al enviar los datos al backend: $e');
      // Mostrar un SnackBar con el mensaje de error de conexión
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'No se pudo conectar al backend. Verifica tu conexión de red o inténtalo más tarde.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE1E1E1),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                    padding: EdgeInsets.only(
                        top: 50), // Iniciar desde la parte superior
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
                            'lib/assets/ICONS_CARD/actividades.png',
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
                                    'Alimentos',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF323232),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '¡No olvides hacer ejercicio!',
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
                  Container(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Crear nuevo registro',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFF3B3B),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Recuerda utilizar algunos emojis 🏀',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4F4F4F),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller:
                          nombrePlatilloController, // Asignar el controlador
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF575757),
                        letterSpacing: 0.5,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        hintText: 'Nombre de la actividad',
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
                          Icons.directions_bike,
                          color: Color(0xFF777777),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // ... Otros widgets antes del formulario
                  Container(
                    width: double.infinity,
                    child: Text(
                      '¿Que clasificación es?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4F4F4F),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      value: selectedClasificacion,
                      isExpanded: true,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF777777),
                      ),
                      items: clasificaciones.map((String clasificacion) {
                        return DropdownMenuItem<String>(
                          value: clasificacion,
                          child: Center(
                            child: Text(clasificacion),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedClasificacion = newValue;
                        });
                      },
                      underline: Container(),
                    ),
                  ),
                  // ... Otros widgets después del formulario
                ],
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ActividadesScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    padding: EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Color.fromARGB(255, 97, 199, 190),
                      ),
                      Text(
                        ' Regresar',
                        style: TextStyle(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 27, 27, 27)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      String nombrePlatillo = nombrePlatilloController.text;

                      if (nombrePlatillo.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Por favor, ingresa el nombre de la actividad.'),
                          ),
                        );
                        return; // Salir de la función sin continuar
                      }

                      print('Nombre del Platillo: $nombrePlatillo');
                      print('Clasificación: $selectedClasificacion');
                      String formData = controlador.AddActJSON(
                        nombrePlatilloController.text,
                        selectedClasificacion,
                      );
                      print('Nombre del Platillo: $formData');
                      await addActivitie(formData);
                    } catch (e, stackTrace) {
                      print('Error en el botón: $e');
                      print('Stack Trace: $stackTrace');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 97, 199, 190),
                    padding: EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      Text(
                        ' Aceptar',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nombrePlatilloController.dispose();
    super.dispose();
  }
}
