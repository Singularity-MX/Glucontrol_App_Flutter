import 'package:Glucontrol/models/Module1/RegistroModel.dart';
import 'package:Glucontrol/tools/password_hash.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../configBackend.dart';

// Para acceder a la dirección del backend:
String backendUrl = ApiConfig.backendUrl;

class FoodController {
  // Constructor que recibe la instancia de RegistroModel

  //enviar al backend
  String AddFoodJSON(String nameFood, classificationFood) {
    //crear el JSON
    Map<String, dynamic> jsonObject = {
      "Food_name": nameFood,
      "Classification": classificationFood
    };

    // Convertir el Map en una cadena JSON
    String formData = jsonEncode(jsonObject);

    return formData;
  }
}
