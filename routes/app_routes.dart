import 'package:ecommerce/features/authentication/screens/address/address.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/onboarding.dart';
import 'package:ecommerce/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:ecommerce/features/authentication/screens/signup/widgets/signup.dart';
import 'package:ecommerce/features/authentication/screens/signup/widgets/verify_email.dart';
import 'package:ecommerce/features/shop/screens/cart/cart.dart';
import 'package:ecommerce/features/shop/screens/checkout/checkout.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home.dart';
import 'package:ecommerce/features/shop/screens/order/order.dart';
import 'package:ecommerce/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:ecommerce/features/shop/screens/profile/Widgets/profile.dart';
import 'package:ecommerce/features/shop/screens/settings/settings.dart';
import 'package:ecommerce/features/shop/screens/store/store.dart';
import 'package:ecommerce/features/shop/screens/wishlist/wishlist.dart';
import 'package:ecommerce/routes/routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.store, page: () => const StoreScreen()),
    GetPage(name: TRoutes.favourites, page: () => const FavouriteScreen()),
    GetPage(name: TRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: TRoutes.productReviews, page: () => const ProductReviewsScreen()),
    GetPage(name: TRoutes.order, page: () => const OrderScreen()),
    GetPage(name: TRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: TRoutes.cart, page: () => const CartScreen()),
    GetPage(name: TRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: TRoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: TRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: TRoutes.forgetPassword, page: () => const ForgetPassword()),
    GetPage(name: TRoutes.onBoarding, page: () => const OnBoardingScreen()),
  ];
}