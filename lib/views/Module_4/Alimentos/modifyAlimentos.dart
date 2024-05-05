import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../configBackend.dart';
import 'package:Glucontrol/views/Module_4/Alimentos/AlimentosScreen.dart';
import 'package:Glucontrol/controllers/Module4/FoodControllers.dart';

class EditarAlimentoScreen extends StatefulWidget {
  final Map<String, dynamic> food; // Datos del alimento a editar

  EditarAlimentoScreen({required this.food});

  @override
  _EditarAlimentoScreenState createState() => _EditarAlimentoScreenState();
}

class _EditarAlimentoScreenState extends State<EditarAlimentoScreen> {
  // Controladores para los campos de edición
  TextEditingController foodNameController = TextEditingController();
  TextEditingController classificationController = TextEditingController();
  String? classification; // Cambiado a String?
  List<String> clasificaciones = [
    "Carbohidratos",
    "Proteínas",
    "Grasas",
    "Frutas",
    "Verduras"
  ];
  String? selectedClasificacion = "Verduras";
  late FoodController controlador;
  String fid = "";

  @override
  void initState() {
    super.initState();
    controlador = FoodController();
    // Inicializa los controladores con los datos actuales del alimento
    foodNameController.text = widget.food['Food_name'];
    classificationController.text = widget.food['Classification'];
    fid = widget.food['FID'];
  }

  Future<void> ModifyFood(String formData) async {
    try {
      final response = await http.put(
        Uri.parse(ApiConfig.backendUrl + '/api/Module4/UpdateFood/' + fid),
        headers: {
          'Content-Type': 'application/json',
        },
        body: formData,
      );

      if (response.statusCode == 200) {
        // Éxito: Navegar a la pantalla de inicio de sesión
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AlimentosScreen()),
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
                            'lib/assets/ICONS_CARD/food.png',
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
                                  '¡No olvides comer saludable!',
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
                      'Recuerda utilizar algunos emojis 🍉',
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
                      controller: foodNameController, // Asignar el controlador
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF575757),
                        letterSpacing: 0.5,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        hintText: 'Nombre del alimento',
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
                          builder: (context) => AlimentosScreen()),
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
                    // Aquí debes enviar los datos actualizados al servidor
                    final updatedFoodData = {
                      'Food_name': foodNameController.text,
                      'Classification': selectedClasificacion,
                    };
                    // Llama a la función para enviar los datos actualizados al servidor
                    // Puedes usar http.put o http.post, dependiendo de tu API
                    // Asegúrate de manejar las respuestas y errores adecuadamente

                    try {
                      String formData = controlador.AddFoodJSON(
                          foodNameController.text, selectedClasificacion);

                      await ModifyFood(formData);
                    } catch (e, stackTrace) {
                      print('Error en el botón: $e');
                      print('Stack Trace: $stackTrace');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 48, 48, 48),
                    padding: EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                      Text(
                        ' Actualizar',
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
}
