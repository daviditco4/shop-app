import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../error_dialog.dart';
import '../../models/auth/auth.dart';
import '../../models/exceptions/html_exception.dart';

enum AuthMode { signup, signin }

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  var _authMode = AuthMode.signin;
  final _authData = {'email': '', 'password': ''};
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState.validate()) {
      final auth = Provider.of<Auth>(context, listen: false);

      _formKey.currentState.save();
      setState(() => _isLoading = true);

      try {
        switch (_authMode) {
          case AuthMode.signup:
            await auth.signUp(_authData['email'], _authData['password']);
            break;
          case AuthMode.signin:
            await auth.signIn(_authData['email'], _authData['password']);
            break;
        }
      } on HtmlException catch (e) {
        var message = 'Check the email and password and try again.';

        if (e.message.contains('EMAIL_EXISTS')) {
          message = 'The email already exists.';
        } else if (e.message.contains('INVALID_EMAIL')) {
          message = 'The email is invalid.';
        } else if (e.message.contains('WEAK_PASSWORD')) {
          message = 'The password is too weak.';
        } else if (e.message.contains('EMAIL_NOT_FOUND')) {
          message = 'The email was not found.';
        } else if (e.message.contains('INVALID_PASSWORD')) {
          message = 'The password is invalid.';
        }

        showDialog<Null>(
          context: context,
          builder: (ctx) => buildErrorDialog(ctx, message),
        );
      } catch (e) {
        showDialog<Null>(context: context, builder: buildErrorDialog);
      }

      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const animationDuration = Duration(milliseconds: 300);
    const animationCurve = Curves.easeOut;
    final isSgnin = _authMode == AuthMode.signin;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: animationDuration,
        curve: animationCurve,
        width: MediaQuery.of(context).size.width * 0.75,
        height: isSgnin ? 260 : 320,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    return value.isEmpty || !value.contains('@')
                        ? 'Invalid email.'
                        : null;
                  },
                  onSaved: (value) => _authData['email'] = value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    return value.isEmpty || value.length < 5
                        ? 'Password is too short.'
                        : null;
                  },
                  onSaved: (value) => _authData['password'] = value,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                AnimatedCrossFade(
                  crossFadeState: isSgnin
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: animationDuration,
                  sizeCurve: animationCurve,
                  alignment: Alignment.bottomCenter,
                  firstChild: Container(),
                  secondChild: TextFormField(
                    validator: (value) {
                      return value != _passwordController.text
                          ? 'Passwords do not match.'
                          : null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                if (_isLoading)
                  const CircularProgressIndicator()
                else ...[
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(isSgnin ? 'Sign in' : 'Sign up'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _authMode = isSgnin ? AuthMode.signup : AuthMode.signin;
                      });
                    },
                    child: Text('${isSgnin ? 'Sign up' : 'Sign in'} instead'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
