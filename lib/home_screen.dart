import 'package:app_artificial_intelligence/my_service_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double horizontalPadding = 40;
  final double verticalPadding = 25;

  List myServices = [
    ["Flores", "assets/icons8-ramoflores.png", false],
    ["Frutas", "assets/icons8-grupo-de-frutas.png", false],
    ["Perros & Gatos", "assets/icons8-mascotas.png", false],
    ["Animales", "assets/icons8-señal-animales-salvajes-100.png", false],
  ];

  void interactiveSwitchChanged(bool value, int index) {
    setState(() {
      myServices[index][2] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/menu.png',
                    height: 30,
                    color: Colors.grey[800],
                  ),
                  Icon(
                    Icons.person,
                    size: 45,
                    color: Colors.grey[800],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bienvenido!',
                    style: GoogleFonts.teko(fontSize: 20),
                  ),
                  Text(
                    'Elige tu herramienta:',
                    style: GoogleFonts.teko(fontSize: 40),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                "Servicios de IA",
                style: GoogleFonts.teko(fontSize: 25),
              ),
            ),
            Expanded(
                child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: myServices.length,
              padding: const EdgeInsets.all(18),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1 / 1.2),
              itemBuilder: (context, index) {
                return MyServiceBox(
                  serviceName: myServices[index][0],
                  iconPath: myServices[index][1],
                  interactive: myServices[index][2],
                  onChanged: (value) => interactiveSwitchChanged(value, index),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
