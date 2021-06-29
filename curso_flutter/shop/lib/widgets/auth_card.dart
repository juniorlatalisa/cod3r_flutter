import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  const AuthCard();

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  bool _isLoading = false;
  bool _isValid = true;
  AuthMode _authMode = AuthMode.Login;
  GlobalKey<FormState> _form = GlobalKey();

  final _passwordController = TextEditingController();
  final Map<String, String> _authData = {
    'email': null,
    'password': null,
  };

  void _submit() {
    if (!_form.currentState.validate()) {
      setState(() => _isValid = false);
      return;
    }
    setState(() => _isLoading = true);
    _form.currentState.save();
    if (_authMode == AuthMode.Login) {
      //Login
    } else {
      //Registro
    }
  }

  void _switchAuthMode() {
    _form.currentState.reset();
    _isValid = true;
    setState(() => _authMode =
        (AuthMode.Login == _authMode) ? AuthMode.Signup : AuthMode.Login);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: _isLoading ? 100 : deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        height: _isLoading
            ? 100
            : ((AuthMode.Signup == _authMode ? 340 : 270) *
                (_isValid ? 1.0 : 1.2)),
        child: _isLoading
            ? CircularProgressIndicator(
                strokeWidth: 0.9,
              )
            : Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'e-mail'),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) => _authData['email'] = value,
                      validator: (value) => (value == null ||
                              value.isEmpty ||
                              !value.contains('@'))
                          ? 'Informe um e-mail válido!'
                          : null,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Senha'),
                      controller: _passwordController,
                      obscureText: true,
                      onSaved: (value) => _authData['password'] = value,
                      validator: (value) => (value == null || value.length < 5)
                          ? 'Informe uma senha válida!'
                          : null,
                    ),
                    if (_authMode == AuthMode.Signup)
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Confirmar senha'),
                        obscureText: true,
                        validator: (value) => (value == null ||
                                value.isEmpty ||
                                value != _passwordController.text)
                            ? 'Confirme a senha digitada'
                            : null,
                      ),
                    // SizedBox(height: 20),
                    Spacer(),
                    TextButton(
                      child: Text(
                        _authMode == AuthMode.Login ? 'Entrar' : 'Registrar',
                        style: TextStyle(
                            color: theme.primaryTextTheme.button.color),
                      ),
                      onPressed: _submit,
                      // style: ButtonStyle(
                      //   backgroundColor:
                      //       MaterialStateProperty.all<Color>(theme.primaryColor),
                      //   textStyle: MaterialStateProperty.all<TextStyle>(
                      //       theme.primaryTextTheme.button),
                      //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      //     RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(30),
                      //     ),
                      //   ),
                      // ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 8.0,
                        ),
                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    TextButton(
                      child: Text(
                        _authMode == AuthMode.Login ? 'Registrar' : 'Login',
                      ),
                      onPressed: _switchAuthMode,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
