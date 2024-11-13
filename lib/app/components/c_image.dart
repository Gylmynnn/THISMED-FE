import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thismed/app/utils/hellper/asset.dart';
import 'package:thismed/app/utils/hellper/layout.dart';

class CImage extends StatelessWidget {
  const CImage({
    super.key,
    required this.imgUrl,
    required this.width,
    required this.hight,
    this.boxFit,
  });
  final String imgUrl;
  final double hight;
  final double width;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      imageBuilder:
          (BuildContext context, ImageProvider<Object> imageProvider) {
        return Container(
          height: hight,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            image: DecorationImage(
              fit: boxFit,
              image: imageProvider,
            ),
          ),
        );
      },
      placeholder: (BuildContext context, String url) {
        return Shimmer(
          gradient: LinearGradient(
              colors: [Colors.grey.shade50, Colors.grey.shade200]),
          child: Center(
              child: SizedBox(
                  height: MediaQuerys.heightMQ / 2,
                  width: double.infinity,
                  child: Image.asset(Assets.mainLogo))),
        );
      },
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}



// return SizedBox(
//             height: hight,
//             width: width,
//             child: Shimmer.fromColors(
//                 baseColor: Colors.grey.shade300,
//                 highlightColor: Colors.grey.shade100,
//                 enabled: true,
//                 child: SizedBox(
//                   height: hight,
//                   width: width,
//                 )));
//
