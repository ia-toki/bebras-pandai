import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlWithCachedImages extends StatelessWidget {
  final String data;

  const HtmlWithCachedImages({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      extensions: <HtmlExtension>[
        ImageExtension(
          builder: (ExtensionContext extensionContext) {
            final element = extensionContext.styledElement!;
            return CachedNetworkImage(
              imageUrl: element.attributes['src']!,
              fit: BoxFit.cover,
            );
          },
        ),
      ],
    );
  }
}
