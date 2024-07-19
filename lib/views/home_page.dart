import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kayla_soft/views/edit_doctor.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("doctors");
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          SizedBox(
            width: 150,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: 'Gender',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                isDense: true,
              ),
              onChanged: (String? value) {},
              items: ['Male', 'Female', 'Other'].map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 150,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: 'District',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                isDense: true,
              ),
              onChanged: (String? value) {},
              items: [
                'Malappuram',
                'Kozhikode',
                'Wayanad',
                'Kannur',
                'Kasaragod'
              ].map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        title: const Text(
          "Doctors",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: collectionReference.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Container(
                          height: 100,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // doc['doctorImage'] != null
                                  //     ? Image.network(doc['doctorImage'],
                                  //   height: 80, width: 80,
                                  //   errorBuilder: (context, error, stackTrace) {
                                  //     return Placeholder(
                                  //       fallbackHeight: 80,
                                  //       fallbackWidth: 80,
                                  //     );
                                  //   },
                                  // )
                                  //     : Placeholder(
                                  //     fallbackHeight: 80,
                                  //     fallbackWidth: 80),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        Text(
                                          doc['name'] ?? 'No Name',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          doc['email'] ?? 'No Email',
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          doc['district'] ?? 'No District',
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditDoctor(
                                              id: doc.id,
                                              name: doc['name'] ?? '',
                                              district: doc['district'] ?? '',
                                              email: doc['email'] ?? '',
                                              phone: doc['phone'] ?? '',
                                              gender: doc['gender'] ?? '',
                                            ),
                                          ),
                                        ).then((result) {
                                          if (result != null && result) {
                                            // Trigger UI refresh if necessary
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: 65,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            color: const Color(0xff019744)),
                                        child: const Center(
                                            child: Text("Edit Profile",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white))),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff019744),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EditDoctor(
                id: '',
                name: '',
                district: '',
                email: '',
                phone: '',
                gender: '',
              )));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
