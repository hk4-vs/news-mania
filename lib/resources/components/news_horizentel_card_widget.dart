import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/resources/components/news_pop_up_menu_widget.dart';
import 'package:news_app/utils/utils.dart';

import '../../data/models/news_model.dart';
import 'network_image_widget.dart';

class NewsHorizentelCardWidget extends StatelessWidget {
  const NewsHorizentelCardWidget({
    super.key,
    required this.articles,
  });
  final Articles articles;

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    String? dateString = articles.publishedAt.toString();
    DateTime parsedDate =
        DateFormat('yyyy-MM-ddTHH:mm:ssZ').parseUtc(dateString);

    final int differenceSeconds = currentTime.difference(parsedDate).inSeconds;

    // Calculate time difference in minutes and hours
    final int hours = differenceSeconds ~/ 3600;
    final int minutes = (differenceSeconds % 3600) ~/ 60;
    double widgetSpace = 8;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 140 - 16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        articles.title.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(CupertinoIcons.person_alt_circle_fill),
                          SizedBox(
                            width: MediaQuery.of(context).size.width -
                                140 -
                                16 -
                                50,
                            child: Text(
                              (articles.author.toString() == 'null')
                                  ? "Author"
                                  : articles.author.toString(),
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: NetworkImageWithErrorHandling(
                    imageUrl: articles.urlToImage,
                    height: 100,
                    radius: 8.0,
                  ),
                )
              ],
            ),
            SizedBox(
              height: widgetSpace,
            ),
            Row(
              children: [
                Text("$hours:$minutes hours ago"),
                SizedBox(
                  width: widgetSpace,
                ),
                const Icon(CupertinoIcons.chat_bubble),
                SizedBox(
                  width: widgetSpace,
                ),
                const Text("2"),
                Expanded(child: Container()),
                GestureDetector(
                  child: const Icon(Icons.share),
                  onTap: () {
                    Utils.textShare("${articles.title}\n${articles.url}");
                  },
                ),
                SizedBox(
                  width: widgetSpace,
                ),
                NewsPopupMenuWidget(
                  articles: articles,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
