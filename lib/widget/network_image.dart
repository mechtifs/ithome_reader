import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.uri,
  });

  final String uri;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(20),
      child: CachedNetworkImage(
        imageUrl: uri,
        fit: BoxFit.fill,
        errorWidget: (context, url, error) => const Icon(Icons.error_outline),
        progressIndicatorBuilder: (context, url, progress) =>
            Center(child: CircularProgressIndicator(value: progress.progress)),
      ),
    );
  }
}

class DefaultAvatar extends StatelessWidget {
  const DefaultAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Icon(
        Icons.person_outlined,
        size: 24,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

class CustomNetworkAvatar extends StatelessWidget {
  const CustomNetworkAvatar({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.fill,
        errorWidget: (context, url, error) => const DefaultAvatar(),
        placeholder: (context, url) => const DefaultAvatar(),
      ),
    );
  }
}
