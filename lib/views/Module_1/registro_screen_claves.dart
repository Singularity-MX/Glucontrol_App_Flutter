import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // Importa la librería intl para dar formato a la fecha
import 'package:Glucontrol/models/Module1/RegistroModel.dart';
import 'package:Glucontrol/controllers/Module1/RegisterUserController.dart';
import 'package:Glucontrol/views/Module_2/login.dart';
import 'package:http/http.dart' as http;

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  // Crea una instancia de RegistroModel aquí y pásala a la pantalla RegistroScreenBirthday
  RegistroModel registro = RegistroModel();

  runApp(MaterialApp(
    home: RegistrosScreenClaves(
        registro: registro), // Pasa registro como argumento
  ));
}

class RegistrosScreenClaves extends StatefulWidget {
  final RegistroModel registro; // Agrega un miembro para almacenar el registro

  // Constructor que recibe el registro como argumento
  RegistrosScreenClaves({required this.registro});

  @override
  _RegistrosScreenClavesState createState() => _RegistrosScreenClavesState();
}

class _RegistrosScreenClavesState extends State<RegistrosScreenClaves> {
  DateTime? selectedDate; // Variable para almacenar la fecha seleccionada
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final TextEditingController txtPasswordConfirm = TextEditingController();

  // Declarar una instancia del controlador
  late RegisterUserController controlador;

  @override
  void initState() {
    super.initState();
    // Inicializar el controlador en el initState
    controlador = RegisterUserController(widget.registro);
  }

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

  Future<void> RegistrarUsuario(String formData) async {
    try {
      final response = await http.post(
        Uri.parse(backendUrl + '/api/Module1/Login/Insert'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: formData,
      );

      if (response.statusCode == 201) {
        // Éxito: Navegar a la pantalla de inicio de sesión
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginApp()),
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
                      'lib/assets/ICONS_CARD/clave.png',
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
                            'Vamos a registrar tu cuenta nueva.',
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
                  'Crear cuenta ',
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
                'Ya casi terminamos, solo registrar un correo y una contraseña:',
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
                controller: txtEmail,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF575757),
                  letterSpacing: 0.5,
                ),
                keyboardType: TextInputType
                    .emailAddress, // Configurar el teclado para números

                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'Correo electrónico',
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
                    Icons.email_outlined,
                    color: Color(0xFF777777),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: txtPassword,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF575757),
                  letterSpacing: 0.5,
                ),
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'Contraseña nueva',
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
                    Icons.lock_outline_rounded,
                    color: Color(0xFF777777),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: txtPasswordConfirm,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF575757),
                  letterSpacing: 0.5,
                ),
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'Confirmar contraseña',
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
                    Icons.lock_outline_rounded,
                    color: Color(0xFF777777),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () async {
                  // Validar que los campos no estén vacíos
                  if (txtEmail.text.isEmpty ||
                      txtPassword.text.isEmpty ||
                      txtPasswordConfirm.text.isEmpty) {
                    // Muestra un mensaje de error si algún campo está vacío
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, completa todos los campos.'),
                      ),
                    );
                  } else if (txtPassword.text != txtPasswordConfirm.text) {
                    // Verificar si las contraseñas coinciden
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Las contraseñas no coinciden. Inténtalo de nuevo.'),
                      ),
                    );
                  } else {
                    // Validar el formato del correo
                    bool esCorreoValido(String correo) {
                      final regExpCorreo = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
                      );
                      return regExpCorreo.hasMatch(correo);
                    }

// Validar la contraseña
                    bool esContrasenaValida(String contrasena) {
                      final regExpContrasena = RegExp(
                        r'^(?=.*[A-Z])(?=.*[0-9]).{8,}$',
                      );
                      return regExpContrasena.hasMatch(contrasena);
                    }

// Dentro de tu función para enviar los datos
                    String correo = txtEmail.text;
                    String contrasena = txtPassword.text;

                    if (esCorreoValido(correo) &&
                        esContrasenaValida(contrasena)) {
                      // Los valores son válidos, puedes continuar
                      widget.registro.email = correo;
                      widget.registro.password = contrasena;

                      // OBTIENE EL JSON
                      String formData = controlador.CrearJson();

                      // Función para el ENDPOINT
                      await RegistrarUsuario(formData);
                    } else {
                      // Mostrar un mensaje de error si el correo o la contraseña no son válidos
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Por favor, ingresa un correo válido y la contraseña debe tener mínimo 8 caracteres, 1 número y mayúsculas'),
                        ),
                      );
                    }
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
                  'Finalizar',
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
