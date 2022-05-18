import 'package:google_fonts/google_fonts.dart';
import 'package:read_smart/widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key});
  static const routeName = 'authscreen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Flexible(
                flex: 2,
                child: Center(
                  child: AuthForm(
                    isLogin: true,
                  ),
                )),
            Text(
              '-  OR  -',
              style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context).textTheme.headlineSmall),
            ),
            Flexible(
                flex: 1,
                child: Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 40,
                      child: ElevatedButton.icon(
                        onPressed: () => print('clicked'),
                        icon: Image.asset(
                          'assets/icons/g_logo.svg.webp',
                          height: 25,
                        ),
                        label: Text(
                          'Connect with Google',
                        ),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
