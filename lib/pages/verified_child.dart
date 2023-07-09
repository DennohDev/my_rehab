import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VerifiedChild extends StatefulWidget {
  const VerifiedChild({super.key});

  @override
  State<VerifiedChild> createState() => _VerifiedChildState();
}

class _VerifiedChildState extends State<VerifiedChild> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('Street_children');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Enrollment'),
        centerTitle: true,
        backgroundColor: Color(0XFF254C8F),
      ),
      body: StreamBuilder(
        stream: _collectionReference.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: const Text(
                          'Street Child Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: const SizedBox(
                         child: Icon(Icons.person,size: 300,)),
                      ),
                      const SizedBox(height: 10),
                      Text("Name: " + documentSnapshot['name'], style: TextStyle(fontSize: 20),),
                      const SizedBox(height: 10),
                      Text("Gender: " + documentSnapshot['gender'], style: TextStyle(fontSize: 20),),
                      const SizedBox(height: 10),
                      Text("Residence: " + documentSnapshot['residence'], style: TextStyle(fontSize: 20),),
                      const SizedBox(height: 10),
                      Text("Current rehab center: " +
                          documentSnapshot['rehab_center'], style: TextStyle(fontSize: 20),),
                      const SizedBox(height: 10),
                      Text("Health Summary: " + documentSnapshot['health'], style: TextStyle(fontSize: 20),),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
