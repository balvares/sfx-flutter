import 'package:flutter/material.dart';
import 'package:suflex/app/modules/login/sign-in.dart';
import 'package:suflex/app/modules/profile/user-list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {

    super.initState();
  }

  Widget _buildBody() {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Bem vindo!', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ],
        ),
        MaterialButton(
          child: Text('Ir para a Listagem de Usuários'),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UserList())),
        ),
        MaterialButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignIn())),
          child: Text('Sair'),
          color: Colors.lightBlue
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: _buildBody()
      ),
    );
  }

}