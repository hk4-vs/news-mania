import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/data/models/news_model.dart';
import 'package:news_app/resources/components/news_card_widget.dart';

import '../utils/utils.dart';

class TrendingsViewAllView extends StatelessWidget {
  const TrendingsViewAllView({super.key, required this.articles});
  final List<Articles> articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "Trendings",
          style: Theme.of(context).textTheme.headlineSmall,
        )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.builder(
              itemCount: articles.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                String? dateString = articles[index].publishedAt.toString();
                DateTime parsedDate =
                    DateFormat('yyyy-MM-ddTHH:mm:ssZ').parseUtc(dateString);
                String? formattedDate =
                    DateFormat('EEE, MMM d, yyyy').format(parsedDate);
                return GestureDetector(
                  onTap: () {
                    Utils.launchUrlInApp(articles[index].url.toString());
                  },
                  child: NewsCardWidget(
                    articles: articles[index],
                    formattedDate: formattedDate,
                  ),
                );
              }),
        ));
  }
}
