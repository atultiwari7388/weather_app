import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/global_controller.controller.dart';
import 'package:weather_app/widgets/header_widget.widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //call the global controller

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => globalController.checkLoading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: const [
                    SizedBox(height: 20),
                    HeaderWidget(),
                  ],
                ),
        ),
      ),
    );
  }
}
