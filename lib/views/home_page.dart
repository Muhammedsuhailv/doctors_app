import 'package:flutter/material.dart';
import 'add_doctor.dart';
import 'doctors_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          SizedBox(
            width: 150, // Adjust width as needed
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: 'Gender',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none, // No border
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Adjust padding
                isDense: true, // Reduces the dropdown's height
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
            width: 150, // Adjust width as needed
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: 'District',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none, // No border
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Adjust padding
                isDense: true, // Reduces the dropdown's height
              ),
              onChanged: (String? value) {},
              items: ['Malappuram', 'Kozhikode', 'Wayanad', 'Kannur', 'Kasaragod']
                  .map((String item) {
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
          Expanded(
            child: ListView.builder(
              itemCount: doctorsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      height: 100,
                      width: screenWidth * 3,
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
                              Image(image: doctorsList[index]['image']),
                              const SizedBox(width: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    doctorsList[index]['name'],
                                    style: const TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    doctorsList[index]['education'],
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                  Text(
                                    doctorsList[index]['location'],
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddDoctor()));
                                  },
                                  child: Container(
                                    width: 65,
                                    height: 20,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color(0xff019744)),
                                    child: Center(child: const Text("Edit Profile", style: TextStyle(fontSize: 10, color: Colors.white))),
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff019744),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddDoctor()));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
