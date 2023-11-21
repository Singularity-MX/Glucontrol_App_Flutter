import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // Importa la librería intl para dar formato a la fecha
import 'package:Glucontrol/models/Module1/RegistroModel.dart';
import 'package:Glucontrol/views/Module_1/registro_screen_IMC.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  // Crea una instancia de RegistroModel aquí y pásala a la pantalla RegistroScreenBirthday
  RegistroModel registro = RegistroModel();

  runApp(MaterialApp(
    home: RegistroScreenBirthday(
        registro: registro), // Pasa registro como argumento
  ));
}

class RegistroScreenBirthday extends StatefulWidget {
  final RegistroModel registro; // Agrega un miembro para almacenar el registro

  // Constructor que recibe el registro como argumento
  RegistroScreenBirthday({required this.registro});

  @override
  _RegistroScreenBirthdayState createState() => _RegistroScreenBirthdayState();
}

class _RegistroScreenBirthdayState extends State<RegistroScreenBirthday> {
  DateTime? selectedDate; // Variable para almacenar la fecha seleccionada

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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
                      'lib/assets/ICONS_CARD/cumpleaños.png',
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
                            '$saludo, vamos a registrar tu fecha de nacimiento.',
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
                  'Fecha de nacimiento',
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
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                'Muy bien ${widget.registro.nombre}, me gustaría saber cuando naciste, para felicitarte... 🎂🎁',
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
              child: TextFormField(
                readOnly: true,
                onTap: () async {
                  await _selectDate(
                      context); // Espera a que se seleccione la fecha
                  if (selectedDate != null) {
                    // Actualiza el campo de texto con la fecha seleccionada
                    final formattedDate =
                        DateFormat('yyyy-MM-dd').format(selectedDate!);
                    // Aquí puedes usar formattedDate para mostrar la fecha seleccionada
                  }
                },
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF575757),
                  letterSpacing: 0.5,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: selectedDate != null
                      ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                      : 'Fecha de Nacimiento', // Muestra la fecha seleccionada o el hint
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
                    Icons.calendar_today,
                    color: Color(0xFF777777),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  // Validar que la fecha de nacimiento no esté vacía
                  if (selectedDate == null) {
                    // Muestra un diálogo de error si la fecha de nacimiento está vacía
                    // Muestra un mensaje de error si uno de los campos está vacío
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, completa todos los campos.'),
                      ),
                    );
                  } else {
                    // Si la fecha de nacimiento no está vacía, asigna el valor y navega a la siguiente pantalla
                    widget.registro.fechaNacimiento =
                        DateFormat('yyyy-MM-dd').format(selectedDate!);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RegistrosScreenIMC(registro: widget.registro),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFF3C3C),
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
