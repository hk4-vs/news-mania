import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/data/models/news_model.dart';
import 'package:news_app/view_model/get_saved_news.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../resources/components/news_card_widget.dart';
import '../view_model/home_view_model.dart';

class SavedNewsView extends StatefulWidget {
  const SavedNewsView({super.key, required this.context});
  final BuildContext context;

  @override
  State<SavedNewsView> createState() => _SavedNewsViewState();
}

class _SavedNewsViewState extends State<SavedNewsView> {
  @override
  void initState() {
    final provider = Provider.of<SavedNewsViewModel>(context, listen: false);
    provider.loadArticleList();

    super.initState();
  }

  late SavedNewsViewModel savedNewsViewModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   body: ChangeNotifierProvider<SavedNewsViewModel>(
      // create: (context) => savedNewsViewModel,
      // child:   ),
      appBar: AppBar(
          title: Text(
        "Saved News",
        style: Theme.of(context).textTheme.headlineSmall,
      )),
      body: Consumer<SavedNewsViewModel>(
        builder: (context, provider, child) {
          List<Articles> valueData = provider.articleList;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            // child: Column(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     const SizedBox(
            //       height: 20,
            //     ),
            //     Text(
            //       "Saved News",
            //       style: Theme.of(context).textTheme.titleLarge,
            //     ),
            //     SizedBox(
            //       height: 300,
            //       width: MediaQuery.of(context).size.width,
            //       child: ListView.builder(
            //           scrollDirection: Axis.horizontal,
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 16, vertical: 10),
            //           physics: const BouncingScrollPhysics(),
            //           shrinkWrap: true,
            //           itemCount: provider.articleList.length,
            //           itemBuilder: (context, index) {
            //             String? dateString =
            //                 valueData[index].publishedAt.toString();
            //             DateTime parsedDate = DateFormat('yyyy-MM-ddTHH:mm:ssZ')
            //                 .parseUtc(dateString);
            //             String? formattedDate =
            //                 DateFormat('EEE, MMM d, yyyy').format(parsedDate);

            //             return NewsCardWidget(
            //               articles: valueData[index],
            //               formattedDate: formattedDate,
            //             );
            //           }),
            //     ),
            //   ],
            // ),
            child: ListView.builder(
                // scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.articleList.length,
                itemBuilder: (context, index) {
                  String? dateString = valueData[index].publishedAt.toString();
                  DateTime parsedDate =
                      DateFormat('yyyy-MM-ddTHH:mm:ssZ').parseUtc(dateString);
                  String? formattedDate =
                      DateFormat('EEE, MMM d, yyyy').format(parsedDate);

                  return NewsCardWidget(
                    articles: valueData[index],
                    formattedDate: formattedDate,
                  );
                }),
          );
        },
      ),
    );
  }
}
