import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rostro_app/screens/homepage.dart';
import '../utils/Glassmorphism.dart';
import '../utils/constant.dart';
import 'get_patient_pictures.dart';

class UploadUserPics extends StatefulWidget {
  final String token;

  const UploadUserPics({super.key, required this.token});

  @override
  State<UploadUserPics> createState() => _UploadUserPics();
}

class _UploadUserPics extends State<UploadUserPics> {
  var bg = './assets/images/bg6.gif';
  late String token;
  late List<XFile?> pictures;
  late int id;
  XFile? picture;
  @override
  void initState() {
    super.initState();
    token = widget.token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Some Pictures"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg),
            fit: BoxFit.cover,
          ),
        ), //background image
        child: ListView(
          children: <Widget>[
              getUserPics(context)
          ],
        ),
      ),
    );
  }

  Container getUserPics(BuildContext context) {

    Uri uploadUri = Uri();
    if (Constants.BASE_URL == "api.rostro-authentication.com") {
      uploadUri = Uri.https(Constants.BASE_URL, '/api/user/upload-image/');
    } else {
      uploadUri = Uri.parse("${Constants.BASE_URL}/api/user/upload-image/");
    }

    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle
      ),
      margin: const EdgeInsets.only(
          left: 55,
          right: 55,
          bottom: 14
      ),
      child: Glassmorphism(
        blur: 20,
        opacity: 0.1,
        radius: 50.0,
        child: TextButton(
          onPressed: () async {

            showDialog(
                context: context,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                });

            pictures = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => GetPatientPictures(token: token)));
            var request = http.MultipartRequest("POST", uploadUri);
            request.headers.addAll({"Authorization": "Token $token"});
            var image1 =
            await http.MultipartFile.fromPath("image_lists", pictures[0]!.path);
            request.files.add(image1);
            var image2 =
            await http.MultipartFile.fromPath("image_lists", pictures[1]!.path);
            request.files.add(image2);
            var image3 =
            await http.MultipartFile.fromPath("image_lists", pictures[2]!.path);
            request.files.add(image3);
            http.StreamedResponse response = await request.send();

            Navigator.of(context).pop();
            if(response.statusCode > 199 && response.statusCode < 300){
              ShowDialogSucc(context);

              setState(() {});
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5,
            ),
            child: const Text(
              "Add Pictures",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget? ShowDialogSucc(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Message!"),
          content: const Text(
              "Your pictures have been successfully been Added!"),
          actions: <Widget>[
            TextButton(
              child: const Text("Go to Home Page"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Homepage(token: token)),
                );
              },
            ),
          ],
        );
      },
    );
  }
  
}
