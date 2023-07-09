import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageRehabCenter extends StatefulWidget {
  const ManageRehabCenter({super.key});

  @override
  State<ManageRehabCenter> createState() => _ManageRehabCenterState();
}

class _ManageRehabCenterState extends State<ManageRehabCenter> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('Rehab_centers');
  Future<void> _delete(String productId) async {
    await _collectionReference.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a rehab center')));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Rehabs'),
        centerTitle: true,
        backgroundColor: Color(0XFF254C8F),
      ),
      body: StreamBuilder(
          stream: _collectionReference.orderBy("Timestamp", descending: false).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      isThreeLine: true,
                      leading: const Icon(Icons.home),
                      title: Text(documentSnapshot['rehab_center']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            documentSnapshot['executive_director'],
                          ),
                          Text(
                            documentSnapshot['phone'],
                          ),
                        ],
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: IconButton(
                            onPressed: () =>_delete(documentSnapshot.id),
                            icon: const Icon(Icons.delete)),
                      ),
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