import 'package:flutter/material.dart';

class NewsNetworkImage extends StatelessWidget {
  const NewsNetworkImage({
    super.key,
    required this.uri,
  });

  final String uri;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        uri,
        fit: BoxFit.fill,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return LinearProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            );
          }
        },
      ),
    );
  }
}
