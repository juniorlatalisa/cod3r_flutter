import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/providers/auth.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  const AuthCard();

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  bool _isValid = true;
  AuthMode _authMode = AuthMode.Login;
  GlobalKey<FormState> _form = GlobalKey();

  AnimationController _controller;
  // Animation<Size> _heightAnimation;
  Animation<double> _opacityAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    this._controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    //   this._heightAnimation = Tween(
    //     begin: Size(double.infinity, 290),
    //     end: Size(double.infinity, 371),
    //   ).animate(CurvedAnimation(
    //     parent: _controller,
    //     curve: Curves.linear,
    //   ));
    this._opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    this._slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    // _heightAnimation.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  final _passwordController = TextEditingController();
  final Map<String, String> _authData = {
    'email': null,
    'password': null,
  };

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Erro'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_form.currentState.validate()) {
      setState(() => _isValid = false);
      return;
    }
    setState(() => _isLoading = true);
    _form.currentState.save();
    final Auth auth = Provider.of(context, listen: false);

    try {
      if (_authMode == AuthMode.Login) {
        await auth.signin(_authData['email'], _authData['password']);
      } else {
        await auth.signup(_authData['email'], _authData['password']);
      }
    } on AuthException catch (e) {
      _showErrorDialog(e.toString());
    } catch (e) {
      _showErrorDialog('Erro inesperado: ' + e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _switchAuthMode() {
    _form.currentState.reset();
    _isValid = true;
    setState(() => _authMode =
        (AuthMode.Login == _authMode) ? AuthMode.Signup : AuthMode.Login);
    if (AuthMode.Login == _authMode) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        width: _isLoading ? 100 : deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        height: _isLoading
            ? 100
            : ((AuthMode.Signup == _authMode ? 380 : 310) *
                (_isValid ? 1.0 : 1.2)),
        child: _isLoading
            ? const CircularProgressIndicator(
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
                    // if (_authMode == AuthMode.Signup)
                    AnimatedContainer(
                      constraints: BoxConstraints(
                        minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                        maxHeight: _authMode == AuthMode.Signup ? 120 : 0,
                      ),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Confirmar senha'),
                            obscureText: true,
                            validator: (value) => (value == null ||
                                    value.isEmpty ||
                                    value != _passwordController.text)
                                ? 'Confirme a senha digitada'
                                : null,
                          ),
                        ),
                      ),
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
