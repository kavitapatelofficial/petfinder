import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/missing_post_controller.dart';

class MissingPostView extends GetView<MissingPostController> {
  const MissingPostView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MissingPostView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MissingPostView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
