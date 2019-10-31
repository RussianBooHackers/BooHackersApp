import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Image widget with placeholder.
/// Wrap around CachedNetworkImage with Shimmer placeholder.
/// Display image from given [url]. Example: [ITImage('https://your_image.png')]
/// You can manually configure heigth of Image([heigth]), width od Image([width]) and circular border radius([borderRadius])
/// {@category Widgets}
class ITImage extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final String url;
  const ITImage(this.url,
      {Key key, this.height, this.width, this.borderRadius = 0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: new BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: url ??
              "https://via.placeholder.com/640x480.png?text=Изображение+отсутствует",
          fit: BoxFit.cover,
          errorWidget: (context, str, obj) => CachedNetworkImage(
              imageUrl: url ??
                  "https://via.placeholder.com/640x480.png?text=Не+удалось+загрузить+изображение"),
          placeholder: (context, url) => Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius)),
            child: Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.grey[100],
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.1),
                ),
              ),
            ),
          ),
        ));
  }
}
