import 'package:flutter/material.dart';
import 'package:suflex/app/modules/login/sign-in.dart';
import 'package:suflex/app/modules/home/home-page.dart';
import 'package:suflex/kernel/services/login-service.dart';
import 'package:suflex/app/shared/widgets/custom_button.dart';
import 'package:suflex/app/shared/widgets/custom_text_input.dart';
import 'package:suflex/app/shared/widgets/custom-delayed-fade-in.dart';
import 'package:suflex/app/modules/profile/controllers/user-controller.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  void _handleSignUp() {

    if (_formKey.currentState.validate()) {

      Map<String, dynamic> userMap = {
        "nome": _nomeController.text.trim(),
        "sobrenome":_sobrenomeController.text.trim(),
        "username": _usernameController.text.toLowerCase().trim(),
        "senha": _senhaController.text.toLowerCase().trim(),
      };

      UserController().create(userMap)
        .then((user) {
          LoginService().signIn(
            _usernameController.text.toLowerCase().trim(),
            _senhaController.text.trim()
          )
            .then((res) => _onSuccess(res))
            .catchError((err) => _onFail(err));
        })
        .catchError((err) => _onFail(err));
    }
  }

  void _onSuccess(res) {

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage() ));
  }

  void _onFail(String err) {

    final SnackBar snackbar = SnackBar(
      content: Text(err),
      action: SnackBarAction(label: 'Ok', onPressed: () {}),
    );

    _scaffoldKey.currentState.showSnackBar(snackbar); 
  }

  Widget _buildNomeInput() {

    return CustomTextInput(
      label: 'Nome', 
      controller: _nomeController
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
      label: 'Usuário', 
      controller: _usernameController
    );
  }

  Widget _buildSenhaInput() {

    return CustomTextInput(
      label: 'Senha',
      obscureText: true,
      controller: _senhaController,
    );
  }

  Widget _buildSignUpButton() {

    final CustomButton button = CustomButton(
      label: 'Finalizar cadastro',
      onPressed: () => _handleSignUp(),
      width: MediaQuery.of(context).size.width,
    );

    return CustomDelayedFadeIn(
      delay: Duration(milliseconds: 1000),
      child: button,
    );
  }

  Widget _buildSignInButton() {

    final CustomButton button = CustomButton(
      label: 'Já possuo conta',
      color: Colors.transparent,
      fontColor: Colors.grey,
      width: MediaQuery.of(context).size.width,
      splashColor: Colors.grey.withOpacity(0.1),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignIn() )),
    );
    
    return CustomDelayedFadeIn(
      delay: Duration(milliseconds: 1100),
      child: button,
    );
  }

  Widget _buildForm() {

    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          _buildNomeInput(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          _buildSobrenomeInput(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          _buildUsernameInput(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          _buildSenhaInput(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          _buildSignUpButton(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          _buildSignInButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: _buildForm(),
        padding: EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}