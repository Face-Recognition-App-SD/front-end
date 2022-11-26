import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddNewUser extends StatefulWidget {
  final String token;
 final  bool? is_superuser;
  const AddNewUser({super.key, required this.token, required this.is_superuser});

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  late String token;
  late bool? is_superuser;
  void initState(){
    token  = widget.token;
    is_superuser = widget.is_superuser;

  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}