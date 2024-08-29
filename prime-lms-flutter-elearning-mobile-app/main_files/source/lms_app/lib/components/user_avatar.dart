import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.imageUrl, this.imageByte, this.iconSize, this.radius});

  final String? imageUrl;
  final Uint8List? imageByte;
  final double? iconSize;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius ?? 30,
      width: radius ?? 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade300,
        image: (imageByte != null) ? DecorationImage(
          image: MemoryImage(imageByte!),
          fit: BoxFit.cover,
        ) : null
      ),
      child: (imageUrl == null || imageUrl == "" && imageByte == null) ? Icon(
        LineIcons.user,
        size: iconSize ?? 18,
      ) : Image.network(imageUrl!),
    );
  }
}
