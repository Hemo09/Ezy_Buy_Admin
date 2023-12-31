import 'package:ezy_buy_adminn/core/constant/app_images.dart';
import 'package:ezy_buy_adminn/core/theme/theme_provider.dart';
import 'package:ezy_buy_adminn/core/widgets/title_text.dart';
import 'package:ezy_buy_adminn/features/dashboard/data/models/dashboard_model.dart';
import 'package:ezy_buy_adminn/features/dashboard/presenation/view/widget/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/DashboardScreen';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const TitlesTextWidget(label: "Dashboard Screen"),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AppImages.shoppingCart),
        ),
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.setDarkTheme(
                  themeValue: !themeProvider.getIsDarkTheme);
            },
            icon: Icon(themeProvider.getIsDarkTheme
                ? Icons.light_mode
                : Icons.dark_mode),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        children:
            List.generate(DasboardModel.dasboardCard(context).length, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomCard(
                text: DasboardModel.dasboardCard(context)[index].text,
                press: DasboardModel.dasboardCard(context)[index].press,
                image: DasboardModel.dasboardCard(context)[index].image),
          );
        }),
      ),

      /**/
    );
  }
}
