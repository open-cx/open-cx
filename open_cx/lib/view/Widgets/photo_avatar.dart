import 'package:flutter/material.dart';

class PhotoAvatar extends StatelessWidget {

  final String photo;
  PhotoAvatar({
    @required this.photo
  });


  @override
  Widget build(BuildContext context) {
    return (
      CircleAvatar(
        backgroundImage: NetworkImage(photo),
        minRadius: 30,
      )
    );
  }
}