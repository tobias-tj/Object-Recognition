import 'package:app_artificial_intelligence/animals_screen.dart';
import 'package:app_artificial_intelligence/dog_cat_screen.dart';
import 'package:app_artificial_intelligence/flower_screen.dart';
import 'package:app_artificial_intelligence/frut_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MyServiceBox extends StatefulWidget {
  final String serviceName;
  final String iconPath;
  final bool interactive;
  void Function(bool)? onChanged;

  MyServiceBox(
      {super.key,
      required this.serviceName,
      required this.iconPath,
      required this.interactive,
      required this.onChanged});

  @override
  State<MyServiceBox> createState() => _MyServiceBoxState();
}

class _MyServiceBoxState extends State<MyServiceBox> {
  bool _isTransitioning = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: () {
          widget.onChanged?.call(!widget.interactive);
          _navigateToDestinationScreen();
        },
        child: Container(
          decoration: BoxDecoration(
              color: widget.interactive ? Colors.grey[900] : Colors.grey[200],
              borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                widget.iconPath,
                height: 65,
                color: widget.interactive ? Colors.white : Colors.black,
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      widget.serviceName,
                      style: TextStyle(
                          color:
                              widget.interactive ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  )),
                  Icon(
                    Icons.arrow_upward,
                    color: widget.interactive ? Colors.white : Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDestinationScreen() {
    switch (widget.serviceName) {
      case "Perros & Gatos":
        Navigator.push(
            context,
            PageTransition(
                child: const DogAndCat(),
                type: PageTransitionType.bottomToTop));
        break;
      case "Flores":
        Navigator.push(
            context,
            PageTransition(
                child: const Flower(), type: PageTransitionType.bottomToTop));
        break;
      case "Frutas":
        Navigator.push(
            context,
            PageTransition(
                child: const Frut(), type: PageTransitionType.bottomToTop));
        break;
      case "Animales":
        Navigator.push(
            context,
            PageTransition(
                child: const Animals(), type: PageTransitionType.bottomToTop));
        break;
      default:
        break;
    }
  }
}
