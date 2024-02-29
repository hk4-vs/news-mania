import 'package:flutter/material.dart';
import 'package:news_app/data/models/news_model.dart';

import '../../utils/utils.dart';

class NewsPopupMenuWidget extends StatelessWidget {
  const NewsPopupMenuWidget({super.key, required this.articles});
  final Articles articles;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        child: const Icon(Icons.more_vert),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.bookmark_outline_rounded),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Save To Bookmarks",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cancel_presentation_rounded),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Hide This",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              onTap: () {
                 Utils.textShare("${articles.title}\n${articles.url}");
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.share),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Share This",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.report_outlined),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Report This",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ];
        });
  }
}
