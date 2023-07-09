import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_rehab/pages/homePage.dart';

class AddRehabPage extends StatefulWidget {
  const AddRehabPage({super.key});

  @override
  State<AddRehabPage> createState() => _AddRehabPageState();
}

class _AddRehabPageState extends State<AddRehabPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _rehabCenterController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _executiveDirectorController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void sendDataToDB() async {
    CollectionReference addRehabCenterCollection =
        FirebaseFirestore.instance.collection("Rehab_centers");
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    return addRehabCenterCollection
        .add({
          "rehab_center": _rehabCenterController.text,
          "location": _locationController.text,
          "executive_director": _executiveDirectorController.text,
          "email": _emailController.text,
          "phone": _phoneController.text,
          "Timestamp": DateTime.now().toString(),
        })
        .then((value) => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const HomePage())))
        .catchError((error) =>
            Fluttertoast.showToast(msg: 'Something is wrong. $error'));
  }

  String? _validateRehab(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the rehab name';
    }
    // Add your custom logic here
    return null;
  }

  String? _validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a the Rehab\'s Location';
    }
    // Add your custom logic here
    return null;
  }

  String? _validateExecutiveDirector(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the executive directors name';
    }
    // Add your custom logic here
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid Email';
    }
    // Add your custom logic here
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid phone number';
    }
    // Add your custom logic here
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Rehab Center'),
        centerTitle: true,
        backgroundColor: Color(0XFF254C8F),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Enter the details of the new rehab center',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _rehabCenterController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Name of the center',
                      ),
                      validator: _validateRehab,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Rehab\'s area of Location',
                      ),
                      validator: _validateLocation,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _executiveDirectorController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Executive Director',
                      ),
                      validator: _validateExecutiveDirector,
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Contact Details',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Rehab\'s Email Address',
                      ),
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Rehab\'s phone contact',
                      ),
                      validator: _validatePhone,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () async{
                        if (_formKey.currentState!.validate()) {
                          sendDataToDB();
                          _rehabCenterController.text = '';
                          _locationController.text = '';
                          _executiveDirectorController.text = '';
                          _emailController.text='';
                          _phoneController.text='';
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0XFF254C8F),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 10),
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
