import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se7ety_eraa_16_11/core/utils/app_colors.dart';
import 'package:se7ety_eraa_16_11/core/utils/app_text_styles.dart';
import 'package:se7ety_eraa_16_11/feature/patient/search/presentaion/view/widgets/search_list.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _textController = TextEditingController();
  String? search;
  var _length = 0;

  @override
  void initState() {
    super.initState();
    search = _textController.text;
    _length = search!.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ابحث عن دكتور',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                  )
                ],
              ),
              child: TextField(
                onChanged: (searchKey) {
                  setState(
                    () {
                      search = searchKey;
                      _length = search!.length;
                    },
                  );
                },
                decoration: InputDecoration(
                  hintText: "البحث",
                  hintStyle: getbodyStyle(),
                  suffixIcon: SizedBox(
                      width: 50,
                      child: Icon(Icons.search, color: AppColors.color1)),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: _length == 0
                    ? Center(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _length = 1;
                                  });
                                },
                                child: Text(
                                  'عرض كل الدكاتره',
                                  style: getTitleStyle(),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/no-search.svg',
                                width: 250,
                              ),
                            ],
                          ),
                        ),
                      )
                    : SearchList(
                        searchKey: search ?? '',
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
