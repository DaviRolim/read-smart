import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/providers/highlights_provider.dart';
import 'package:read_smart/providers/sync_provider.dart';

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
            child: Card(
              margin: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                          style: TextStyle(color: Colors.grey[300]),
                          decoration: InputDecoration(
                              labelText: 'E-mail',
                              labelStyle: TextStyle(
                                  color: Colors.grey[600], fontSize: 14)),
                          onSaved: (value) {
                            _userEmail = value!;
                          },
                        ),
                        Row(children: [
                          Expanded(
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
                              style: TextStyle(color: Colors.grey[300]),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: Colors.grey[600], fontSize: 14),
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
                          ),
                        ]),
                         SizedBox(height: 12),
                  ElevatedButton(
                   child: Text('Sync Highlights'), 
                   onPressed: () {
                     bool isValid = _submissionIsValid();
                     if (isValid) {
                      ref.read(SyncProvider.syncProvider).syncHighlights(_userEmail, _userPassword);
                     }
                   }
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
