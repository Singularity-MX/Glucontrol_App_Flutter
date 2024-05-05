import 'package:flutter/material.dart';
import 'info_menu.dart'; // Importa la página InfoMenu
import 'package:Glucontrol/test/viewTest.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con imagen
          Image.asset(
            'lib/assets/fondo.jpg', // Ruta de la imagen de fondo
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Logo en el centro
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 80),
                Image.asset(
                  'lib/assets/Logo.png', // Ruta del logo
                  width: 180, // Ancho del logo
                  height: 180, // Alto del logo
                ),
                SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.65, // Ancho del 65% de la pantalla
                  alignment: Alignment.center, // Centrar el texto
                  child: Text(
                    'Glucontrol es una app que te ayudará a tener un mejor control de tu glucosa. ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w200, // Fuente Extra Light
                    ),
                    textAlign: TextAlign.justify, // Justificar el texto
                  ),
                ),
              ],
            ),
          ),

          // Contenedor con bordes redondeados y sombreado
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height *
                  0.3, // Altura del 30% de la pantalla
              width: MediaQuery.of(context)
                  .size
                  .width, // Ancho del 100% de la pantalla
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.black.withOpacity(0.25), // Color del sombreado
                    spreadRadius: 5, // Radio de difusión
                    blurRadius: 7, // Radio de desenfoque
                    offset: Offset(0, 3), // Desplazamiento en X y Y
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '¿Por que no le hechas un vistazo?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      // Fuente Extra Light
                    ),
                    textAlign: TextAlign.justify, // Justificar el texto
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navegar a la página InfoMenu
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InfoMenu()),
                      );
                    },
                    child: Text('Ir al Menú de Información'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Color de fondo del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15.0), // Radio de esquinas de 15
                      ),
                      minimumSize: Size(
                        MediaQuery.of(context).size.width *
                            0.7, // Ancho del 70% de la pantalla
                        50, // Altura de 50
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navegar a la página InfoMenu
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ConfigScreen()),
                      );
                    },
                    child: Text('test'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Color de fondo del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15.0), // Radio de esquinas de 15
                      ),
                      minimumSize: Size(
                        MediaQuery.of(context).size.width *
                            0.7, // Ancho del 70% de la pantalla
                        50, // Altura de 50
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // Texto en la parte inferior
        ],
      ),
    );
  }
}
