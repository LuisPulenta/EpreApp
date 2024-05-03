import 'package:epreapp/themes/app_theme.dart';
import 'package:epreapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:epreapp/models/models.dart';
import 'package:epreapp/screens/screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//---------------------------------------------------------------
//----------------------- Variables -----------------------------
//---------------------------------------------------------------

  String direccion = '';

//---------------------------------------------------------------
//----------------------- initState -----------------------------
//---------------------------------------------------------------

  @override
  void initState() {
    super.initState();
  }

//---------------------------------------------------------------
//----------------------- Pantalla ------------------------------
//---------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Epre App'),
      //   centerTitle: true,
      // ),
      body: _getBody(),
    );
  }

//---------------------------------------------------------------
//----------------------- _getBody ------------------------------
//---------------------------------------------------------------
  Widget _getBody() {
    double ancho = MediaQuery.of(context).size.width;
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 60),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Image.asset(
              "assets/logo.png",
              height: 160,
              width: 500,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Bienvenido/a',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReclamosScreen(),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: ancho,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Boton(
                        icon: FontAwesomeIcons.triangleExclamation,
                        texto: "Reclamos",
                        color1: AppTheme.primary,
                        color2: AppTheme.secondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DenunciasScreen(),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: ancho,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Boton(
                        icon: FontAwesomeIcons.circleExclamation,
                        texto: "Denuncias",
                        color1: AppTheme.secondary,
                        color2: AppTheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
