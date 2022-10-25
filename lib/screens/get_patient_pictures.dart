import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'camera.dart';

class GetPatientPictures extends StatefulWidget{
  final String token;
  const GetPatientPictures({super.key, required this.token});

  @override
  State<GetPatientPictures> createState() => Pictures();
}

class Pictures extends State<GetPatientPictures> {
  
  var bg = './assets/images/bg.jpeg';
  late String token;


  @override
  void initState() {
    token = widget.token;
       print('Token in get patient pic: $token');
    super.initState();
   
    // initCamera(widget.patients![0]);
  }

  int step = 3;
  var pictures = List<XFile?>.filled(3, null);

  void reduceStep(){
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
            cameraButtonSection(),
          ],
        ),
      ),
    );
  }
  Container cameraButtonSection() {
    return Container(
        margin: const EdgeInsets.only(top: 50.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          child: const Text('Take Picture'),
          onPressed: () async {
            pictures[3-step] = await availableCameras().then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => Camera(token: token, cameras: value))));
            reduceStep();
               print('Token in get patient pic $token');
            if(step == 0){
              print(pictures[0]?.path);
              
              Navigator.pop(context, pictures);
            }
          },
        )

      //end of button
    );
  }
  Container box(){
    return Container(
      margin: const EdgeInsets.only(top: 100.0),
      width: 150.0,
      height: 240.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: const Color(0xFF1565C0),
      ),
      alignment: Alignment.topCenter,
      child: SizedBox(
        child: Center(
        child: Text(
          'Patient pictures left to take: $step',
          style: const TextStyle(
            fontFamily: 'Arial',
            fontSize: 30,
            color: Colors.white,
            height: 1,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,

        ),
        ),
      ),
    );
  }
}