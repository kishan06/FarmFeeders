class ApiUrls {
  static const base = "https://farmflow.betadelivery.com/api/";

  static const baseImageUrl = "https://farmflow.betadelivery.com/public";
  static const liveStockGet = "${base}livestock/data/";
  static const liveStockSet = "${base}livestock-info";
  static const dashboardApi = "${base}dashboard";
  static const getFeedInfoDropdownData = "${base}feed/data/1";
  static const setFeedInfo = "${base}feed-info";
  static const addTrainingNotesApi = "${base}training_video/add_note";
  static const notificationCountApi = "${base}farmer/notifications-count";
  static const getNotificationData = base + "farmer/notifications";
  static const profileInfoAPI = "${base}profile-info";
  static const updateProfileInfoAPI = "${base}profile-update";
  static const feedbackApi = "${base}feedback";
  static const weatherApi = "http://api.weatherapi.com/v1/current.json";
}
