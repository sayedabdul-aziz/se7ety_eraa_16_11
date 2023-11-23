import 'package:flutter/material.dart';
import 'package:se7ety_eraa_16_11/core/utils/app_colors.dart';
import 'package:se7ety_eraa_16_11/core/utils/app_text_styles.dart';

showAlertDialog(BuildContext context,
    {String? ok, String? no, required String title, void Function()? onTap}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.scaffoldBG,
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.scaffoldBG,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Text(
                  title,
                  style: getTitleStyle(color: AppColors.black),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (ok != null)
                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.color2),
                          child: Text(
                            ok,
                            style: getbodyStyle(color: AppColors.black),
                          ),
                        ),
                      ),
                    if (no != null)
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.color2),
                          child: Text(
                            no,
                            style: getbodyStyle(color: AppColors.black),
                          ),
                        ),
                      ),
                  ],
                )
              ],
            ),
          )
        ],
      );
    },
  );
}
