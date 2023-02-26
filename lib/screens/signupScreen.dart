// import 'package:csc315_term_project/firestore_add.dart';
// import 'package:csc315_term_project/firestore_add.dart';
import 'package:csc315_term_project/screens/signinScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csc315_term_project/poi_data.dart';

import '../main.dart';
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up"),backgroundColor: Colors.teal,),
      body: const Padding(padding: EdgeInsets.all(12), child: SignUpForm()),
    );
  }
}

// We are creating a custom StatefulWidget that will compose the Form
// and its child input elements. We need a StatefulWidget because the elements
// drawn on the screen will change in response to user input.
class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // These are our "state variables". They will be updated with the form fields' 
  UncwPoiData data = UncwPoiData();
  bool isChecked = false;
  String? email;
  String? password;
  String? error;

  // This key is essentially a random, unique value that will allow Flutter
  // and us (the developers) to access this particular Form widget from
  // anywhere in the app. We need such a unique key to enable
  // Flutter's built-in form validation support.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // The Form widget is invisible, but it groups other widgets.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
              decoration: const InputDecoration(
                  hintText:
                      'Enter your email'), // Place "hint" text inside the field.
              maxLength:
                  64, // Limits the number of characters and provides a counter.
              onChanged: (value) => email = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null; // Returning null is good - it means "no issue with this field"
              }),
          TextFormField(
              decoration: const InputDecoration(hintText: "Enter a password"),
              obscureText: true, // Show obscuring dots rather than characters.
              onChanged: (value) => password = value,
              validator: (value) {
                if (value == null || value.length < 8) {
                  return 'Your password must contain at least 8 characters.';
                }
                return null; // Returning null is good - it means "no issue with this field"
              }),
          Row(
            children: [
              Checkbox(
                value:
                    isChecked, // The Checkbox's appaearance depends on the value of isChecked
                onChanged: (value) {
                  isChecked = value!; // Update the state
                  setState(
                      () {}); // We need to trigger a rebuild of our Form because the checkbox changed.
                },
              ),
              const Text("I agree to the Terms and Conditions of this site.")
            ],
          ),
          if (!isChecked)
            Text(
              "You must accept the Terms and Conditions to proceed.",
              style: TextStyle(color: Colors.red[800], fontSize: 12),
            ),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text('Submit'),
              onPressed: () {
                // Here is where we want to validate the form.
                // If all of the form contents are valid (fields filled in and checkbox checked), then do something.
                // If any of the form contents are invalid, display error messages to the user.
                if (_formKey.currentState!.validate() && isChecked) {
                  // This calls all validators() inside the form for us.
                  signUp();
                    
                  
                }
              })
        ],
      ),
    );
  }
  Future signUp() async{
      try{
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
 // ignore: avoid_print
 print("Logged in ${credential.user}");
      error = null; // clear the error message if exists.
      setState(() {}); // Call setstate to trigger a rebuild

      // We need this next check to use the Navigator in an async method.
      // It basically makes sure LoginScreen is still visible.
      if (!mounted) return;

      // pop the navigation stack so people cannot "go back" to the login screen
      // after logging in.
      // Navigator.of(context).pop();
      // Now go to the HomeScreen.
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ));
    } on FirebaseAuthException catch (e) {
      // Exceptions are raised if the Firebase Auth service
      // encounters an error. We need to display these to the user.
      if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided for that user.';
      } else {
        error = 'An error occurred: ${e.message}';
      }

      // Call setState to redraw the widget, which will display
      // the updated error text.
      setState(() {});
    }
  }
    }



