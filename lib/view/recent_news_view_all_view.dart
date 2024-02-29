import 'package:flutter/material.dart';
import 'package:news_app/data/models/news_model.dart';
import 'package:news_app/resources/components/news_horizentel_card_widget.dart';

import '../utils/utils.dart';

class RecentNewsViewAllView extends StatelessWidget {
  const RecentNewsViewAllView({super.key, required this.articles});
  final List<Articles> articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Recent News",
        style: Theme.of(context).textTheme.headlineSmall,
      )),
      body: ListView.builder(
        itemCount: articles.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          
          return GestureDetector(
            onTap: () {
              Utils.launchUrlInApp(articles[index].url.toString(),);
            },
            child: NewsHorizentelCardWidget(
              articles: articles[index],
            ),
          );
        },
      ),
    );
  }
}
