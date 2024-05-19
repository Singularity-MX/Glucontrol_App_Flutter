import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Glucontrol/configBackend.dart';
import 'package:http/http.dart' as http;
import 'package:Glucontrol/controllers/Module4/GlucoseController.dart';
import 'package:Glucontrol/views/Module_3/home.dart';

import 'GlucosaScreen.dart';

class ModifyGlucose extends StatefulWidget {
  final Map<String, dynamic> food; // Datos del alimento a editar

  ModifyGlucose({required this.food});

  @override
  _ModifyGlucoseState createState() => _ModifyGlucoseState();
}

class _ModifyGlucoseState extends State<ModifyGlucose> {
  String? selectedAlimento;
  String? selectedActividad;
  TextEditingController glucosaController = TextEditingController();
  TextEditingController cantidadController = TextEditingController();
  TextEditingController duracionController = TextEditingController();

  List<String> alimentos = []; // Lista de alimentos
  List<String> actividades = []; // Lista de actividades

  String rid = "";
  late GlucoseController controlador;
  @override
  void initState() {
    super.initState();
    fetchAlimentos();
    fetchActividades();
    controlador = GlucoseController();

    // Inicializa los controladores con los datos actuales del alimento
    glucosaController.text = widget.food['Glucose_level'].toString();
    cantidadController.text = widget.food['Cantidad'];
    duracionController.text = widget.food['Duration'].toString();
    rid = widget.food['RID'];
  }

  Future<void> fetchAlimentos() async {
    final response = await http
        .get(Uri.parse('${ApiConfig.backendUrl}/api/Module4/GetUserFoods'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        setState(() {
          alimentos = data
              .map((item) => item['Food_name']
                  .toString()) // Asegúrate de que el valor sea String
              .toList();
        });
      } else {
        throw Exception('Error al obtener alimentos');
      }
    } else {
      throw Exception('Error al obtener alimentos');
    }
  }

  Future<void> fetchActividades() async {
    final response = await http
        .get(Uri.parse('${ApiConfig.backendUrl}/api/Module4/GetActivities'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        setState(() {
          actividades = data
              .map((item) => item['Activitie_name']
                  .toString()) // Asegúrate de que el valor sea String
              .toList();
        });
      } else {
        throw Exception('Error al obtener actividades');
      }
    } else {
      throw Exception('Error al obtener actividades');
    }
  }

  Future<void> UpdateReadGlucose(String formData, String RID) async {
    try {
      final response = await http.put(
        Uri.parse(backendUrl + '/api/Module4/UpdateGlucoseReading/' + RID),
        headers: {
          'Content-Type': 'application/json',
        },
        body: formData,
      );

      if (response.statusCode == 200) {
        // Éxito: Navegar a la pantalla de inicio de sesión
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GlucosaScreen()),
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
                                    'Registro de glucosa',
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
                        'Modificar un registro',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFF3B3B),
                        ),
                      ),
                    ),
                  ),

                  ///////////////////////////////////alimento
                  SizedBox(height: 16.0),
                  // ... Otros widgets antes del formulario
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Selecciona el último alimento que tomaste:',
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
                      value: selectedAlimento,
                      isExpanded: true,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF777777),
                      ),
                      items: alimentos.map((String alimento) {
                        return DropdownMenuItem<String>(
                          value: alimento,
                          child: Text(alimento),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedAlimento = newValue ?? '';
                        });
                      },
                      underline: Container(),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: cantidadController, // Asignar el controlador
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF575757),
                        letterSpacing: 0.5,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        hintText: 'Cantidad (gr)',
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
                          Icons.restaurant,
                          color: Color(0xFF777777),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),

                  ///////////////////////////////////actividad
                  SizedBox(height: 16.0),
                  // ... Otros widgets antes del formulario
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Selecciona la última actividad que hiciste:',
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
                      value: selectedActividad,
                      isExpanded: true,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF777777),
                      ),
                      items: actividades.map((String actividad) {
                        return DropdownMenuItem<String>(
                          value: actividad,
                          child: Text(actividad),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedActividad = newValue ??
                              ''; // Usa el operador ?? para evitar nulos
                        });
                      },
                      underline: Container(),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: duracionController, // Asignar el controlador
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF575757),
                        letterSpacing: 0.5,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        hintText: 'Duración (minutos):',
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
                          Icons.access_time,
                          color: Color(0xFF777777),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),

                  /////////////////////////////glucosa
                  SizedBox(height: 20),
                  Text('Nivel de Glucosa (mg/dL):'),
                  SizedBox(height: 10.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: glucosaController, // Asignar el controlador
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF575757),
                        letterSpacing: 0.5,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        hintText: 'Ingrese el nivel de glucosa',
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
                          Icons.local_hospital,
                          color: Color(0xFF777777),
                        ),
                      ),
                      keyboardType: TextInputType.number,
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
                      MaterialPageRoute(builder: (context) => GlucosaScreen()),
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
                        color: const Color.fromARGB(255, 24, 24, 24),
                      ),
                      Text(
                        ' Regresar',
                        style: TextStyle(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 97, 199, 190)),
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
                    // Obtén los valores de los campos de texto
                    final alimento = selectedAlimento;
                    final actividad = selectedActividad;
                    final glucosa = glucosaController.text;

                    // Valida que ninguno de los campos esté vacío
                    if (alimento == null ||
                        actividad == null ||
                        glucosa.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Por favor, completa todos los campos.'),
                        ),
                      );
                      return; // Sale de la función sin hacer nada si hay campos vacíos
                    }

                    // Ahora puedes continuar con el proceso de registro
                    try {
                      String formData = controlador.AddReadGlucoseJSON(
                        alimento,
                        cantidadController.text,
                        actividad,
                        duracionController.text,
                        glucosa,
                      );
                      await UpdateReadGlucose(formData, rid);
                    } catch (e, stackTrace) {
                      print('Error en el botón: $e');
                      print('Stack Trace: $stackTrace');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Error al registrar los datos. Por favor, inténtalo de nuevo.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Color.fromARGB(255, 97, 199, 190),
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
    // Limpia el controlador cuando se destruye el widget para liberar recursos.
    glucosaController.dispose();
    super.dispose();
  }
}
