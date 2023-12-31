import 'package:ezy_buy_adminn/core/constant/app_images.dart';
import 'package:ezy_buy_adminn/core/constant/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DasboardModel {
  final String text;
  final String image;
  final Function() press;

  DasboardModel({required this.text, required this.image, required this.press});
  static List<DasboardModel> dasboardCard(BuildContext context) => [
        DasboardModel(
            text: "Add a new product",
            image: AppImages.cloud,
            press: () {
              GoRouter.of(context).push(NamedRouteScreen.kEditProductScreen);
            }),
        DasboardModel(
            text: "Insepect all products",
            image: AppImages.shoppingCart,
            press: () {
              GoRouter.of(context).push(NamedRouteScreen.kSearchScreen);
            }),
        DasboardModel(
            text: "View orders",
            image: AppImages.order,
            press: () {
              GoRouter.of(context)
                  .push(NamedRouteScreen.kOrderScreen, extra: null);
            }),
      ];
}
