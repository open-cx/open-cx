import 'dart:io';
import 'package:communio/view/Widgets/image_picker_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File image;
  bool _loaded = false;

  picker(source) async {
    if (source != null) {
      final File img = await ImagePicker.pickImage(source: source);
      if (img != null) {
        setState(() {
          image = img;
          _loaded = true;
        });
      }
    }
  }

  bool _isLoaded() {
    return _loaded;
  }

  @override
  Widget build(BuildContext context) {
    final radius = MediaQuery.of(context).size.width * 0.25;
    final _borderWidth = 2.0;

    return Center(
        child: Container(
            padding: EdgeInsets.all(_borderWidth),
            decoration: new BoxDecoration(
              color: Theme.of(context).buttonColor,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
                child: CircleAvatar(
                    backgroundColor: Theme.of(context).canvasColor,
                    radius: radius,
                    child: Stack(children: <Widget>[
                      Align(
                          alignment: Alignment.center,
                          child: _isLoaded()
                              ? Image.file(
                                  image,
                                  width: radius * 2,
                                  height: radius * 2,
                                  fit: BoxFit.cover,
                                )
                              : defaultPicture(radius)),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ImagePickerButton(picker, radius),
                      )
                    ])))));
  }

  Widget defaultPicture(radius) {
    return Padding(
        padding: EdgeInsets.only(bottom: radius * 0.5),
        child: Icon(
          Icons.person,
          size: radius,
          color: Theme.of(context).colorScheme.secondaryVariant,
        ));
  }
}
