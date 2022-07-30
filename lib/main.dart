import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/semantics.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiver/collection.dart';

// void main() {
//   runApp(MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FirstPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FlutterLogo(size: MediaQuery.of(context).size.height));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String errorMessage = '';
  bool isLoading = false;
  User? user = FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   super.initState();
  //   print('User: ' + user.toString());
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Group Chat App'),
            ),
            body: Center(
              child: Column(children: [
                // Log In Button
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Center(
                    child:
                        Text(errorMessage, style: TextStyle(color: Colors.red)),
                  ),
                ),
                ElevatedButton(
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Log In'),
                    onPressed: () async {
                      setState(() => isLoading = true);
                      //if (_key.currentState!.validate()) {
                      //try {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LogInPage()),
                      );
                      // } on FirebaseAuthException catch (error) {
                      //   errorMessage = error.message!;
                      // }
                      setState(() => isLoading = false);
                    }),

                // Sign Up Button
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Center(
                    child:
                        Text(errorMessage, style: TextStyle(color: Colors.red)),
                  ),
                ),
                ElevatedButton(
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Sign Up'),
                    onPressed: user != null
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                              errorMessage = '';
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()),
                            );
                            setState(() => isLoading = false);
                          }),

                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Center(
                    child:
                        Text(errorMessage, style: TextStyle(color: Colors.red)),
                  ),
                ),

                // Main Page Button
                ElevatedButton(
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Main Page'),
                    onPressed: user == null
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                              errorMessage = '';
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()),
                            );
                            setState(() => isLoading = false);
                          }),

                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Center(
                    child:
                        Text(errorMessage, style: TextStyle(color: Colors.red)),
                  ),
                ),

                // Profile Page Button
                ElevatedButton(
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Profile Page'),
                    onPressed: user == null
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                              errorMessage = '';
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()),
                            );
                            setState(() => isLoading = false);
                          }),
              ]),
              // Padding(
              //   padding: EdgeInsets.all(12.0),
              //   child: Center(
              //     child:
              //         Text(errorMessage, style: TextStyle(color: Colors.red)),
              //   ),
              // ),
              // ElevatedButton(
              //     child: isLoading
              //         ? CircularProgressIndicator(color: Colors.white)
              //         : Text('Log Out'),
              //     onPressed: () async {
              //       setState(() => isLoading = true);
              //       try {
              //         await FirebaseAuth.instance.signOut();
              //         errorMessage = '';
              //       } on FirebaseAuthException catch (error) {
              //         errorMessage = error.message!;
              //       }
              //       setState(() => isLoading = false);
              //     }),
              // Padding(
              //   padding: EdgeInsets.all(12.0),
              //   child: Center(
              //     child:
              //         Text(errorMessage, style: TextStyle(color: Colors.red)),
              //   ),
              // ),
              // ElevatedButton(
              //     child: isLoading
              //         ? CircularProgressIndicator(color: Colors.white)
              //         : Text('Home Page'),
              //     onPressed: () async {
              //       setState(() => isLoading = true);
              //       if (_key.currentState!.validate()) {
              //         try {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => const HomePage()),
              //           );
              //         } on FirebaseAuthException catch (error) {
              //           errorMessage = error.message!;
              //         }
              //         setState(() => isLoading = false);
              //       }
              //     }),
              // Padding(
              //   padding: EdgeInsets.all(12.0),
              //   child: Center(
              //     child:
              //         Text(errorMessage, style: TextStyle(color: Colors.red)),
              //   ),
              // ),
              // ElevatedButton(
              //     child: isLoading
              //         ? CircularProgressIndicator(color: Colors.white)
              //         : Text('User Profile'),
              //     onPressed: () async {
              //       setState(() => isLoading = true);
              //       if (_key.currentState!.validate()) {
              //         try {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => const Profile()),
              //           );
              //         } on FirebaseAuthException catch (error) {
              //           errorMessage = error.message!;
              //         }
              //         setState(() => isLoading = false);
              //       }
              //     }),
            )));
  }
}

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Login (Logged ' + (user == null ? 'out' : 'in') + ')'),
            //title: Text('Log In'),
          ),
          body: Form(
            key: _key,
            child: Center(
              child: Column(
                children: [
                  TextFormField(
                      controller: emailController,
                      validator: validateEmail,
                      decoration: InputDecoration(
                          hintText: ('Enter your email address'))),
                  TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: validatePassword,
                      decoration:
                          InputDecoration(hintText: ('Enter your password'))),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(errorMessage,
                          style: TextStyle(color: Colors.red)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(errorMessage,
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),
                      ElevatedButton(
                          child: isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text('Log In'),
                          onPressed: user != null
                              ? null
                              : () async {
                                  setState(() => isLoading = true);
                                  if (_key.currentState!.validate()) {
                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    } on FirebaseAuthException catch (error) {
                                      errorMessage = error.message!;
                                    }
                                    setState(() => isLoading = false);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MainPage()),
                                    );
                                  }
                                }),

                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(errorMessage,
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),
                      // Log out button
                      ElevatedButton(
                          child: isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text('Log Out'),
                          onPressed: user == null
                              ? null
                              : () async {
                                  setState(() => isLoading = true);
                                  try {
                                    await FirebaseAuth.instance.signOut();
                                    errorMessage = '';
                                  } on FirebaseAuthException catch (error) {
                                    errorMessage = error.message!;
                                  }
                                  setState(() => isLoading = false);
                                }),

                      // Back Button
                      ElevatedButton(
                          child: isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text('Back'),
                          onPressed: () async {
                            setState(() => isLoading = true);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            );
                          }),

                      // // Log Out Button
                      // ElevatedButton(
                      //     child: isLoading
                      //         ? CircularProgressIndicator(color: Colors.white)
                      //         : Text('Log Out'),
                      //     onPressed: user == null
                      //         ? null
                      //         : () async {
                      //             setState(() => isLoading = true);
                      //             try {
                      //               await FirebaseAuth.instance.signOut();
                      //               errorMessage = '';
                      //             } on FirebaseAuthException catch (error) {
                      //               errorMessage = error.message!;
                      //             }
                      //             setState(() => isLoading = false);
                      //           }),
                      // ElevatedButton(
                      //     child: isLoading
                      //         ? CircularProgressIndicator(color: Colors.white)
                      //         : Text('Home Page'),
                      //     onPressed: user != null
                      //         ? null
                      //         : () async {
                      //             setState(() => isLoading = true);
                      //             if (_key.currentState!.validate()) {
                      //               try {
                      //                 await FirebaseAuth.instance
                      //                     .signInWithEmailAndPassword(
                      //                   email: emailController.text,
                      //                   password: passwordController.text,
                      //                 );

                      //                 //getPosts();

                      //                 Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                       builder: (context) =>
                      //                           const HomePage()),
                      //                 );
                      //               } on FirebaseAuthException catch (error) {
                      //                 errorMessage = error.message!;
                      //               }
                      //               setState(() => isLoading = false);
                      //             }
                      //           }),
                      // ElevatedButton(
                      //     child: isLoading
                      //         ? CircularProgressIndicator(color: Colors.white)
                      //         : Text('User Profile'),
                      //     onPressed: user != null
                      //         ? null
                      //         : () async {
                      //             setState(() => isLoading = true);
                      //             if (_key.currentState!.validate()) {
                      //               try {
                      //                 await FirebaseAuth.instance
                      //                     .signInWithEmailAndPassword(
                      //                   email: emailController.text,
                      //                   password: passwordController.text,
                      //                 );

                      //                 //getPosts();

                      //                 Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                       builder: (context) =>
                      //                           const Profile()),
                      //                 );
                      //               } on FirebaseAuthException catch (error) {
                      //                 errorMessage = error.message!;
                      //               }
                      //               setState(() => isLoading = false);
                      //             }
                      //           }),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

// // Verify Email Page
// class Verify extends StatefulWidget {
//   const Verify({Key? key}) : super(key: key);

//   @override
//   State<Verify> createState() => _VerifyState();
// }

// class _VerifyState extends State<Verify> {
//   final auth = FirebaseAuth.instance;
//   late User user;
//   late Timer timer;

//   @override
//   void initState() {
//     user = auth.currentUser!;
//     print(user);
//     user.sendEmailVerification();

//     timer = Timer.periodic(Duration(seconds: 5), (timer) {
//       // print(timer.tick);
//       Future verified = checkVerification(user, timer, context);
//       print(verified);
//       checkVerification(user, timer, context);
//     });
//   }

//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Verify Email Address'),
//         ),
//         body: Center(
//             child: Text(
//                 'Please click the link sent to ${user.email} to verify your email address')));
//   }
// }

// Verification Confirmation Page
// class Verified extends StatefulWidget {
//   const Verified({Key? key}) : super(key: key);

//   @override
//   State<Verified> createState() => _VerifiedState();
// }

// class _VerifiedState extends State<Verified> {
//   final auth = FirebaseAuth.instance;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(
//               title: Text(
//                   'User profile has been created. Please follow the link sent to the provided email address to verify you email!'),
//             ),
//             body: Center(
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                   ElevatedButton(
//                       child: isLoading
//                           ? CircularProgressIndicator(color: Colors.white)
//                           : Text('Log In'),
//                       onPressed: () async {
//                         setState(() {
//                           isLoading = true;
//                         });
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const SecondScreen()),
//                         );
//                         setState(() => isLoading = false);
//                       }),
//                 ]))));
//   }
// }

// Sign Up Page
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  // final userRoleController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  String errorMessage = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Sign Up'),
          ),
          body: Form(
            key: _key,
            child: Center(
              child: Column(
                children: [
                  TextFormField(
                      controller: emailController,
                      validator: validateEmail,
                      decoration: InputDecoration(
                          hintText: ('Enter your email address'))),
                  TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: validatePassword,
                      decoration:
                          InputDecoration(hintText: ('Enter a password'))),
                  TextFormField(
                      controller: userNameController,
                      validator: validateUser,
                      decoration:
                          InputDecoration(hintText: ('Enter a username'))),
                  TextFormField(
                      controller: firstNameController,
                      validator: validateName,
                      decoration:
                          InputDecoration(hintText: ('Enter your first name'))),
                  TextFormField(
                      controller: lastNameController,
                      validator: validateName,
                      decoration:
                          InputDecoration(hintText: ('Enter your last name'))),
                  // TextFormField(
                  //     controller: userRoleController,
                  //     // validator: validateUserRole,
                  //     decoration:
                  //         InputDecoration(hintText: ('Enter your user role'))),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(errorMessage,
                          style: TextStyle(color: Colors.red)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          child: isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text('Sign Up'),
                          onPressed: user != null
                              ? null
                              : () async {
                                  setState(() {
                                    isLoading = true;
                                    errorMessage = '';
                                  });

                                  if (_key.currentState!.validate()) {
                                    try {
                                      UserCredential result = await FirebaseAuth
                                          .instance
                                          .createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                      user = result.user;

                                      //if (userRoleController.text == '') {
                                      await DatabaseService(uid: user!.uid)
                                          .updateUserData(
                                        userNameController.text,
                                        firstNameController.text,
                                        lastNameController.text,
                                        // 'Customer',
                                      );

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()),
                                      );
                                      //} else {
                                      // await DatabaseService(uid: user!.uid)
                                      //     .updateUserData(
                                      //   userNameController.text,
                                      //   firstNameController.text,
                                      //   lastNameController.text,
                                      //   //  userRoleController.text,
                                      // );
                                      //}
                                      // Create a new document for the user with the uid

                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           const Verified()),
                                      // );
                                    } on FirebaseAuthException catch (error) {
                                      errorMessage = error.message!;
                                    }

                                    setState(() => isLoading = false);
                                  }
                                }),
                      ElevatedButton(
                          child: isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text('Back'),
                          onPressed: () async {
                            setState(() => isLoading = true);
                            try {
                              await FirebaseAuth.instance.signOut();
                              errorMessage = '';
                            } on FirebaseAuthException catch (error) {
                              errorMessage = error.message!;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            );
                            setState(() => isLoading = false);
                          }),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  User? user = FirebaseAuth.instance.currentUser;
  String errorMessage = '';
  bool isLoading = false;
  List chats = [];
  List userNames = [];
  List result = [];
  List groupResults = [];
  List docID = [];
  String? tempDocID;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Future<List> getChats() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('chats');

    //Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //print('All Data:' + allData.toString());
    chats = allData;
    //print('Chats: ' + chats.toString());

    for (var i = 0; i < chats.length; i++) {
      //var tempDocID = await DatabaseService(uid: user!.uid)
      //    .updateChatsData(chats[i]['users'], chats[i]['messages']);
      //print('Document: ' + doc.toString());
      userNames.add(chats[i]['users']);
      //docID.add(tempDocID);
      //print('Chats: ' + chats[i]['users'].toString());

    }
    //print('User Names: ' + userNames.toString());
    return userNames;

    //return chats;
    //}
  }

  Future<List> getResult(input) async {
    List tempList = [];
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('user');

    QuerySnapshot querySnapshot = await _collectionRef.get();

    final List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //print('All Data: ' + allData.toString());
    tempList = allData;
    //print('tempList[0]: ' + tempList[0]['userName'].toString());
    for (var i = 0; i < tempList.length; i++) {
      if (input == tempList[i]['userName']) {
        if (result.isEmpty) {
          result.add(tempList[i]['userName']);
        } else {
          result = [];
          result.add(tempList[i]['userName']);
        }
      }
    }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(groupUsers: userNames),
        ));
    //print('Results: ' + result.toString());
    return result;
  }

  // Future<void> tempID(int i, List list) async {
  //   tempDocID = list[i];
  //   print(tempDocID);
  // }

  // Future<List> getUserNames() async {
  //   for (var i = 0; i < chats.length; i++) {
  //     userNames.add(chats[i]['users']);
  //     //print('Chats: ' + chats[i]['users'].toString());
  //     print('User Names: ' + userNames.toString());
  //   }
  //   return userNames;
  // }

  @override
  void initState() {
    super.initState();
    //getChats();
    //getUserNames();
    //print('User Names: ' + userNames.toString());
  }

  @override
  Widget build(BuildContext context) {
    // return Container();

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('Previous Chats')),
            body: Form(
                key: _key,
                child: Center(
                    child: SingleChildScrollView(
                        child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(errorMessage,
                                style: TextStyle(color: Colors.red)),
                          ),
                        ),
                        // Search Button
                        ElevatedButton(
                            child: isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text('Search'),
                            onPressed: () async {
                              setState(() => isLoading = true);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchPage()),
                              );
                              setState(() => isLoading = false);
                            }),

                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(errorMessage,
                                style: TextStyle(color: Colors.red)),
                          ),
                        ),
                        // Home Page Button
                        ElevatedButton(
                            child: isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text('Home Page'),
                            onPressed: () async {
                              setState(() => isLoading = true);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
                              setState(() => isLoading = false);
                            }),
                      ]),
                  FutureBuilder<List>(
                      future: getChats(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<dynamic>> snapshot) {
                        // AsyncSnapshot<Your object type>
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: Text('Please wait its loading...'));
                        } else {
                          if (snapshot.hasError)
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          else {
                            return Card(
                              // onTap: () =>
                              //     //getResult(item),
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) =>
                              //               ChatPage(groupUsers: userNames),
                              //         )),
                              //child: Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  // Search results
                                  for (var item in userNames)
                                    (GestureDetector(
                                      onTap: () =>
                                          //getResult(item),
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatPage(groupUsers: item),
                                              )),
                                      child: Card(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              leading: Icon(
                                                  Icons.account_circle,
                                                  size: 50),
                                              title: Text(item.toString()),
                                              subtitle: Text('Click to open'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),

                                  Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Center(
                                          child: Text(errorMessage,
                                              style: TextStyle(
                                                  color: Colors.red)))),
                                ],
                              ),
                              //),
                            );
                          }
                        }
                      })
                ]))))));
  }
}

// Search Page
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  String errorMessage = '';
  bool isLoading = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  List result = [];
  List groupResults = [];
  List chats = [];
  String docID = '';

  Future<List> getResult(input) async {
    List tempList = [];
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('user');

    QuerySnapshot querySnapshot = await _collectionRef.get();

    final List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //print('All Data: ' + allData.toString());
    tempList = allData;
    //print('tempList[0]: ' + tempList[0]['userName'].toString());
    for (var i = 0; i < tempList.length; i++) {
      if (input == tempList[i]['userName']) {
        if (result.isEmpty) {
          result.add(tempList[i]['userName']);
        } else {
          result = [];
          result.add(tempList[i]['userName']);
        }
      }
    }

    //print('Results: ' + result.toString());
    return result;
  }

  Future<List> addToGroup() async {
    if (!groupResults.contains(result[0])) {
      //print('Group Results: ' + groupResults.contains(result[0]).toString());
      groupResults.add(result[0]);
    }
    //print('Group Results: ' + groupResults.toString());
    return groupResults;
  }

  void initState() {
    super.initState();
    //print('Temporary List: ' + tempList.toString());

    // Compare sizes and values of users and each doc in tempList[users]
    // Only create new doc if users value do not match any in tempList

    //getResult('text');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('Search')),
            body: ListView(children: [
              Form(
                  key: _key,
                  child: Center(
                      child: Column(children: [
                    TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(hintText: ('Search'))),

                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(errorMessage,
                            style: TextStyle(color: Colors.red)),
                      ),
                    ),
                    // Search Page Button
                    ElevatedButton(
                        child: isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text('Back'),
                        onPressed: () async {
                          setState(() => isLoading = true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()),
                          );
                        }),

                    Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                            child: Text(errorMessage,
                                style: TextStyle(color: Colors.red)))),

                    // Initiate Search Button
                    ElevatedButton(
                        child: isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text('Search'),
                        onPressed: () async {
                          setState(() => isLoading = true);
                          try {
                            getResult(searchController.text);
                          } on FirebaseAuthException catch (error) {
                            errorMessage = error.message!;
                          }
                          setState(() => isLoading = false);
                        }),

                    Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                            child: Text(errorMessage,
                                style: TextStyle(color: Colors.red)))),

                    // Start Chat Button
                    ElevatedButton(
                        child: isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text('Start Chat'),
                        onPressed: () async {
                          setState(() => isLoading = true);
                          try {
                            if (!groupResults.isEmpty) {
                              //getResult(searchController.text);
                              // createChat();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChatPage(groupUsers: groupResults),
                                  ));
                            }
                          } on FirebaseAuthException catch (error) {
                            errorMessage = error.message!;
                          }

                          setState(() => isLoading = false);
                        }),
                  ]))),
              FutureBuilder<List>(
                  future: getResult(searchController.text),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<dynamic>> snapshot) {
                    // AsyncSnapshot<Your object type>
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Text('Please wait its loading...'));
                    } else {
                      if (snapshot.hasError)
                        return Center(child: Text('Error: ${snapshot.error}'));
                      else {
                        return GestureDetector(
                          onTap: () => addToGroup(),
                          child: Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // Search results
                                ListTile(
                                  leading: Icon(Icons.account_circle, size: 50),
                                  title: Text(result.toString()),
                                  subtitle: Text('Click to add to chat'),
                                ),

                                Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Center(
                                        child: Text(errorMessage,
                                            style:
                                                TextStyle(color: Colors.red)))),
                                // Selected Users
                                ListTile(
                                  leading: Icon(Icons.account_circle, size: 50),
                                  title: Text(
                                      'Selected Users:  (Click \'Search\' to update this list)'),
                                  subtitle: Text(groupResults.toString()),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }
                  })
            ])));
    //   for (var item in results)
    //     GestureDetector(
    //       onTap: () => () => [],
    //       child: Card(
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: <Widget>[
    //             ListTile(
    //               leading: Icon(Icons.account_circle, size: 50),
    //               title: Text(item.toString()),
    //               subtitle: Text(item.toString()),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    // ]
    // // Let the ListView know how many items it needs to build.
    // itemCount: 2,
    // // Provide a builder function. This is where the magic happens.
    // // Convert each item into a widget based on the type of item it is.
    // itemBuilder: (context, index) {
    //   final item = results2[index];

    //   return ListTile(
    //       title: Text('Title Text1'),
    //       subtitle: Text('Title Text1'));
    // })
    //   //  Form(
    //   //     key: _key,
    //   //     child: Center(
    //   //         child: Column(children: [
    //   //       TextFormField(
    //   //           controller: searchController,
    //   //           decoration: InputDecoration(hintText: ('Search'))),
    //   //       Padding(
    //   //           padding: EdgeInsets.all(12.0),
    //   //           child: Center(
    //   //               child: Text(errorMessage,
    //   //                   style: TextStyle(color: Colors.red)))),

    // GestureDetector(
    //   onTap: () => () => [],
    //   child: Card(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: <Widget>[
    //         const ListTile(
    //           leading: Icon(Icons.account_circle, size: 50),
    //           title: Text('Title Text'),
    //           subtitle: Text('Secondary Text'),
    //         ),
    //       ],
    //     ),
    //   ),
    // ),
    // ]))),
    // ));
  }
}

// Chat Page
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.groupUsers}) : super(key: key);

  final List groupUsers;

  @override
  State<ChatPage> createState() => _ChatPageState(this.groupUsers);
}

class _ChatPageState extends State<ChatPage> {
  List groupUsers;

  _ChatPageState(this.groupUsers);

  String? docID;
  User? user = FirebaseAuth.instance.currentUser;
  var messageController = TextEditingController();
  // List users = chat.getUsers();
  List messages = [];
  String? userName;
  String errorMessage = '';
  bool isLoading = false;
  var chat = [];
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Future<List> getInitialMessages() async {
    // var doesExist;
    // checkChatCollection().then((val) {
    //   doesExist = val;
    //   //print('');
    //   //print('Does Exist: ' + doesExist.toString());
    //   if (doesExist == false) {
    //     createChat();
    //     messages = [];
    //   }
    // });

    var doesExist = await checkChatCollection();
    if (doesExist == false) {
      createChat();
      //messages = [];
    }
    return messages;
  }

  Future<bool> checkChatCollection() async {
    List chats = [];
    var doc;
    bool exists = false;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('chats');

    QuerySnapshot querySnapshot = await _collectionRef.get();

    //for (var doc in querySnapshot.docs) {

    //docID = doc.id;
    // QueryDocumentSnapshot<Object?> currentChat =
    //     doc.data() as QueryDocumentSnapshot<Object?>;
    // if (currentChat != null) {
    //   if (groupUsers.length == currentChat['users'].length) {
    //     if (listsEqual(groupUsers, currentChat['users']) == true) {
    //       exists = true;
    //       doc = currentChat as QueryDocumentSnapshot<Object?>;
    //       messages = currentChat['messages'];
    //       docID = doc.id;
    //       print('Document: ' + doc.toString());
    //       print('');
    //       print('Existing Messages: ' + messages.toString());
    //       print('');
    //       print('Document ID' + docID.toString());

    //       //print('Existing Messages: ' + messages.toString());
    //     }
    //   }
    // }
    //}
    //return exists;

    final List realData = querySnapshot.docs.map((doc) {
      List allData = [];
      var allData2 = doc.id;
      var allData3 = doc.data();
      allData.add(allData2);
      allData.add(allData3);
      return allData;
      //doc.data();
    }).toList() as List;
    //print('Real data: ' + realData.toString());
    //print('All Data: ' + allData.toString());
    chats = realData;

    for (var i = 0; i < chats.length; i++) {
      // print('Chats at [i][1]: ' + chats[i][1].toString());
      // print('Users at [i]: ' + chats[i][1]['users'].toString());
      // print('Messages at [i]: ' + chats[i][1]['messages'].toString());
      // print('Group Users: ' + groupUsers.toString());
      // print('');
      // print('');
      // print('');
      if (groupUsers.length == chats[i][1]['users'].length) {
        if (listsEqual(groupUsers, chats[i][1]['users']) == true) {
          exists = true;
          doc = chats[i][1];
          messages = chats[i][1]['messages'];
          docID = chats[i][0];
          //print('Document ID: ' + docID.toString());
          //print('Existing Messages: ' + messages.toString());
        }
      }
    }
    //print('Messages: ' + messages.toString());
    return exists;
  }

  Future<void> createChat() async {
    var tempDoc = await DatabaseService(uid: user!.uid).addChatsData(
      groupUsers,
      messages,
    );

    docID = tempDoc;
    //print('Document: ' + tempDoc.toString());
  }

  Future<void> updateChat() async {
    var tempDoc = await DatabaseService(uid: user!.uid).updateChatsData(
      groupUsers,
      messages,
      docID,
    );
  }

  //print('Results: ' + result.toString());

  @override
  void initState() {
    super.initState();
    // var doesExist;
    // checkChatCollection().then((val) {
    //   doesExist = val;
    //   //print('');
    //   //print('Does Exist: ' + doesExist.toString());
    //   if (doesExist == false) {
    //     createChat();
    //     messages = [];
    //   }
    // });

    //createChat();
    //  print('Users: ' + users.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                //title: Text('Text'),
                title: Text(groupUsers.toString())),
            body: ListView(children: [
              Form(
                  key: _key,
                  child: Center(
                      child: SingleChildScrollView(
                          child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(errorMessage,
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),
                      // Search Page Button
                      ElevatedButton(
                          child: isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text('Back'),
                          onPressed: () async {
                            setState(() => isLoading = true);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SearchPage()),
                            );
                          }),

                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(errorMessage,
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),
                      // Search Page Button
                      ElevatedButton(
                          child: isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text('Previous Chats'),
                          onPressed: () async {
                            setState(() => isLoading = true);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()),
                            );
                          }),

                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(errorMessage,
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),

                      ElevatedButton(
                          child: isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text('Send'),
                          onPressed: () async {
                            setState(() => isLoading = true);
                            try {
                              if (messageController.text != null) {
                                messages.add(messageController.text);
                                updateChat();
                                print('Messages: ' + messages.toString());
                                setState(() => isLoading = true);
                                Text('Messages: ' + messages.toString());
                                // createChat();
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => ChatPage(groupUsers: groupResults)),
                                // );
                              }
                            } on FirebaseAuthException catch (error) {
                              errorMessage = error.message!;
                            }
                            setState(() => isLoading = false);
                          }),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(errorMessage,
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(errorMessage,
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),

                      TextFormField(
                          controller: messageController,
                          decoration:
                              InputDecoration(hintText: ('Type a message'))),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(errorMessage,
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),

                      // GestureDetector(
                      //   onTap: () => () => [],
                      //   child: Card(
                      //       child: Column(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: <Widget>[
                      //         // Search results
                      //         for (var i = 0; i < messages.length; i++)
                      //           (ListTile(
                      //             leading: Icon(Icons.account_circle, size: 50),
                      //             title: Text(messages[i].toString()),
                      //             //subtitle: Text('Click to open chat'),
                      //           ))
                      //       ])),
                      // ),

                      FutureBuilder<List>(
                          future: getInitialMessages(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<dynamic>> snapshot) {
                            // AsyncSnapshot<Your object type>
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: Text('Please wait its loading...'));
                            } else {
                              if (snapshot.hasError)
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              else {
                                return GestureDetector(
                                  onTap: () => () => [],
                                  child: Card(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        // Search results
                                        for (var i = 0;
                                            i < messages.length;
                                            i++)
                                          (ListTile(
                                            leading: Icon(Icons.account_circle,
                                                size: 50),
                                            title: Text(messages[i].toString()),
                                            subtitle:
                                                Text('Click to open chat'),
                                          )),

                                        Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: Center(
                                                child: Text(errorMessage,
                                                    style: TextStyle(
                                                        color: Colors.red)))),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }
                          })
                    ],
                  ))))
            ])));
  }
}

// // Previous Chat Page
// class PreviousChatPage extends StatefulWidget {
//   const PreviousChatPage({Key? key, required this.docID}) : super(key: key);

//   final String docID;

//   @override
//   _PreviousChatPageState createState() => _PreviousChatPageState(this.docID);
// }

// class _PreviousChatPageState extends State<ChatPage> {
//   List users = [];

//   _PreviousChatPageState(_docID) {
//     docID = _docID;
//   }

//   String? docID;
//   User? user = FirebaseAuth.instance.currentUser;
//   var messageController = TextEditingController();
//   String? userName;
//   String errorMessage = '';
//   bool isLoading = false;
//   final GlobalKey<FormState> _key = GlobalKey<FormState>();

//   // Future<void> createChat() async {
//   //   var tempDoc = await DatabaseService(uid: user!.uid).updateChatsData(
//   //     users,
//   //     [],
//   //   );

//   //   docID = tempDoc;
//   //   //print('Document: ' + tempDoc.toString());
//   // }

//   //print('Results: ' + result.toString());

//   @override
//   void initState() {
//     super.initState();
//     //createChat();
//     //  print('Users: ' + users.toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(
//               title: Text(users.toString()),
//               //title: Text(userName.toString())
//             ),
//             body: Form(
//                 key: _key,
//                 child: Center(
//                     child: Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(12.0),
//                       child: Center(
//                         child: Text(errorMessage,
//                             style: TextStyle(color: Colors.red)),
//                       ),
//                     ),
//                     // Search Page Button
//                     ElevatedButton(
//                         child: isLoading
//                             ? CircularProgressIndicator(color: Colors.white)
//                             : Text('Search Page'),
//                         onPressed: () async {
//                           setState(() => isLoading = true);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const SearchPage()),
//                           );
//                         }),

//                     Padding(
//                       padding: EdgeInsets.all(12.0),
//                       child: Center(
//                         child: Text(errorMessage,
//                             style: TextStyle(color: Colors.red)),
//                       ),
//                     ),

//                     ElevatedButton(
//                         child: isLoading
//                             ? CircularProgressIndicator(color: Colors.white)
//                             : Text('Send'),
//                         onPressed: () async {
//                           setState(() => isLoading = true);
//                         }),

//                     Padding(
//                       padding: EdgeInsets.all(12.0),
//                       child: Center(
//                         child: Text(errorMessage,
//                             style: TextStyle(color: Colors.red)),
//                       ),
//                     ),

//                     TextFormField(
//                         controller: messageController,
//                         decoration:
//                             InputDecoration(hintText: ('Type a message'))),
//                     Padding(
//                       padding: EdgeInsets.all(12.0),
//                       child: Center(
//                         child: Text(errorMessage,
//                             style: TextStyle(color: Colors.red)),
//                       ),
//                     ),
//                   ],
//                 )))));
//   }
// }

// Profile Page
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  late String? uid = user?.uid.toString();
  String? userName;
  String errorMessage = '';
  bool isLoading = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  var userInfo = [];
  late String? emailAddress = user?.email.toString();
  List tempList = [];

  @override

  // Get current user
  Future<void> getUser() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('user');

    QuerySnapshot querySnapshot = await _collectionRef.get();

    final List allData =
        querySnapshot.docs.map((doc) => doc.data()).toList() as List;
    //print('All Data: ' + allData.toString());
    userInfo = allData;
    //print('All Data: ' + allData.toString());
    //print('User Info: ' + userInfo.toString());
  }

  Future<void> getUserDoc() async {
    List users = [];
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('user');

    QuerySnapshot querySnapshot = await _collectionRef.get();

    //for (var doc in querySnapshot.docs) {

    //docID = doc.id;
    // QueryDocumentSnapshot<Object?> currentChat =
    //     doc.data() as QueryDocumentSnapshot<Object?>;
    // if (currentChat != null) {
    //   if (groupUsers.length == currentChat['users'].length) {
    //     if (listsEqual(groupUsers, currentChat['users']) == true) {
    //       exists = true;
    //       doc = currentChat as QueryDocumentSnapshot<Object?>;
    //       messages = currentChat['messages'];
    //       docID = doc.id;
    //       print('Document: ' + doc.toString());
    //       print('');
    //       print('Existing Messages: ' + messages.toString());
    //       print('');
    //       print('Document ID' + docID.toString());

    //       //print('Existing Messages: ' + messages.toString());
    //     }
    //   }
    // }
    //}
    //return exists;

    final List realData = querySnapshot.docs.map((doc) {
      List allData = [];
      var allData2 = doc.id;
      var allData3 = doc.data();
      allData.add(allData2);
      allData.add(allData3);
      //print('All Data: ' + allData.toString());
      return allData;
      //doc.data();
    }).toList() as List;
    // print('');
    // print('Real data: ' + realData.toString());

    users = realData;
    // print('Users: ' + users.toString());
    // print('');
    // print('Current User ID: ' + uid.toString());
    // print('');
    // print('');

    for (var i = 0; i < users.length; i++) {
      // print('Users at [i][1]: ' + users[i][1].toString());
      // print('First Names at [i]: ' + users[i][1]['firstName'].toString());
      // print('Last Names at [i]: ' + users[i][1]['lasName'].toString());
      // print('Usernames: ' + users[i][1]['useName'].toString());
      // print('');
      // print('');
      // print('');
      String userUid = users[i][0];
      // print('');
      // print('Current ID: ' + uid.toString());
      // print('Document ID: ' + userUid.toString());
      // print('');
      if (uid == userUid) {
        // print('User Info Before: ' + userInfo.toString());
        // userInfo.add(users[i][1]);
        // print('Users[i][1]: ' + users[i][1].toString());
        // print('');
        // print('User Info After: ' + userInfo.toString());
        break;
      }
    }
  }

  //Get current username
  Future<void> getUserName() async {}

  void initState() {
    super.initState();
    //print('User: ' + user.toString());
    //getUser();
    getUserDoc();
    //print('Current User: ' + currentUser.toString());
    //print('Results in initState(): ' + this.results.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('Your Profile')),
            body: ListView(children: [
              Form(
                  key: _key,
                  child: Center(
                      child: SingleChildScrollView(
                          child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Center(
                              child: Text(errorMessage,
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ),
                          // Search Button
                          ElevatedButton(
                              child: isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white)
                                  : Text('Search'),
                              onPressed: () async {
                                setState(() => isLoading = true);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SearchPage()),
                                );
                                setState(() => isLoading = false);
                              }),

                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Center(
                              child: Text(errorMessage,
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ),
                          // Home Page Button
                          ElevatedButton(
                              child: isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white)
                                  : Text('Home Page'),
                              onPressed: () async {
                                setState(() => isLoading = true);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                );
                                setState(() => isLoading = false);
                              }),
                        ]),
                    GestureDetector(
                      onTap: () => () => [],
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Center(
                                    child: Text(errorMessage,
                                        style: TextStyle(color: Colors.red)))),
                            // Selected Users

                            ListTile(
                              leading: Icon(Icons.account_circle, size: 50),
                              title: Text(userInfo[0].toString()),
                              subtitle: Text('User Info'),
                            ),

                            ListTile(
                              leading: Icon(Icons.account_circle, size: 50),
                              title: Text(emailAddress.toString()),
                              subtitle: Text('Email Address'),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]))))
            ])));
  }
}

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userProfile =
      FirebaseFirestore.instance.collection('user');

  final CollectionReference userChats =
      FirebaseFirestore.instance.collection('chats');

  Future updateUserData(
    String userName,
    String firstName,
    String lastName,
  ) async {
    return await userProfile.doc(uid).set({
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
    });
  }

  Future addChatsData(
    List users,
    List messages,
  ) async {
    //Retrieve chat collection from Firebase

    var tempDoc = await userChats.add({
      'users': users,
      'messages': messages,
    });
    //print('Temporary Doc: ' + tempDoc.toString());
    return tempDoc.id;
  }

  Future updateChatsData(
    List users,
    List messages,
    String? docID,
  ) async {
    //Retrieve chat collection from Firebase

    var tempDoc = await userChats.doc(docID).set({
      'users': users,
      'messages': messages,
    });
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'Email Address is required.';

  String pattern = r'\w+@\w.|w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid Email Address';
  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty)
    return 'Password is required.';

  String pattern =
      // r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
      r'.{7,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword))
    return '''
    Password must be at least 7 characters.''';
  return null;
}

String? validateUser(String? formUser) {
  if (formUser == null || formUser.isEmpty) return 'Username is required';

  String pattern =
      // r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
      r'.{3,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formUser))
    return '''
    Username must be at least 3 characters.''';
  return null;
}

String? validateName(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) return 'Name is required.';

  String pattern = r'\w.{1,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword))
    return '''
    Name must only contain letters.''';
  return null;
}

String? validateUserRole(String? formUserRole) {
  if (formUserRole == null || formUserRole.isEmpty)
    return formUserRole = 'Customer';

  String pattern = r'\w.{,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formUserRole!))
    return '''
    Name must only contain letters.''';
  return formUserRole;
}
