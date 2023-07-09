import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_rehab/pages/homePage.dart';

class EnrollStreetKidPage extends StatefulWidget {
  const EnrollStreetKidPage({super.key});

  @override
  State<EnrollStreetKidPage> createState() => _EnrollStreetKidPageState();
}

class _EnrollStreetKidPageState extends State<EnrollStreetKidPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _residenceController = TextEditingController();
  final TextEditingController _guardianController = TextEditingController();
  final TextEditingController _rehabController = TextEditingController();
  final TextEditingController _healthController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  void sendDataToDB() async {
    CollectionReference addStreetChildrenCollection =
        FirebaseFirestore.instance.collection("Street_children");
        var currentUser = FirebaseAuth.instance.currentUser;
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    return addStreetChildrenCollection
        .doc(currentUser!.email).set({
          "name": _nameController.text,
          "residence": _residenceController.text,
          "guardian": _guardianController.text,
          "rehab_center": _rehabController.text,
          "gender": _genderController.text,
          "health": _healthController.text,
        })
        .then((value) => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const HomePage())))
        .catchError((error) =>
            Fluttertoast.showToast(msg: 'Something is wrong. $error'));
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Name';
    }
    // Add your custom logic here
    return null;
  }

  String? _validateResidence(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Residence';
    }
    // Add your custom logic here
    return null;
  }

  String? _validateGuardian(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a the guardian name';
    }
    // Add your custom logic here
    return null;
  }

  String? _validateRehab(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid Rehab Center';
    }
    // Add your custom logic here
    return null;
  }

  String? _validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a valid gender';
    }
    // Add your custom logic here
    return null;
  }

  String? _validateHealth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please input the Health details';
    }
    // Add your custom logic here
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enrollment'),
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
                      'Enter the Details of the child on enrollment',
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
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Full Name',
                      ),
                      validator: _validateName,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _residenceController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Area of Residence',
                      ),
                      validator: _validateResidence,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _guardianController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Assign Guardian',
                      ),
                      validator: _validateGuardian,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _rehabController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Assign a rehab center',
                      ),
                      validator: _validateRehab,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                    controller: _genderController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: 'Indicate the child\'s gender',
                    ),
                    validator: _validateGender,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _healthController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Health Details(A Brief Summary)',
                      ),
                      validator: _validateHealth,
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
                            'Biometric Information',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('FingerPrint Details'),
                        GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Scan FingerPrint',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Face ID details'),
                        GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Scan Face ID',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        //TODO: implement on Tap Logic
                        if (_formKey.currentState!.validate()) {
                          sendDataToDB();
                        _nameController.text = '';
                        _residenceController.text ='';
                        _guardianController.text = '';
                        _genderController.text = '';
                        _healthController.text = '';
                        _rehabController.text = '';
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0XFF254C8F),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                          child: Text('SAVE',style: TextStyle(color: Colors.white, ),),
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
