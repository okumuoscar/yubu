import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(
    String name, String email, String phone, String message) async {
  final response = await http.post(
    Uri.parse('http://192.168.18.5:8000/api/question_create/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'phone': phone,
      'message': message,
    }),
  );
  print(response.body);

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,then parse the JSON.

    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 201 CREATED response,then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String message;

  const Album(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.message});

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'email': String email,
        'phone': String phone,
        'message': String message,
      } =>
        Album(
          id: id,
          name: name,
          email: email,
          phone: phone,
          message: message,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String name = "";
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        appBar: AppBar(
          title:const Text(
            "YUBU - Survey App",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
          ),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "You are welcome !",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    const Text(
                      "What's your question",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _nameController,
                      decoration: InputDecoration(
                          labelText: "Enter your name",
                          labelStyle: TextStyle(color: Colors.green),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(5.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(5.5)),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.green,
                          )),
                      // validator: (value) {
                      //   if (value!.isEmpty ||
                      //       RegExp(r'^[a-z A-Z]').hasMatch(value!)) {
                      //     return "Enter correct name";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: "Enter your email",
                          labelStyle: TextStyle(color: Colors.green),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(5.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(5.5)),
                          prefixIcon: const Icon(
                            Icons.mail,
                            color: Colors.green,
                          )),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return "Please enter valid email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      controller: _phoneController,
                      decoration: InputDecoration(
                          labelText: "Enter your number",
                          labelStyle: TextStyle(color: Colors.green),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(5.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(5.5)),
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.green,
                          )),
                      validator: (value) {
                        if (value!.isEmpty ||
                            RegExp(r'^[a-z A-Z]').hasMatch(value!)) {
                          return "Enter correct name";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _messageController,
                      minLines: 1,
                      maxLines: 20,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 60),
                          hintText: "Type your inquiry here...",
                          hintStyle: const TextStyle(
                            color: Colors.green,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(5.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(5.5)),
                          prefixIcon: const Icon(
                            Icons.mail,
                            color: Colors.green,
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                           if (formKey.currentState!.validate()) {
                        setState(() {
                          _simulateLoading(() {
                            _futureAlbum = createAlbum(
                              _nameController.text,
                              _emailController.text,
                              _phoneController.text,
                              _messageController.text,
                            );
                            _showConfirmationDialog();
                            _clearFormFields();
                          }, Colors.green);
                        });
                      }
                        },
                        child: Container(
                          width: double.infinity,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Send",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                )),
          ),
        ));
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return Text('hey');
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const SizedBox.shrink();
      },
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text("Submission Successful"),
          content:const Text("Your information has been submitted successfully."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // _simulateLoading(() {
                //   setState(() {
                //     _futureAlbum = null;
                //   });
                // });
              },
              child:const Text("OK", style: TextStyle(color: Colors.green),),
            ),
          ],
        );
      },
    );
  }

  void _clearFormFields() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _messageController.clear();
  }

  // Function to simulate loading with a delay
  void _simulateLoading(Function callback, Color progressColor) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              ),
              const SizedBox(height: 20),
              const Text("Submitting..."),
            ],
          ),
        );
      },
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context); // Close the loading dialog
      callback(); // Execute the callback function
    });
  }
}
