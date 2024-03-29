class ApiUrl{

  // ignore: constant_identifier_names
  static const MRDC_API ="https://api.nationalmrdc.com/";
  // ignore: constant_identifier_names
  static const CATEGORY = "https://api.nationalmrdc.com/api/get-desired-job";
  // ignore: constant_identifier_names
  static const BLOG_POST = "https://api.nationalmrdc.com/api/frontend/posts";
  // static const USER_BLOG_POST = "https://api.nationalmrdc.com/api/post/5?limit=4&page=1&title=";
  static const USER_BLOG_POST = "https://api.nationalmrdc.com/api/post/list/5";
  // ApiUrl.MRDC_API + 'api/post/'+id;
  static String UPDATE_POST = "https://api.nationalmrdc.com/api/post/";
  static const CREATE_POST = "https://api.nationalmrdc.com/api/post";
  // String url = ApiUrl.MRDC_API + 'api/post/list/5?limit=4&page=1&title=';
  // static const MY_BLOG_POST = "https://api.nationalmrdc.com/api/post/list/5";
  static String DELETE_POST = "https://api.nationalmrdc.com/api/post/delete/";
  static String USER_PROFILE = "https://api.nationalmrdc.com/api/contacts/show/";
  static String KAJI_PROFILE = "https://api.nationalmrdc.com/api/frontend/users";
  static const USER_PROFILE_UPDATE = "http://api.nationalmrdc.com/contacts/basic-info";

  // Message
  static const USER_MESSAGE_SEND = "https://api.nationalmrdc.com/api/communication/messaging";
  static const USER_MESSAGE_GET = "https://api.nationalmrdc.com/api/communication/topic/list";
  static String ADMIN_MESSAGE_GET = "https://api.nationalmrdc.com/api/communication/topic/list/admin";
  static String UNREAD_MESSAGE_COUNT = "https://api.nationalmrdc.com/api/communication/topic/list/count";

  // KAJI LIST FILTER API

  static const DIVISION_LIST = "https://api.nationalmrdc.com/api/get-division";
  static String DISTRICT_LIST = "https://api.nationalmrdc.com/api/get-district/";
  static String SUB_DISTRICT_LIST = "https://api.nationalmrdc.com/api/get-subdistrict/";
  static String UNION_LIST = "https://api.nationalmrdc.com/api/get-union/";
  static String KAJI_CONTACT = "https://api.nationalmrdc.com/api/frontend/contacts?";


  // ASSISTENT API

  static const ASSISTENT_LIST = "http://api.nationalmrdc.com/api/contacts/assistent";
  static const ASSISTENT_ADD = "http://api.nationalmrdc.com/contacts";
  static String ASSISTENT_REMOVE = "http://api.nationalmrdc.com/contacts/";


  // APP ABOUT

  static const ABOUT = "https://api.nationalmrdc.com/api/frontend/post/details/about";

}