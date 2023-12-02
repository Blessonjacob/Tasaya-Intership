import 'dart:io';

class User {
  late int id;
  String? name;
  String? email;
  String phoneNumber;
  String password;
  File? imageFile;
  User({
    this.name,
   this.email,
  required  this.phoneNumber,
    required this.password,
    this.imageFile,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'imageFilePath': imageFile?.path,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
        name: map['name'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        imageFile:
            map['imageFilePath'] != null ? File(map['imageFilePath']) : null,
        password: '');
  }
}
