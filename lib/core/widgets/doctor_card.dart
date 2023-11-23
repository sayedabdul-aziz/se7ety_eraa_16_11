import 'package:flutter/material.dart';
import 'package:se7ety_eraa_16_11/core/utils/app_colors.dart';
import 'package:se7ety_eraa_16_11/core/utils/app_text_styles.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard(
      {super.key,
      required this.name,
      required this.image,
      required this.specialization,
      required this.rating,
      required this.onPressed});

  final String name;
  final String image;
  final String specialization;
  final int rating;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: Card(
        color: Colors.blue[50],
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: const Offset(-3, 0),
                blurRadius: 15,
                color: Colors.grey.withOpacity(.1),
              )
            ],
          ),
          child: TextButton(
            onPressed: onPressed,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.white),
                    child: Image.network(
                      image,
                      height: 50,
                      width: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: getTitleStyle(fontSize: 16),
                      ),
                      Text(
                        specialization,
                        style: getbodyStyle(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        rating.toString(),
                        style: getbodyStyle(),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const Icon(
                        Icons.star_rate_rounded,
                        size: 20,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
