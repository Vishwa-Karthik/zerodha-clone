import 'package:flutter/material.dart';
import 'package:zerodha/core/constants/app_color.dart';
import 'package:zerodha/core/constants/app_constant.dart';

class AppTheme {
  static ThemeData dark() {
    return ThemeData(
      iconTheme: IconThemeData(
        size: AppConstant.double20,
        color: AppColor.whiteColor,
      ),
      brightness: Brightness.dark,
      tabBarTheme: TabBarTheme(
        indicatorColor: AppColor.blueColor,
        dividerColor: AppColor.transparentColor,
        labelColor: AppColor.blueColor,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorAnimation: TabIndicatorAnimation.linear,
        labelStyle: TextStyle(
          color: AppColor.blueColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      dividerColor: Colors.grey.shade100,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColor.blueColor,
        unselectedItemColor: AppColor.whiteColor,
        enableFeedback: true,
        selectedIconTheme: IconThemeData(size: AppConstant.double20),
        unselectedIconTheme: IconThemeData(size: AppConstant.double20),
      ),
    );
  }

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        size: AppConstant.double20,
        color: AppColor.blackColor,
      ),
      tabBarTheme: TabBarTheme(
        indicatorColor: AppColor.blueColor,
        dividerColor: AppColor.transparentColor,
        labelColor: AppColor.blueColor,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorAnimation: TabIndicatorAnimation.linear,
        labelStyle: TextStyle(
          color: AppColor.blueColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColor.blueColor,
        unselectedItemColor: AppColor.blackColor,
      ),
    );
  }
}
