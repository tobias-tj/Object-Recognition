import 'dart:io';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Flower extends StatefulWidget {
  const Flower({super.key});

  @override
  State<Flower> createState() => _FlowerState();
}

class _FlowerState extends State<Flower> {
  bool _loading = true;
  late File _image;
  List<dynamic>? _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 5,
        threshold: 0.7,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/flowers_model/model.tflite',
        labels: 'assets/flowers_model/labels.txt');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Tflite.close();
    super.dispose();
  }

  pickImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  bool isPressed = true;

  pickGalleryImage() async {
    isPressed = !isPressed;
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    final backgrundColor = Color.fromARGB(255, 252, 254, 255);
    Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
    double blur = isPressed ? 5.0 : 30.0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          'Flores',
          style: GoogleFonts.teko(fontSize: 28),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: pickImage, icon: Icon(Icons.photo_camera_outlined))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
                child: _loading
                    ? Container(
                        width: 280,
                        child: Column(
                          children: [
                            Image.asset('assets/flower-icons.png'),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          children: [
                            Container(
                              height: 250,
                              child: Image.file(_image),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (_output != null && _output!.isNotEmpty)
                              Text(
                                '${_output![0]['label']}',
                                style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              )
                            else
                              const Text(
                                'Imagen No Corresponde',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      )),
            SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: pickGalleryImage,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: backgrundColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: blur,
                          offset: -distance,
                          color: Colors.white,
                          inset: isPressed,
                        ),
                        BoxShadow(
                          blurRadius: blur,
                          offset: distance,
                          color: const Color(0xFFA7A9AF),
                          inset: isPressed,
                        ),
                      ]),
                  child: SizedBox(
                      height: 80,
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_camera_back_outlined,
                            size: 25,
                            color: Colors.black,
                          ),
                          Text(
                            'Agregar Imagen',
                            style: GoogleFonts.teko(fontSize: 18),
                          )
                        ],
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
