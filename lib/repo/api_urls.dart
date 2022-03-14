// import 'package:firebase_auth/firebase_auth.dart';

class API {
  // static var uid = FirebaseAuth.instance.currentUser!.uid; //user id
  static var host = 'vihaanserver.herokuapp.com'; //server path

  static var path1 = "/api";

  /* -------------------------------- USERS ------------------------------- */

  static var newUser = "$path1/user/new-user"; //new user
  static var userDetails = "$path1/user/users/"; //user details
  static var loginUser = "$path1/user/users/"; //login user
  static var updateUser = "$path1/user/users/"; //update user
  static var allUsers = "$path1/user/all-users"; //all users

  /* -------------------------------- PRODUCTS -------------------------------- */

  static var newProduct = "$path1/product/new-product"; //new product
  static var productDetails = "$path1/product/products/"; //product details
  static var allProducts = "$path1/product/all-products"; //all products
  static var updateProduct = "$path1/product/products/"; //update product
  static var deleteProduct = "$path1/product/products/"; //delete product
  static var allProductsByCategory =
      "$path1/product/category-id/"; //product by category
  static var allProductsModelId = "$path1/product/model-id/"; //product by model

  static var wishListAdd = '/api/user/wishList/'; //add to wishlist
  static var wishListRemove = '/api/user/wishList/'; //remove from wishlist
  static var cart = '/api/user/cart/'; //add to cart
  static var cartRemove = '/api/user/cart/'; //remove from cart
  // static var removeCartorWishlist = '?remove=true'; //remove from cart

  /* ------------------------------- TEST RIDES ------------------------------- */

  static var newTestRide =
      "$path1/test-ride/new-test-ride-request"; //new test ride
  static var testRideDetails =
      "$path1/test-ride/test-rides/"; //test ride details
  static var updateTestRide = "$path1/test-ride/test-rides/"; //update test ride
  static var deleteTestRide = "$path1/test-ride/test-rides/"; //delete test ride
  static var allTestRides = "$path1/test-ride/all-test-rides"; //all test rides

  /* -------------------------------- SETTINGS -------------------------------- */
  static var newSettings = "$path1/settings/new-settings"; //new settings
  static var settingsById = "$path1/settings/settings/"; //settings by id
  static var appSettings =
      "$path1/settings/doc-id/appsettings"; //settings by doc id app settings
  static var settingsByDocId = "$path1/settings/doc-id/"; //settings by doc id
  static var allSettings = "$path1/settings/all-settings"; //all settings

}
