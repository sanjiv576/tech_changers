import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../config/router/app_routes.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../../auth/domain/entity/user_entity.dart';
import '../../../auth/presentation/state/auth_state.dart';

final splashViewModelProvider = StateNotifierProvider<SplashViewModel, void>(
  (ref) {
    return SplashViewModel(
      ref.read(userSharedPrefsProvider),
    );
  },
);

class SplashViewModel extends StateNotifier<void> {
  final UserSharedPrefs _userSharedPrefs;
  SplashViewModel(this._userSharedPrefs) : super(null);

  init({required context}) async {
    // get the token
    final data = await _userSharedPrefs.getUserToken();

    data.fold((l) => null, (token) async {
      if (token != null && token != '') {
        bool isTokenExpired = isValidToken(token);
        if (isTokenExpired) {
          // navigate to login when token is expired
          Navigator.popAndPushNamed(context, AppRoutes.loginRoute);
        } else {
          UserSharedPrefs userSharedPrefs = UserSharedPrefs();
          // get the user from the shared prefs to make decision to navigate which dashboard user or supplier
          UserEntity? user;
          var data = await userSharedPrefs.getUser();

          data.fold((fail) => user = null, (success) => user = success!);
          if (user != null) {
            // store the user data in the static variable as well
            AuthState.userEntity = user;
            if (user!.role == 'user') {
              Navigator.popAndPushNamed(context, AppRoutes.dashboardRoute);
            } else {
              // supplier dashboard
              Navigator.popAndPushNamed(context, AppRoutes.supplierRoute);
            }
          }
        }
      } else {
        Navigator.popAndPushNamed(context, AppRoutes.loginRoute);
      }
    });
  }

  bool isValidToken(String token) {
    //  decoding the token
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    int expirationTimestamp = decodedToken['exp'];

    final currentDate = DateTime.now().millisecondsSinceEpoch;
    // If current date is greater than expiration timestamp then token is expired
    return currentDate > expirationTimestamp * 1000;
  }
}
