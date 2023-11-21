import 'package:Glucontrol/models/Module1/RegistroModel.dart';
import 'package:Glucontrol/tools/password_hash.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../configBackend.dart';
import 'package:intl/intl.dart';

// Para acceder a la dirección del backend:
String backendUrl = ApiConfig.backendUrl;

class GlucoseController {
  // Constructor que recibe la instancia de RegistroModel

  //enviar al backend
  String AddReadGlucoseJSON(String food, String quantity, String activity,
      String duration, String glucoseLevel) {
    //crear el JSON
    int cantidadINT = int.parse(quantity);
    int duracionINT = int.parse(duration);
    int glucoseINT = int.parse(glucoseLevel);

    DateTime now = DateTime.now(); // Obtiene la fecha y hora actual

// Formatea la fecha en el formato "yyyy-MM-dd" (Año-Mes-Día)
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

// Formatea la hora en el formato "HH:mm:ss" (Hora:Minuto:Segundo)
    String formattedTime = DateFormat('HH:mm:ss').format(now);

    Map<String, dynamic> jsonObject = {
      "FID": food,
      "Cantidad": cantidadINT,
      "AID": activity,
      "Duration": duracionINT,
      "Glucose_level": glucoseINT,
      "Registration_date": formattedDate,
      "Hour": formattedTime
    };

    // Convertir el Map en una cadena JSON
    String formData = jsonEncode(jsonObject);

    return formData;
  }
}
