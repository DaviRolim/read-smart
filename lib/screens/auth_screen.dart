import 'package:google_fonts/google_fonts.dart';
import 'package:read_smart/helpers/custom_page_route.dart';
import 'package:read_smart/providers/auth_provider.dart';
import 'package:read_smart/repository/auth_repository.dart';
import 'package:read_smart/screens/home_screen.dart';
import 'package:read_smart/widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  AuthScreen({required this.isLogin, Key? key});
  static const routeName = 'authscreen';
  final bool isLogin;

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  bool _isLogin = false;
  @override
  void initState() {
    // TODO: implement initState
    _isLogin = widget.isLogin;
    super.initState();
  }

  void toggleIsLogin() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 25,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(15),
                child: Card(
                  elevation: 3,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Welcome!',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Login to continue',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Center(
                        child: AuthForm(
                          isLogin: _isLogin,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Or Login with ',
                              style: GoogleFonts.openSans(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).colorScheme.onPrimary),
                              child: IconButton(
                                onPressed: () async {
                                  try{
                                    await ref.read(AuthProvider.authProvider).signInWithGoogle();
                                    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                                  } catch (failure) {
                                    print(failure.toString());
                                  }


                                } ,
                                icon: Image.asset(
                                  'assets/icons/g_logo.svg.webp',
                                  height: 25,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () => toggleIsLogin(),
                child: Text(
                  widget.isLogin ? 'New User? Sign Up' : 'Already an user? Sign In',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.onSecondary),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
