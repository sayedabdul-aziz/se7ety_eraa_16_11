import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se7ety_eraa_16_11/core/utils/app_colors.dart';
import 'package:se7ety_eraa_16_11/core/utils/app_text_styles.dart';
import 'package:se7ety_eraa_16_11/feature/patient/home/data/card_model.dart';
import 'package:se7ety_eraa_16_11/feature/patient/home/presentation/explore_specialists.dart';

class SpecialistsBanner extends StatelessWidget {
  const SpecialistsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("التخصصات", style: getTitleStyle(fontSize: 16)),
        SizedBox(
          height: 230,
          width: double.infinity,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExploreList(
                              specialization: cards[index].doctor,
                            )),
                  );
                },
                child: ItemCardWidget(
                    title: cards[index].doctor,
                    color: cards[index].cardBackground,
                    lightColor: cards[index].cardlightColor),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget(
      {super.key,
      required this.title,
      required this.color,
      required this.lightColor});
  final String title;
  final Color color;
  final Color lightColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      margin: const EdgeInsets.only(left: 15, bottom: 15, top: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 4),
            blurRadius: 10,
            color: lightColor.withOpacity(.8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -20,
              right: -20,
              child: CircleAvatar(
                backgroundColor: lightColor,
                radius: 60,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: SvgPicture.asset('assets/doctor-card.svg'),
                  ),
                  Flexible(
                    child: Text(title,
                        textAlign: TextAlign.center,
                        style: getTitleStyle(
                            color: AppColors.white, fontSize: 14)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
