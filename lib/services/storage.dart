import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageService {
  final String uid;
  final _storage = FirebaseStorage.instance;
  final _picker = ImagePicker();
  StorageService({this.uid});
  PickedFile image;

  Future uploadProfileImage() async {
    try {
      //Verificar permiso para Fotos
      await Permission.photos.request();
      var permissionStatus = await Permission.photos.status;
      if (permissionStatus.isGranted) {
        //Seleccionamos la imagen a subir
        image = await _picker.getImage(source: ImageSource.gallery);
        var file = File(image.path);
        if (image != null) {
          //Upload to Firebase
          var snapshot =
              await _storage.ref().child('$uid/profileImage').putFile(file);
          return snapshot;
        }
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future getProfileImage() async {
    try {
      return await _storage
          .ref()
          .child('$uid/profileImage.jpg')
          .getDownloadURL();
    } catch (error) {
      return null;
    }
  }
}
