import 'package:flutter/material.dart';
import 'package:news_app/data/models/news_model.dart';
import 'package:news_app/resources/components/news_horizentel_card_widget.dart';
import 'package:news_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../view_model/home_view_model.dart';
import 'components/home_shimmer_widget.dart';
import 'components/internet_error_widget.dart';

class MySearchDelegate extends SearchDelegate {
  MySearchDelegate({required this.context});
  final BuildContext context;
  final HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  List<Articles> articales = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // if (query.isEmpty || query == "" || query == "null") {
    //   homeViewViewModel.getSearchQueryOfNews("sports");
    // }
    // homeViewViewModel.getSearchQueryOfNews(query);
    // return ChangeNotifierProvider<HomeViewViewModel>(
    //     create: (context) => homeViewViewModel,
    //     child: Consumer<HomeViewViewModel>(
    //       builder: (context, provider, child) {
    //         switch (provider.usersList.status) {
    //           case Status.LOADING:
    //             return ListView.builder(
    //                 itemCount: 10,
    //                 itemBuilder: (context, index) {
    //                   return Container(
    //                       margin: EdgeInsets.only(top: 10),
    //                       child: ShimmerHorizentelWidget());
    //                 });
    //           case Status.ERROR:
    //             return InternetErrorDialog(onRefresh: () {
    //               homeViewViewModel.getSearchQueryOfNews(query);
    //             });
    //           case Status.COMPLETED:
    //             var valueData = provider.usersList.data!.articles;
    //             return ListView.builder(
    //                 scrollDirection: Axis.vertical,
    //                 itemCount: valueData!.length,
    //                 itemBuilder: (context, index) {
    //                   if (valueData.isEmpty) {
    //                     return const Center(
    //                       child: Text("No data found"),
    //                     );
    //                   }
    //                   return GestureDetector(
    //                     onTap: () {
    //                       Utils.launchUrlInApp(valueData[index].url.toString());
    //                     },
    //                     child: NewsHorizentelCardWidget(
    //                         articles: valueData[index]),
    //                   );
    //                 });

    //           default:
    //             return Container();
    //         }
    //       },
    //     ));

    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: articales.length,
        itemBuilder: (context, index) {
          if (articales.isEmpty) {
            return const Center(
              child: Text("No data found"),
            );
          }
          return GestureDetector(
            onTap: () {
              Utils.launchUrlInApp(articales[index].url.toString());
            },
            child: NewsHorizentelCardWidget(articles: articales[index]),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty || query == "" || query == "null") {
      homeViewViewModel.getSearchQueryOfNews("sports");
    }
    homeViewViewModel.getSearchQueryOfNews(query);
    return ChangeNotifierProvider<HomeViewViewModel>(
        create: (context) => homeViewViewModel,
        child: Consumer<HomeViewViewModel>(
          builder: (context, provider, child) {
            switch (provider.usersList.status) {
              case Status.LOADING:
                return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const ShimmerHorizentelWidget());
                    });
              case Status.ERROR:
                return InternetErrorDialog(onRefresh: () {
                  homeViewViewModel.getSearchQueryOfNews(query);
                });
              case Status.COMPLETED:
                var valueData = provider.usersList.data!.articles;
                articales = valueData!;
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: valueData.length,
                    itemBuilder: (context, index) {
                      if (valueData.isEmpty) {
                        return const Center(
                          child: Text("No data found"),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          Utils.launchUrlInApp(valueData[index].url.toString());
                        },
                        child: NewsHorizentelCardWidget(
                            articles: valueData[index]),
                      );
                    });

              default:
                return Container();
            }
          },
        ));
  }
}
