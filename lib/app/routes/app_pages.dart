import 'package:get/get.dart';

import '../modules/find/bindings/find_binding.dart';
import '../modules/find/views/find_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/missing_post/bindings/missing_post_binding.dart';
import '../modules/missing_post/views/missing_post_view.dart';
import '../modules/network/bindings/network_binding.dart';
import '../modules/network/views/network_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/owner/bindings/owner_binding.dart';
import '../modules/owner/views/owner_view.dart';
import '../modules/pet/bindings/pet_binding.dart';
import '../modules/pet_detail/bindings/pet_detail_binding.dart';
import '../modules/pet_detail/views/pet_detail_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.FIND,
      page: () => const FindView(),
      binding: FindBinding(),
    ),
    GetPage(
      name: _Paths.OWNER,
      page: () => OwnerView(),
      binding: PetBinding(),
    ),
    GetPage(
      name: _Paths.PET_DETAIL,
      page: () => const PetDetailView(),
      binding: PetDetailBinding(),
    ),
    GetPage(
      name: _Paths.MISSING_POST,
      page: () => const MissingPostView(),
      binding: MissingPostBinding(),
    ),
    GetPage(
      name: _Paths.NETWORK,
      page: () => const NetworkView(),
      binding: NetworkBinding(),
    ),
  ];
}
