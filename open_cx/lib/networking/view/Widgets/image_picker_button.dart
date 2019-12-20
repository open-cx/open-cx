import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerButton extends StatefulWidget {
  final Function onPressed;
  final radius;

  ImagePickerButton(this.onPressed, this.radius);

  @override
  _ImagePickerButtonState createState() =>
      _ImagePickerButtonState(this.onPressed, this.radius);
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  final Function onPressed;
  final radius;

  _ImagePickerButtonState(this.onPressed, this.radius);

  takePic() async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text("Select profile picture source.",
            style: Theme.of(context).textTheme.body2),
        children: <Widget>[
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildButton(cameraText(), ImageSource.camera),
                buildButton(galleryText(), ImageSource.gallery),
              ]),
        ],
      ),
    );

    onPressed(source);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: radius * 2,
        height: radius * 0.6,
        child: Opacity(
          opacity: 0.3,
          child: RawMaterialButton(
            fillColor: Theme.of(context).colorScheme.primaryVariant,
            shape: BeveledRectangleBorder(),
            elevation: 0.0,
            child: Icon(Icons.camera_alt, color: Theme.of(context).canvasColor),
            onPressed: takePic,
          ),
        ));
  }

  Widget cameraText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Camera',
          style: Theme.of(context).textTheme.button,
        ),
        Icon(Icons.camera_alt, color: Theme.of(context).canvasColor),
      ],
    );
  }

  Widget galleryText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Gallery',
          style: Theme.of(context).textTheme.button,
        ),
        Icon(Icons.photo, color: Theme.of(context).canvasColor),
      ],
    );
  }

  buildButton(Widget child, ImageSource ret) {
    return  MaterialButton(
          color: Theme.of(context).colorScheme.primaryVariant,
          child: Padding(
            padding: EdgeInsets.all(3.0),
            child: child,
          ),
          onPressed: () => Navigator.pop(context, ret),
        );
  }
}
