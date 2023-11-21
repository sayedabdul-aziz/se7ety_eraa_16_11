import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

showLoaderDialog(BuildContext context) {
  // CupertinoAlertDialog alert = CupertinoAlertDialog(
  //   content: Row(
  //     children: [
  //       const CircularProgressIndicator(),
  //       Container(
  //           margin: const EdgeInsets.only(right: 15),
  //           child: const Text("Loading...")),
  //     ],
  //   ),
  // );
  showDialog(
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(.7),
    context: context,
    builder: (BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/loading.json', width: 150, height: 150),
        ],
      );
    },
  );
}
