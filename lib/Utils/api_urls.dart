class ApiUrls {
  static const base = //"http://192.168.50.94/new-farmflow/farmflow/api/";
      "https://staging.farmflowsolutions.com/api/";

  static const baseImageUrl = //"http://192.168.50.94/new-farmflow/farmflow/";
      "https://staging.farmflowsolutions.com/public";
  static const liveStockGet = "${base}livestock/data/";
  static const liveStockSet = "${base}livestock-info";
  static const dashboardApi = "${base}dashboard";
  static const getFeedInfoDropdownData = "${base}feed/data/";
  static const setFeedInfo = "${base}feed-info";
  static const addTrainingNotesApi = "${base}training_video/add_note";
  static const updateTrainingNotesApi = "${base}training_video/note";
  static const notificationCountApi = "${base}farmer/notifications-count";
  static const getNotificationData = "${base}farmer/notifications";
  static const getNewsArticle = "${base}news-and-articles";
  static const profileInfoAPI = "${base}profile-info";
  static const updateProfileInfoAPI = "${base}profile-update";
  static const deleteProfileImageAPI = "${base}delete_profile/image";
  static const feedbackApi = "${base}feedback";
  static const farmInfoApi = "${base}edit/farm-info";
  static const livestockTypeApi = "${base}livestock/types";
  static const feedLivestockApi = "${base}feed/livestocks";

  static const deleteFeedLivestockApi = "${base}delete/livestock-info/";
  static const faqApi = "${base}faqs/";

  static const boomarkNewsAndArticles = "${base}bookmark-article";

  static const connectionCodeApi = "${base}connection-code";
  static const getBookmarkedNewsList = "${base}bookmarked/news-and-articles";
  static const resendOtpApi = "${base}resend-otp";

  static const connectionApproveApi = "${base}accept/connection-request";
  static const notificationSettingApi = "${base}farmer/notification-settings";
  static const notificationStatusApi = "${base}farmer/notifications-status";
  static const weatherApi = "http://api.weatherapi.com/v1/current.json";

  static const subUserApi = "${base}users";
  static const updateSubUserApi = "${base}users/update";
  static const deleteSubUserApi = "${base}users/";

  static const orderApi = "${base}orders";
  static const orderDetailsApi = "${base}order-details/";
  static const recurringOrderDetailsApi = "${base}recurring-order-details/";
  static const trainingVideoBookmarkApi = "${base}training_video/bookmark";
  static const trainingVideoDetailApi = "${base}training_video/";
  static const updatetrainingVideoApi = "${base}training_video/update";
  static const deletetrainingVideoApi = "${base}training_video/";

  static const ongoingOrdersApi = "${base}ongoing-orders";
  static const cancelledOrdersApi = "${base}cancelled-orders/";
  static const pastOrdersApi = "${base}past-orders/";
  static const recurringOrdersApi = "${base}recurring-orders";

  static const deleteProfileApi = "${base}profile-delete";
  static const subscriptionsApi = "${base}subscriptions";
  static const subscriptionPlanApi = "${base}subscriptionPlans";
  static const lougoutApi = "${base}logout";
  static const refillProduct = "${base}refill_product/";
}
