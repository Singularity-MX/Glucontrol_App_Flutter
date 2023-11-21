import 'package:flutter/material.dart';
import 'package:Glucontrol/configBackend.dart'; // Asegúrate de proporcionar la ruta correcta a api_config.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConfigScreen(),
    );
  }
}

class ConfigScreen extends StatefulWidget {
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  TextEditingController urlController = TextEditingController();
  bool switchValue = false;

  @override
  void initState() {
    super.initState();
    // Inicializa el valor del TextField
    urlController.text = ApiConfig.backendUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('Usar URL personalizada:'),
                Switch(
                  value: switchValue,
                  onChanged: (value) {
                    setState(() {
                      switchValue = value;
                      if (value) {
                        urlController.text = ApiConfig.backendUrl;
                      } else {
                        urlController.text = 'http://192.168.1.96:3000';
                      }
                    });
                  },
                ),
              ],
            ),
            TextField(
              controller: urlController,
              enabled: switchValue,
              decoration: InputDecoration(labelText: 'URL personalizada'),
            ),
            ElevatedButton(
              onPressed: () {
                // Cuando se presione el botón, actualiza ApiConfig.backendUrl con el valor del TextField
                setState(() {
                  ApiConfig.backendUrl = urlController.text;
                });
                // Imprime la nueva URL en la consola (puedes quitar esto en tu aplicación final)
                print('Nuevo valor de backendUrl: ${ApiConfig.backendUrl}');
              },
              child: Text('Guardar Configuración'),
            ),
          ],
        ),
      ),
    );
  }
}
