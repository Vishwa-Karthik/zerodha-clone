import 'package:flutter/material.dart';
import 'package:zerodha/core/constants/app_color.dart';
import 'package:zerodha/core/constants/app_constant.dart';

class AppTheme {
  static ThemeData dark() {
    return ThemeData(
      fontFamily: 'OpenSans',
      bottomAppBarTheme: BottomAppBarTheme(
        color: AppColor.blackColor,
        elevation: AppConstant.double0,
      ),
      iconTheme: IconThemeData(
        size: AppConstant.double20,
        color: AppColor.whiteColor,
      ),
      brightness: Brightness.dark,
      tabBarTheme: TabBarThemeData(
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
      switchTheme: SwitchThemeData(
        trackOutlineColor: WidgetStateProperty.all(AppColor.transparentColor),
        thumbIcon: WidgetStateProperty.all(
          Icon(Icons.check, color: AppColor.whiteColor),
        ),
        thumbColor: WidgetStateProperty.all(AppColor.whiteColor),
        trackColor: WidgetStateProperty.all(
          AppColor.blueColor.withValues(alpha: AppConstant.double0_5),
        ),
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
      tabBarTheme: TabBarThemeData(
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
