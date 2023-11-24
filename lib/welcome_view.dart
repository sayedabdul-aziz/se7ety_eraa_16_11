import 'package:flutter/material.dart';
import 'package:se7ety_eraa_16_11/core/utils/app_colors.dart';
import 'package:se7ety_eraa_16_11/core/utils/app_text_styles.dart';
import 'package:se7ety_eraa_16_11/feature/auth/presentation/view/signin_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                opacity: .7,
                image: AssetImage(
                  'assets/welcome-bg.png',
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 100, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اهلا بيك',
                  style: getTitleStyle(fontSize: 38),
                ),
                Text(
                  'سجل واحجز عند دكتورك وانت فالبيت',
                  style: getbodyStyle(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.color1.withOpacity(.5),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          blurRadius: 15,
                          offset: const Offset(5, 5),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'سجل دلوقتي كــ',
                          style: getbodyStyle(
                              fontSize: 18, color: AppColors.white),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginView(index: 0),
                                    ));
                              },
                              child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color:
                                          AppColors.scaffoldBG.withOpacity(.7),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      'دكتور',
                                      style:
                                          getTitleStyle(color: AppColors.black),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginView(index: 1),
                                    ));
                              },
                              child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color:
                                          AppColors.scaffoldBG.withOpacity(.7),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      'مريض',
                                      style:
                                          getTitleStyle(color: AppColors.black),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
