class AppUrls {
  static const String baseUrl =
      "https://fivewayart.com/projects/news/public/api";

  // for login
  static const String login = "$baseUrl/login";

  // for logging out
  static const String logout = "$baseUrl/logout";

  //  for register
  static const String register = "$baseUrl/register";

  // for upload profile image
  static const String uploadUserProfile = "$baseUrl/user/profile";

  // get the user
  static const String getUser = "$baseUrl/user";

  // there is my api key for NewsApi.org
  static const String newsApiKey = "e76f3890a6984484ad081816a3129afe";

  // news api base url
  static const String newsBaseUrl = "https://newsapi.org/v2/";

  //  Top Headlines
  static const String topHeadlines =
      "$newsBaseUrl/top-headlines?country=in&apiKey=$newsApiKey";
  static const String recentNews =
      "$newsBaseUrl/top-headlines?country=in&category=business&apiKey=$newsApiKey";

  // everythin from a query
  static const String searchQuery =
      "$newsBaseUrl?q=tl&sortBy=publishedAt&apiKey=$newsApiKey";
}
