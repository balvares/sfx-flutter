import 'package:flutter/material.dart';
import 'package:suflex/app/shared/widgets/custom_button.dart';
import 'package:suflex/app/shared/widgets/custom_text_input.dart';

class UserForm extends StatefulWidget {

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  void initState() {

    _nomeController.dispose();
    _sobrenomeController.dispose();
    _usernameController.dispose();
    _senhaController.dispose();

    super.initState();
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  Widget _buildTitle() {

    return Text(
      'Preencha os dados abaixo:',
    );
  }

  Widget _buildNameInput() {

    return CustomTextInput(
      label: 'Nome', 
      controller: _nomeController,
    );
  }

  Widget _buildSobrenomeInput() {

    return CustomTextInput(
      label: 'Sobrenome', 
      controller: _sobrenomeController
    );
  }

  Widget _buildUsernameInput() {

    return CustomTextInput(
      label: 'Nome de usuário', 
      controller: _usernameController,
    );
  }

  Widget _buildSenhaInput() {

    return CustomTextInput(
      label: 'Senha', 
      controller: _senhaController,
    );
  }

  Widget _buildButton() {

    return CustomButton(label: 'Salvar', onPressed: () => {}); // todo
  }

  Widget _buildForm() {

    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 30.0,
        ),
        shrinkWrap: true,
        children: <Widget>[
          Container(
            child: _buildTitle(),
            padding: EdgeInsets.all(10.0),
          ),
          SizedBox(height: 30.0,),
          _buildNameInput(),
          SizedBox(height: 10.0,),
          _buildSobrenomeInput(),
          SizedBox(height: 10.0,),
          _buildUsernameInput(),
          SizedBox(height: 10.0,),
          _buildSenhaInput(),
          SizedBox(height: 40.0,),
          _buildButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
    );
  }
}