import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayla_soft/model/models.dart';

class DoctorsController extends ChangeNotifier {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  ///////////////////////////////////////////////////DOCTOR UPDATES//////////////////////////////////////////////////////////

  DoctorsModel? _doctorsModel;

  DoctorsModel get doctorsModel => _doctorsModel!;
  // File? _bookImage;
  //
  // File? get bookImage => _bookImage;
  //
  // final ImagePicker _picker = ImagePicker();
  //
  // Future<void> pickImage() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     _bookImage = File(pickedFile.path);
  //     notifyListeners();
  //   }
  // }

  Future uploadImage(File image) async {
    String fileName = await DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference =
    FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot storageTaskSnapshot = await uploadTask;
    String downloadURL = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> doctorUpdates(
      String doctorId,
      String fullName,
      String district,
      String email,
      String phoneNumber,
      String gender,
      File image,
      context) async {
    try {
      String userId = doctorId ?? '';
      String imageUrl = await uploadImage(image);

      await firebaseFirestore.collection('doctors').doc(userId).update({
        'doctorId': doctorId,
        'fullName': fullName,
        'district': district,
        'email': email,
        'phoneNumber': phoneNumber,
        'gender': gender
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(" details updated successfully")),
      );
    } catch (e) {
      print(
          '//////////////////////// DETAILS ERROR///////////////////////////');
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update  details. Please try again.")),
      );
    }

    notifyListeners();
  }


  String? _uid;
  String get uid => _uid!;
  Future<void> fetchUserData() async {
    try {
      print('///////////FETCHING USER DATA/////////////////////////////////');

      await firebaseFirestore
          .collection('users')
          .doc(doctorsModel.doctorId)
          .get()
          .then((DocumentSnapshot snapshot) {
        _doctorsModel = DoctorsModel(
            doctorId: snapshot['doctorId'],
            fullName: snapshot['fullName'],
            district: snapshot['district'],
            email: snapshot['email'],
            phoneNumber: snapshot['phoneNumber'],
            gender: snapshot['gender'],
            image: snapshot['image'] ?? ''

          // userid: snapshot['userid'],
          // username: snapshot['username'],
          // email: snapshot['email'],
          // petname: snapshot['petname'] ?? 'petname',
          // petsex: snapshot['petsex'] ?? 'petsex',
          // petage: snapshot['petage'] ?? 'petage',
          // breedname: snapshot['breedname'] ?? 'breedname',
          // petkg: snapshot['petkg'] ?? 'petkg',
          // aboutmypet: snapshot['aboutmypet'] ?? 'aboutmypet......',
          // image: snapshot['image'] ?? '',
        );
        _uid = doctorsModel.doctorId;
      });
    } catch (e) {
      print(e);
    }
  }
}
