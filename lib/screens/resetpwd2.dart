import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class EnterResetKey extends StatefulWidget {
  final String? email;
  const EnterResetKey({
    super.key,
    this.email,
  });

  @override
  State<EnterResetKey> createState() => _EnterResetKeyState();
}

class _EnterResetKeyState extends State<EnterResetKey> {
  @override
  void initState() {
    var email = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bg = './assets/images/bg6.gif';
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(bg),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: <Widget>[
            keybox(),
          ],
        ),
      ),
    );
  }

  Widget keybox() {
    String? email = widget.email;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            "Changing Password for $email",
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
