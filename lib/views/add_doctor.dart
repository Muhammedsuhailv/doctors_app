import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_textfield.dart';

class AddDoc extends StatefulWidget {
  const AddDoc({Key? key}) : super(key: key);

  @override
  State<AddDoc> createState() => _AddDocState();
}

class _AddDocState extends State<AddDoc> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String selectedDistrict = 'District';
  String? selectedGender = 'Gender';
  File? _imageFile;

  Future<String> uploadImage(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = reference.putFile(image);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
      } else {
        _imageFile = null;
      }
    });
  }

  void addDoctor(String imageUrl, String district, String gender) {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        imageUrl.isEmpty ||
        district.isEmpty ||
        gender.isEmpty) {
      print("One or more fields are empty.");
      return;
    }

    CollectionReference collectionReference = FirebaseFirestore.instance.collection("users");
    final data = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'doctorImage': imageUrl,
      'district': district,
      'gender': gender,
    };
    collectionReference.add(data);

    // then((docRef) {
    //   print("Doctor added with ID: ${docRef.id}");
    // }).catchError((error) {
    //   print("Error adding doctor: $error");
    // });
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
          "Add Doctor",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
            color: Colors.red,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Center(
                child: _imageFile == null
                    ? Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStatePropertyAll(
                                  HexColor("54E70F"))),
                          onPressed: () =>
                              _pickImage(ImageSource.gallery),
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.cyan,
                      radius: 50,
                      child: ClipOval(
                        child: Container(
                          height: 105,
                          width: 105,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(104),
                          ),
                          child: Image.file(_imageFile!, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStatePropertyAll(
                                HexColor("54E70F"))),
                        onPressed: () =>
                            _pickImage(ImageSource.gallery),
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
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
                      selectedDistrict = value!;
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
                    backgroundColor: MaterialStateProperty.all(const Color(0xff019744)),
                    minimumSize: MaterialStateProperty.all(Size(screenWidth * 0.8, 50)), // Adjust width as needed
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (_imageFile != null) {
                        String imageUrl = await uploadImage(_imageFile!);
                        addDoctor(imageUrl, selectedDistrict, selectedGender!);
                        Navigator.pop(context);
                        print("Doctor added successfully!");
                      } else {
                        print("Please select an image.");
                      }
                    } else {
                      print("Please fill in all required fields.");
                    }
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
      ),
    );
  }
}
