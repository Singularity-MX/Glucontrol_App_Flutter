import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:Glucontrol/models/Module1/RegistroModel.dart';
import 'package:Glucontrol/views/Module_1/registro_screen_claves.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  RegistroModel registro = RegistroModel();

  runApp(MaterialApp(
    home: RegistrosScreenIMC(registro: registro),
  ));
}

class RegistrosScreenIMC extends StatefulWidget {
  final RegistroModel registro;

  // Constructor que recibe el registro como argumento
  RegistrosScreenIMC({required this.registro});

  @override
  _RegistrosScreenIMCState createState() => _RegistrosScreenIMCState();
}

class _RegistrosScreenIMCState extends State<RegistrosScreenIMC> {
  DateTime? selectedDate;
  final TextEditingController txtEstatura = TextEditingController();
  final TextEditingController txtPeso = TextEditingController();

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
    final horaActual = DateTime.now().hour;
    String saludo;
    if (horaActual >= 5 && horaActual < 12) {
      saludo = 'Buenos días';
    } else if (horaActual >= 12 && horaActual < 18) {
      saludo = 'Buenas tardes';
    } else {
      saludo = 'Buenas noches';
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF323232),
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
              padding: EdgeInsets.only(top: 50),
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
                      'lib/assets/ICONS_CARD/medidas.png',
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
                            'Necesito algunos datos físicos sobre ti...',
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
                  'Peso y estatura',
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
                'Lo has hecho muy bien, ahora necesito saber algo, ¿Cuánto mides y pesas?',
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
                controller: txtEstatura,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF575757),
                  letterSpacing: 0.5,
                ),
                keyboardType:
                    TextInputType.number, // Configurar el teclado para números
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter
                      .digitsOnly, // Aceptar solo dígitos
                ],
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'Estatura (cm)',
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
                    Icons.height_outlined,
                    color: Color(0xFF777777),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: txtPeso,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF575757),
                  letterSpacing: 0.5,
                ),
                keyboardType:
                    TextInputType.number, // Configurar el teclado para números
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter
                      .digitsOnly, // Aceptar solo dígitos
                ],
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'Peso (kg)',
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
                    Icons.fitness_center_outlined,
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
                  // Validar que los campos de estatura y peso no estén vacíos
                  if (txtEstatura.text.isEmpty || txtPeso.text.isEmpty) {
                    // Muestra un mensaje de error si uno de los campos está vacío
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, completa todos los campos.'),
                      ),
                    );
                  } else {
                    // Validar que la altura sea menor de 250 cm y el peso sea menor de 500 kg
                    double altura = double.tryParse(txtEstatura.text) ?? 0.0;
                    double peso = double.tryParse(txtPeso.text) ?? 0.0;

                    if (altura > 0 && altura < 250 && peso > 0 && peso < 500) {
                      // Los valores son válidos, puedes continuar
                      widget.registro.altura = altura;
                      widget.registro.peso = peso;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RegistrosScreenClaves(registro: widget.registro),
                        ),
                      );
                    } else {
                      // Mostrar un mensaje de error si los valores no son válidos
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Por favor, ingresa una altura válida (menos de 250 cm) y un peso válido (menos de 500 kg).'),
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
