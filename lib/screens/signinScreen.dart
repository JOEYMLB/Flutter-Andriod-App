
// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:csc315_term_project/poi_data.dart';
import 'package:flutter/material.dart';
import 'package:csc315_term_project/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:csc315_term_project/firebase_options.dart';
// import 'package:csc315_term_project/main.dart';
import 'package:csc315_term_project/screens/signupScreen.dart';
// import 'package:csc315_term_project/search.dart';




class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override 
  State<LoginScreen> createState() => _LoginScreenState();
}
  class _LoginScreenState extends State<LoginScreen>{
    String? email;
    String? password;
    String? error;
    final _formKey = GlobalKey<FormState>();
    UncwPoiData data = UncwPoiData();
    

    @override 
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(title: Text("UNCW POI APP"),backgroundColor: Colors.teal, ),
        body: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/uncw1.jpg'),))
          ,child: Padding
          (padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Enter your email',),
                    maxLength: 64,
                    onChanged: (value) => email = value,
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return 'Please enter some text';
                      }
                      return null;
                    }),
                  TextFormField(
                    decoration: const InputDecoration(hintText: "Enter a password"),
                    obscureText: true,
                    onChanged: (value) => password = value,
                    validator: (value){
                      if (value == null || value.length < 8){
                        return 'Your password must contain at least 8 characters';
                      }
                      return null;
                    }),
                  const SizedBox(height:16),
                  ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    child: const Text('Login'),
                    onPressed: (){
                      if (_formKey.currentState!.validate()){
                        tryLogin();
                      }
                    }),
                    if (error != null)
                      Text(
                        "Error: $error",
                        style: TextStyle(color:Colors.red[800], fontSize: 12)),
                  ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  child: Text("Sign up"),
                     onPressed: (){
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: ((context) => RegisterScreen())));
          }),
                  ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  child: Text("About"),
                     onPressed: (){
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: ((context) => About())));
          },),
          // OutlinedButton(
          //       onPressed: () => Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => MyCard(),//const SearchScreen(), 
          //           ),
          //       ),
          //       child: const Text("Search"))

                ]),
            ), ),
          ),
        )
      );
    }
    // Note the async keyword
  void tryLogin() async {
    try {
      // The await keyword blocks execution to wait for
      // signInWithEmailAndPassword to complete its asynchronous execution and
      // return a result.
      //
      // FirebaseAuth with raise an exception if the email or password
      // are determined to be invalid, e.g., the email doesn't exist.
      //
      // If this line executes without error, then we have successfully
      // logged in.
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      print("Logged in ${credential.user}");
      error = null; // clear the error message if exists.
      setState(() {}); // Call setstate to trigger a rebuild

      // We need this next check to use the Navigator in an async method.
      // It basically makes sure LoginScreen is still visible.
      if (!mounted) return;

      // pop the navigation stack so people cannot "go back" to the login screen
      // after logging in.
      Navigator.of(context).pop();
      // Now go to the HomeScreen.
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ListScreen(),//SearchScreen(),
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





Image uncwWidget(String imageName){
  return Image.asset(
    imageName,
    width:240,
    height:240,
     );
}


// class SignUpForm extends StatefulWidget {
//   const SignUpForm({super.key});

//   @override
//   State<SignUpForm> createState() => _SignUpFormState();
// }

// class _SignUpFormState extends State<SignUpForm> {
//   // These are our "state variables". They will be updated with the form fields' contents
//   // UncwPoiData data = UncwPoiData();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   String? error;
//   String? email;
//   String? password;

//   @override
//   Widget build(BuildContext context){
//       return Scaffold(
//         // appBar: AppBar(title: Text("UNCWPOI APP"),),
//         body: Padding
//         (padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(hintText: 'Enter your email'),
//                 maxLength: 64,
//                 onChanged: (value) => email = value,
//                 validator: (value){
//                   if (value == null || value.isEmpty){
//                     return 'Please enter some text';
//                   }
//                   return null;
//                 }),
//               TextFormField(
//                 decoration: const InputDecoration(hintText: "Enter a password"),
//                 obscureText: true,
//                 onChanged: (value) => password = value,
//                 validator: (value){
//                   if (value == null || value.length < 8){
//                     return 'Your password must contain at least 8 characters';
//                   }
//                   return null;
//                 }),
//               const SizedBox(height:16),
//               ElevatedButton(
//                 child: const Text('Login'),
//                 onPressed: (){
//                   if (_formKey.currentState!.validate()){
//                     //TODO:
//                     signUp();
//                   }
//                 }),
//                 if (error != null)
//                   Text(
//                     "Error: $error",
//                     style: TextStyle(color:Colors.red[800], fontSize: 12)),
//             ]), ),
//         )
//       );
//     }
//     Future signUp() async{
//       try{
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);

//       } on FirebaseAuthException catch (e){
//         print(e);
//       }
//       setState(() {
        
//       });
//     }
// }