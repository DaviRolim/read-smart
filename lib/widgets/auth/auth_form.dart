import 'package:flutter/material.dart';
import 'package:read_smart/models/failure.dart';
import 'package:read_smart/providers/auth_provider.dart';
import 'package:read_smart/screens/home_screen.dart';
import 'package:read_smart/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuthForm extends ConsumerStatefulWidget {
  final bool isLogin;
  const AuthForm({required this.isLogin, Key? key});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends ConsumerState<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final authRepository = AuthRepository();

  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  final authProvider = AuthProvider.authProvider;

  @override
  void dispose() {
    _pass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  bool _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!
          .save(); // Trigger the onSaved on every TextFormField
    }
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.transparent,
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!widget.isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        // Return string if error and if ok return nothing
                        if (value!.isEmpty || value.length < 4) {
                          return 'Please anter at least 4 characters.';
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Username',
                          hintText: 'Enter your Username',
                          ),
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('email'),
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    enableSuggestions: false,
                    validator: (value) {
                      // Return string if error and if ok return nothing
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please Enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Enter your email',
                      labelText: 'Email',
                    ),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    textInputAction: TextInputAction.next,
                    controller: _pass,
                    validator: (value) {
                      // Return string if error and if ok return nothing
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Enter your password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    obscureText: hidePassword,
                    onFieldSubmitted: (value) {},
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  if (!widget.isLogin)
                    TextFormField(
                        controller: _confirmPass,
                        textInputAction: TextInputAction.next,
                        key: ValueKey('password2'),
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hideConfirmPassword =
                                    !hideConfirmPassword;
                              });
                            },
                            icon: Icon(
                              hideConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        obscureText: hideConfirmPassword,
                        validator: (value) {
                          if (value != _pass.text) return 'Not Match';
                          return null;
                        }),
                  SizedBox(height: 65),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        bool isValid = _trySubmit();
                        if (isValid) {
                          try {
                            if (widget.isLogin) {
                              await ref
                                  .read(authProvider)
                                  .signInWithEmailAndPassword(
                                      _userEmail, _userPassword);
                            } else if (!widget.isLogin) {
                              await ref
                                  .read(authProvider)
                                  .signUpWithEmailAndPassword(
                                      _userEmail, _userPassword, _userName);
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Sucesso na autenticação'),
                                backgroundColor: Colors.green[400],
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            Navigator.of(context)
                                .pushReplacementNamed(HomeScreen.routeName);
                          } on Failure catch (failure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(failure.toString()),
                                backgroundColor: Colors.red[400],
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }
                      },
                      child: Text(widget.isLogin ? 'Login' : 'CREATE ACCOUNT', style: Theme.of(context).textTheme.bodyMedium,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
