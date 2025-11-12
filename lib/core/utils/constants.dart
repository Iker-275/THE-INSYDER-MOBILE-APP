class AppConstants {
  // --- API CONFIG ---
  static const String baseUrl =
      "https://the-insyder-blog-api.onrender.com/api/blog";

  // --- Endpoints ---
  static const String authorsEndpoint = "/authors";
  static const String articlesEndpoint = "/articles";
  static const String genresEndpoint = "/genres";
  //auth endpoints
  static const String signup = "/signup";
  static const String signin = "/login";
  static const String profileEndpoint = "/author";

  // --- App Info ---
  static const String appName = "INSYDER Magazine";
  static const String defaultImage =
      "https://via.placeholder.com/150"; // fallback for null image URLs

  // --- Pagination ---
  static const int defaultPageSize = 10;

  // --- Date Format ---
  static const String dateFormat = "yyyy-MM-dd HH:mm";
}
