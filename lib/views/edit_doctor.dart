import 'package:flutter/material.dart';

import '../widgets/custom_dropdown.dart';
import '../widgets/custom_textfield.dart';

class EditDoctor extends StatelessWidget {
  const EditDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text(
          "Edit Doctor",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon:const  Icon(Icons.delete),
            color: Colors.red,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          const  SizedBox(
              height: 30,
            ),
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                const   CircleAvatar(
                    backgroundImage: AssetImage("asset/profile.png"),
                    radius: 60,
                  ),
                  Positioned(
                    right: -5,
                    bottom: -3,
                    child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xff019744)),
                        child: IconButton(
                          onPressed: () {},
                          color: Colors.white,
                          icon: const Icon(Icons.edit),
                          iconSize: 14,
                        )),
                  ),
                ],
              ),
            ),
          const   SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextfield(
                label: "Full Name",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomDropdown(
                  hint: "District",
                  items:const  ['Malappuram', 'Kozhikode', 'Wayanad','Kannur','Kasaragod']),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextfield(
                label: "Email",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextfield(
                label: "Phone Number",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomDropdown(
                  hint: "Gender",
                  items: const ['Male','Female','Other']),
            ),
          const   SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff019744)),
                  minimumSize: MaterialStateProperty.all(Size(screenWidth * 4, 50)), // Set width to 300
                ),
                onPressed: () {},
                child:const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
