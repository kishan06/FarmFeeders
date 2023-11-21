class ApiUrls {
  static const base = "https://farmflow.betadelivery.com/api/";

  static const baseImageUrl = "https://farmflow.betadelivery.com/public";
  static const liveStockGet = "${base}livestock/data/";
  static const liveStockSet = "${base}livestock-info";
  static const dashboardApi = "${base}dashboard";
  static const getFeedInfoDropdownData = "${base}feed/data/";
  static const setFeedInfo = "${base}feed-info";
  static const addTrainingNotesApi = "${base}training_video/add_note";
  static const notificationCountApi = "${base}farmer/notifications-count";
  static const getNotificationData = "${base}farmer/notifications";
  static const getNewsArticle = "${base}news-and-articles";
  static const profileInfoAPI = "${base}profile-info";
  static const updateProfileInfoAPI = "${base}profile-update";
  static const feedbackApi = "${base}feedback";
  static const farmInfoApi = "${base}edit/farm-info";
  static const livestockTypeApi = "${base}livestock/types";
  static const feedLivestockApi = "${base}feed/livestocks";
  static const faqApi = "${base}faqs/";

  static const boomarkNewsAndArticles = "${base}bookmark-article";

  static const connectionCodeApi = "${base}connection-code";
  static const getBookmarkedNewsList = "${base}bookmarked/news-and-articles";
  static const resendOtpApi = "${base}resend-otp";

  static const connectionApproveApi = "${base}accept/connection-request";
  static const notificationSettingApi = "${base}farmer/notification-settings";
  static const notificationStatusApi = "${base}farmer/notifications-status";
  static const weatherApi = "http://api.weatherapi.com/v1/current.json";
}
