import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/providers/highlights_provider.dart';
import 'package:read_smart/providers/sync_provider.dart';
import 'package:read_smart/screens/home_screen.dart';

class SyncHighlightsScreen extends ConsumerStatefulWidget {
  const SyncHighlightsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SyncHighlightsScreen> createState() =>
      _SyncHighlightsScreenState();
}

class _SyncHighlightsScreenState extends ConsumerState<SyncHighlightsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  bool hidePassword = true;
  var _userEmail = '';
  var _userPassword = '';
  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  bool _submissionIsValid() {
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
    final syncState = ref.watch(SyncProvider.syncProvider).state;
    return syncState == NotifierState.loading
        ? CircularProgressIndicator()
        : Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 45,
                          height: 45,
                          child: Image.asset('assets/icons/amazon-logo.png')),
                      SizedBox(height: 15),
                      Text('Sync Using Amazon Credentials',
                          style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: 15),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
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
                                labelText: 'E-mail',
                              ),
                              onSaved: (value) {
                                _userEmail = value!;
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              key: ValueKey('password'),
                              textInputAction: TextInputAction.next,
                              controller: _pass,
                              validator: (value) {
                                // Return string if error and if ok return nothing
                                if (value!.isEmpty || value.length < 7) {
                                  return 'Password must be at least 8 characters long.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
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
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              obscureText: hidePassword,
                              onFieldSubmitted: (value) {},
                              onSaved: (value) {
                                _userPassword = value!;
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                          child: Text('Sync Highlights'),
                          onPressed: () {
                            bool isValid = _submissionIsValid();
                            if (isValid) {
                              ref
                                  .read(SyncProvider.syncProvider)
                                  .syncHighlights(_userEmail, _userPassword);
                              Navigator.of(context)
                                  .pushReplacementNamed(HomeScreen.routeName);
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
