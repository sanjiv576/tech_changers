// api connection
class ApiEndpoints {
  static const Duration connectionTimeout = Duration(seconds: 2000);
  static const Duration receiveTimeout = Duration(seconds: 2000);

// for android
  static const String baseUrl = "http://10.0.2.2:3000/api/";

  // for android  mobile--> ip address win
  // static const String baseUrl = "http://192.168.1.65:3000/api/";

  // ----------------- Auth Routes = 1 -----------------
  static const String register = "user/signup";
  static const String login = "user/signin";
  static const String userInfo = "user/info";
  static const String requestWater = "user/requestwater";

  //  -------------- Supplier Routes = 2 -----------------
  static const String dashboard = 'supplier/dashboard';

  //  -------------- Routine Routes = 3 -----------------
  static const String routine = 'routine';

  // ----------------- Upload Image Routes = 4  -----------------
  static const String uploadImage = "upload";
  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
}
