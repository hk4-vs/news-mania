import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/data/models/news_model.dart';
import 'package:news_app/resources/components/internet_error_widget.dart';
import 'package:news_app/resources/components/user_profile_pop_up_menu_widget.dart';
import 'package:news_app/utils/utils.dart';
import 'package:news_app/view/recent_news_view_all_view.dart';

import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../resources/components/home_shimmer_widget.dart';
import '../resources/components/news_card_widget.dart';
import '../resources/components/news_horizentel_card_widget.dart';
import '../resources/my_search_delegate.dart';
import '../view_model/home_view_model.dart';
import '../view_model/user_profile_view_model.dart';
import 'trendings_view_all_view.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          homeViewViewModel.fetchNewsList();
        },
        color: Theme.of(context).primaryColor,
        child: Consumer<UserProfileViewModel>(
          builder: (context, provider, child) {
            return Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  title: Text(
                    "News Mania",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: MySearchDelegate(context: context));
                        },
                        icon: const Icon(CupertinoIcons.search)),
                    StreamBuilder<ConnectivityResult>(
                      stream: Connectivity().onConnectivityChanged,
                      initialData: ConnectivityResult.none,
                      builder: (context, snapshot) {
                        var connectivityResult = snapshot.data;
                        if (connectivityResult == ConnectivityResult.none) {
                          return const CircleAvatar();
                        } else {
                          return UsreProfilePopupMenuWidget(
                            imageUrl: provider.getProfile.toString(),
                            name: provider.getName.toString(),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                // endDrawer: const MyDrawer(),
                body: ChangeNotifierProvider<HomeViewViewModel>(
                  create: (context) => homeViewViewModel,
                  child: Consumer<HomeViewViewModel>(
                    builder: (context, value, child) {
                      log("value: ${value.usersList}");
                      switch (value.usersList.status) {
                        case Status.LOADING:
                          return const HomeShimmerWidget();
                        case Status.ERROR:
                          return InternetErrorDialog(onRefresh: () {
                            homeViewViewModel.fetchNewsList();
                          });
                        case Status.COMPLETED:
                          var valueData = value.usersList.data!.articles;
                          List<Articles> recentNews = List.from(valueData!)
                            ..shuffle();

                          return SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Trendings",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Expanded(child: Container()),
                                    TextButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TrendingsViewAllView(
                                                        articles: valueData)));
                                      },
                                      icon: Text(
                                        "View All",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                      ),
                                      label: Icon(
                                        Icons.chevron_right,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: valueData.length,
                                      itemBuilder: (context, index) {
                                        String? dateString = valueData[index]
                                            .publishedAt
                                            .toString();
                                        DateTime parsedDate =
                                            DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                                                .parseUtc(dateString);
                                        String? formattedDate =
                                            DateFormat('EEE, MMM d, yyyy')
                                                .format(parsedDate);

                                        return NewsCardWidget(
                                          articles: valueData[index],
                                          formattedDate: formattedDate,
                                        );
                                      }),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Recent News",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Expanded(child: Container()),
                                    TextButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RecentNewsViewAllView(
                                                        articles: valueData)));
                                      },
                                      icon: Text(
                                        "View All",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                      ),
                                      label: Icon(
                                        Icons.chevron_right,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                                for (int i = 0; i < recentNews.length; i++) ...[
                                  GestureDetector(
                                    onTap: () {
                                      Utils.launchUrlInApp(
                                          recentNews[i].url.toString());
                                    },
                                    child: NewsHorizentelCardWidget(
                                      articles: recentNews[i],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          );

                        default:
                          return Center(
                            child: Text(value.usersList.message.toString()),
                          );
                      }
                    },
                  ),
                ));
          },
        ));
  }

  // List<Widget> homeViewActionWidget(String imageUrl, String name) {
  //   return [
  //     IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search)),
  //     UsreProfilePopupMenuWidget(
  //       imageUrl: imageUrl,
  //       name: name,
  //     ),
  //     const SizedBox(
  //       width: 20,
  //     ),
  //   ];
  // }

  @override
  void initState() {
    homeViewViewModel.fetchNewsList();
    final provider = Provider.of<UserProfileViewModel>(context, listen: false);

    provider.currentUserData();
    super.initState();
  }
}
