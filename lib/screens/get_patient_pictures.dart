import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';

import '../utils/Glassmorphism.dart';
import 'camera.dart';

class GetPatientPictures extends StatefulWidget {
  final String token;
  const GetPatientPictures({super.key, required this.token});

  @override
  State<GetPatientPictures> createState() => Pictures();
}

class Pictures extends State<GetPatientPictures> {
  var bg = './assets/images/bg1.gif';
  late String token;

  @override
  void initState() {
    token = widget.token;
    super.initState();
  }

  int step = 5;
  var pictures = List<XFile?>.filled(5, null);

  void reduceStep() {
    setState(() {
      step--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg),
            fit: BoxFit.cover,
          ),
        ), //background image
        child: ListView(
          children: <Widget>[
            box(),
            Gap(30),
            cameraButtonSection(),
          ],
        ),
      ),
    );
  }

  Container cameraButtonSection() {
    return Container(
      margin: EdgeInsets.only(left: 55, right: 55),
      // margin: const EdgeInsets.only(top: 50.0),
      // padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Glassmorphism(
          blur: 20,
          opacity: 0.1,
          radius: 50.0,
          child: TextButton(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: const Text(
                'Take Pictures',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
            ),
            onPressed: () async {
              pictures[5 - step] = await availableCameras().then((value) =>
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              Camera(token: token, cameras: value))));
              reduceStep();
              if (step == 0) {
                Navigator.pop(context, pictures);
              }
            },
          )),

      //end of button
    );
  }

  Padding box() {
    return Padding(
      padding: EdgeInsets.only(top: 50, left: 15, right: 15),
      child: GlassContainer(
        borderRadius: new BorderRadius.circular(10.0),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
          child: Center(
            child: Text(
              'Patient pictures left to take : $step',
              style: const TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 15,
                  color: Colors.white,
                  height: 1,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
