import 'package:flutter/material.dart';
import 'package:suflex/app/modules/home/home-page.dart';
import 'package:suflex/app/modules/login/sign-up.dart';
import 'package:suflex/app/shared/widgets/custom_button.dart';
import 'package:suflex/app/shared/widgets/custom_text_input.dart';
import 'package:suflex/app/shared/widgets/custom-delayed-fade-in.dart';
import 'package:suflex/kernel/services/login-service.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {

    super.initState();
  }

  void _handleSignIn() {

    if (_formKey.currentState.validate()) {
      LoginService().signIn(
        _usernameController.text.toLowerCase().trim(),
        _senhaController.text.trim(),
      )
      .then((value) => _onSuccess())
      .catchError((onError) => _onFail(onError.toString()));
    }
  }

  void _onSuccess() {

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomePage()), (Route<dynamic> route) => false);
  }

  void _onFail(String error) {

    final SnackBar snackbar = SnackBar(
      content: Text(error),
      action: SnackBarAction(label: 'Ok', onPressed: () {}),
    );

    _scaffoldKey.currentState.showSnackBar(snackbar);
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

  Widget _buildSignInButton() {

    return CustomButton(
      label: 'Entrar',
      width: MediaQuery.of(context).size.width,
      onPressed: () => _handleSignIn(),
    );
  }

  Widget _buildSignUpButton() {

    final CustomButton button = CustomButton(
      color: Colors.transparent,
      fontColor: Colors.grey,
      label: 'Ainda não possuo conta',
      width: MediaQuery.of(context).size.width,
      splashColor: Colors.grey.withOpacity(0.1),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignUp())),
    );
    
    return CustomDelayedFadeIn(
      delay: Duration(milliseconds: 1000),
      child: button,
    );
  }

  Widget _buildForm() {

    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(15),
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
          _buildUsernameInput(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          _buildSenhaInput(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
          _buildSignInButton(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
          _buildSignUpButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: _buildForm(),
    );
  }
}