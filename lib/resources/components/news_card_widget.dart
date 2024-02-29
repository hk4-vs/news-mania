import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/resources/components/network_image_widget.dart';

import '../../data/models/news_model.dart';
import '../../utils/utils.dart';
import '../../view_model/get_saved_news.dart';

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget(
      {super.key, required this.articles, this.formattedDate, this.cardHeight});
  final Articles articles;
  final String? formattedDate;
  final double? cardHeight;

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu(
      actions: [
        CupertinoContextMenuAction(
          onPressed: () {
            Utils.launchUrlInApp(articles.url.toString());
            Navigator.pop(context);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(CupertinoIcons.globe),
              const SizedBox(
                width: 12,
              ),
              Text(
                "Open",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        CupertinoContextMenuAction(
          onPressed: () {
            SavedNewsViewModel().addArticle(articles);
            log("news saved log");
            Navigator.pop(context);
          },
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
        CupertinoContextMenuAction(
          onPressed: () {
            SavedNewsViewModel().removeArticle(articles);
            Navigator.pop(context);
          },
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
        CupertinoContextMenuAction(
          onPressed: () => Navigator.pop(context),
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
        CupertinoContextMenuAction(
          onPressed: () {
            Utils.textShare("${articles.title}\n${articles.url}");
            Navigator.pop(context);
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
        CupertinoContextMenuAction(
          onPressed: () => Navigator.pop(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(CupertinoIcons.chat_bubble_text),
              const SizedBox(
                width: 12,
              ),
              Text(
                "Send Feedback",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          Utils.launchUrlInApp(articles.url.toString());
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 80,
          height: cardHeight ?? 300,
          child: Card(
            elevation: 1.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NetworkImageWithErrorHandling(
                    imageUrl: articles.urlToImage.toString(),
                    radius: 8.0,
                  ),
                  Text(
                    articles.title.toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(CupertinoIcons.person_alt_circle_fill),
                          SizedBox(
                            width: 140,
                            child: Text(
                              (articles.author.toString() == 'null')
                                  ? "Author"
                                  : articles.author.toString(),
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          )
                        ],
                      ),
                      Expanded(child: Container()),
                      Text(
                        formattedDate.toString(),
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
