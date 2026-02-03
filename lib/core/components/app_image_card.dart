import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppImageCard extends StatelessWidget {
  final String imageUrl;
  const AppImageCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final placeHolders = Container(
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    );
    return AspectRatio(aspectRatio: 1,
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => placeHolders,
        errorWidget: (context, url, error) => placeHolders,
      ),
    ),);
  }
}
