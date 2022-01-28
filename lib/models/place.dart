import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Place {
  final String id;
  final String title;
  final String location;
  final String imageUrl;

  const Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.imageUrl,
  });
}
