import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Glucontrol/views/Module_1/registro_screen_birthday.dart';
import 'package:Glucontrol/models/Module1/RegistroModel.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  runApp(MaterialApp(
    home: RegistroScreen(),
  ));
}

class RegistroScreen extends StatelessWidget {
  final TextEditingController txtNombre = TextEditingController();
  final TextEditingController txtAP = TextEditingController();
  final TextEditingController txtAM = TextEditingController();
  String? txtSexo;

// Declara la instancia del modelo aquí
  final RegistroModel registro = RegistroModel();

  @override
  Widget build(BuildContext context) {
    // Determinar si es día, tarde o noche
    final horaActual = DateTime.now().hour;
    String saludo;
    if (horaActual >= 5 && horaActual < 12) {
      saludo = 'Buenos días';
    } else if (horaActual >= 12 && horaActual < 18) {
      saludo = 'Buenas tardes';
    } else {
      saludo = 'Buenas noches';
    }

    //validar TXTs

    // Configura el color de la barra de notificaciones
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF323232), // Cambia el color aquí
    ));

    return Scaffold(
      backgroundColor: Color(0xFFE1E1E1),
      body: SingleChildScrollView(
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
                      'lib/assets/ICONS_CARD/saludo.png',
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(width: 16),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              '¡Bienvenido/a!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF323232),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '$saludo, vamos a crear tu cuenta...',
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
                  'Registro nuevo',
                  style: TextStyle(
                    fontSize: 25,
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
                'Es un gusto conocerte, ¿Cuál es tu nombre?',
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
                controller: txtNombre, // Asignar el controlador
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF575757),
                  letterSpacing: 0.5,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'Nombre(s)',
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
                    Icons.person_outlined,
                    color: Color(0xFF777777),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: txtAP, // Asignar el controlador
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF575757),
                  letterSpacing: 0.5,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'Apellido Paterno',
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
                    Icons.person_outlined,
                    color: Color(0xFF777777),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: txtAM, // Asignar el controlador
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF575757),
                  letterSpacing: 0.5,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'Apellido Materno',
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
                    Icons.person_outlined,
                    color: Color(0xFF777777),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: DropdownButtonFormField<String>(
                value: txtSexo, // Asignar el valor seleccionado
                items: <String>['Masculino', 'Femenino'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                    Icons.person_add_alt_outlined,
                    color: Color(0xFF777777),
                  ),
                ),
                onChanged: (String? value) {
                  // Actualizar el valor seleccionado
                  txtSexo = value;
                },
                hint: Text('Selecciona tu género'),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  // Validar que los campos no estén vacíos
                  if (txtNombre.text.isEmpty ||
                      txtAP.text.isEmpty ||
                      txtAM.text.isEmpty ||
                      txtSexo == null) {
                    // Muestra un diálogo de error si los campos están vacíos
                    // Muestra un mensaje de error si uno de los campos está vacío
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, completa todos los campos.'),
                      ),
                    );
                  } else {
                    // Si los campos no están vacíos, asigna los valores y navega a la siguiente pantalla
                    bool contieneNumeros(String texto) {
                      final contieneNumeros = RegExp(r'[0-9]').hasMatch(texto);
                      return contieneNumeros;
                    }

// Dentro de tu función para enviar los datos
                    if (contieneNumeros(txtNombre.text) ||
                        contieneNumeros(txtAP.text) ||
                        contieneNumeros(txtAM.text)) {
                      // Mostrar un mensaje de error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Los campos no deben contener números.'),
                        ),
                      );
                    } else {
                      // Los campos son válidos y puedes continuar con el envío de datos.
                      registro.nombre = txtNombre.text;
                      registro.apellidoPaterno = txtAP.text;
                      registro.apellidoMaterno = txtAM.text;
                      // Luego, continúa con el proceso de envío de datos.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RegistroScreenBirthday(registro: registro),
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF3C3C),
                  padding: EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: Text(
                  'Siguiente',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
