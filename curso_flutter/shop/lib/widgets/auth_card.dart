import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  const AuthCard();

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  AuthMode _authMode = AuthMode.Login;
  final _passwordController = TextEditingController();
  final Map<String, String> _authData = {
    'email': null,
    'password': null,
  };

  void _submit() {
    print(_authMode);
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
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        height: 320,
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'e-mail'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => _authData['email'] = value,
                validator: (value) =>
                    (value == null || value.isEmpty || !value.contains('@'))
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
                  decoration: InputDecoration(labelText: 'Confirmar senha'),
                  controller: _passwordController,
                  obscureText: true,
                  onSaved: (value) => _authData['password'] = value,
                  validator: (value) =>
                      (value == null || value != _passwordController.text)
                          ? 'Informe uma senha válida!'
                          : null,
                ),
              SizedBox(height: 20),
              TextButton(
                child: Text(
                  _authMode == AuthMode.Login ? 'Entrar' : 'Registrar',
                  style: TextStyle(color: theme.primaryTextTheme.button.color),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
