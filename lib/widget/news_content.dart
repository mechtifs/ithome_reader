import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as html;
import 'package:html/parser.dart' as html;
import 'package:photo_view/photo_view.dart';
import 'package:ithome_reader/models/news_content.dart';
import 'package:ithome_reader/widget/network_image.dart';

class NewsContent extends StatelessWidget {
  const NewsContent({
    super.key,
    required this.htmlString,
    required this.tags,
  });

  final String htmlString;
  final List<Newstags> tags;

  TextStyle _getTextStyle(
    BuildContext context,
    String tagName,
    TextStyle textStyle,
  ) {
    switch (tagName) {
      case 'strong':
      case 'b':
        return textStyle.copyWith(
          fontWeight: FontWeight.bold,
        );
      case 'a':
        return textStyle.copyWith(
          color: Theme.of(context).colorScheme.primary,
          decoration: TextDecoration.underline,
        );
      case 'i':
      case 'italic':
        return textStyle.copyWith(
          fontStyle: FontStyle.italic,
        );
      case 'blockquote':
        return textStyle.copyWith(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
          fontStyle: FontStyle.italic,
        );
      case 'h2':
        return textStyle.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        );
      case 'h3':
        return textStyle.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        );
      case 'tr':
      case 'td':
      case 'li':
        return textStyle.copyWith(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
        );
      default:
        return textStyle;
    }
  }

  List<TextSpan> _getTextSpans(
    BuildContext context,
    List<html.Node> nodes,
    TextStyle textStyle,
  ) {
    final textSpans = <TextSpan>[];
    for (final node in nodes) {
      if (node is html.Text) {
        textSpans.add(
          TextSpan(
            text: node.text,
            style: textStyle,
          ),
        );
      } else if (node is html.Element) {
        final subTextStyle = _getTextStyle(context, node.localName!, textStyle);
        final childTextSpans = _getTextSpans(context, node.nodes, subTextStyle);
        textSpans.add(
          TextSpan(
            children: childTextSpans,
            style: subTextStyle,
          ),
        );
      }
    }
    return textSpans;
  }

  @override
  Widget build(BuildContext context) {
    final List<html.Node> nodes =
        html.parse(htmlString).getElementsByTagName('body').first.nodes;
    nodes.removeLast();
    final textStyle = Theme.of(context).textTheme.bodyLarge!;
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: SizedBox(
                  height: 32,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: tags.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 6,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: Text(
                                tags[index].keyword,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              for (html.Node node in nodes)
                if (node.children.isNotEmpty &&
                    node.children.first.localName == 'img')
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HeroPhotoViewRouteWrapper(
                            tag: node.children.first.attributes['src']!,
                          ),
                        ),
                      ),
                      child: Hero(
                        tag: node.children.first.attributes['src']!,
                        child: CustomNetworkImage(
                          url: node.children.first.attributes['src']!,
                        ),
                      ),
                    ),
                  )
                else
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: RichText(
                      text: TextSpan(
                        children: _getTextSpans(context, node.nodes, textStyle),
                      ),
                    ),
                  )
            ],
          ),
        ),
      ],
    );
  }
}

class HeroPhotoViewRouteWrapper extends StatelessWidget {
  const HeroPhotoViewRouteWrapper({
    super.key,
    required this.tag,
  });

  final String tag;

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      onTapDown: (context, details, controllerValue) =>
          Navigator.of(context).pop(),
      imageProvider: CachedNetworkImageProvider(tag),
      heroAttributes: PhotoViewHeroAttributes(tag: tag),
    );
  }
}
