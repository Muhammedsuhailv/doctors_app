import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_textfield.dart';

class EditDoctor extends StatefulWidget {
  final String id;
  final String name;
  final String district;
  final String email;
  final String phone;
  final String gender;

  const EditDoctor({
    Key? key,
    required this.id,
    required this.name,
    required this.district,
    required this.email,
    required this.phone,
    required this.gender,
  }) : super(key: key);

  @override
  State<EditDoctor> createState() => _EditDoctorState();
}

class _EditDoctorState extends State<EditDoctor> {
  File? _image;
  final picker = ImagePicker();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? selectedDistrict;
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    emailController.text = widget.email;
    phoneController.text = widget.phone;
    selectedDistrict = widget.district;
    selectedGender = widget.gender;
  }

  Future<void> choiceImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  void updateDoctor() {
    final data = {
      'name': nameController.text,
      'phone': phoneController.text,
      'email': emailController.text,
      'district': selectedDistrict,
      'gender': selectedGender,
      'image': _image != null ? 'path/to/image' : null, // Update the path if needed
    };
    FirebaseFirestore.instance.collection('users').doc(widget.id).update(data);
  }

  void deleteDoctor() {
    FirebaseFirestore.instance.collection('users').doc(widget.id).delete().then((_) {
      Navigator.pop(context, true);
    });
  }

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
            onPressed: () {
              deleteDoctor();
            },
            icon: const Icon(Icons.delete),
            color: Colors.red,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundImage: _image != null
                        ? FileImage(_image!)

                        : const AssetImage("asset/profile.png") as ImageProvider,
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
                          onPressed: () {
                            choiceImage();
                          },
                          color: Colors.white,
                          icon: const Icon(Icons.edit),
                          iconSize: 14,
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextfield(
                cntrl: nameController,
                label: "Full Name",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomDropdown(
                hint: "District",
                items: const [
                  'Malappuram',
                  'Kozhikode',
                  'Wayanad',
                  'Kannur',
                  'Kasaragod'
                ],
                onChanged: (value) {
                  setState(() {
                    selectedDistrict = value;
                  });
                },
                value: selectedDistrict,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextfield(
                cntrl: emailController,
                label: "Email",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextfield(
                cntrl: phoneController,
                label: "Phone Number",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomDropdown(
                hint: "Gender",
                items: const ['Male', 'Female', 'Other'],
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
                value: selectedGender,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(const Color(0xff019744)),
                  minimumSize: MaterialStateProperty.all(
                      Size(screenWidth * 4, 50)), // Set width to 300
                ),
                onPressed: () {
                  updateDoctor();
                  Navigator.pop(context, true);
                },
                child: const Text(
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
