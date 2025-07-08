import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/design/color_style.dart';
import 'package:notes_app_sqflite/models/banner_models.dart';
import 'package:notes_app_sqflite/providers/automatic_banner_provider.dart';
import 'package:provider/provider.dart';

class BannerImageWidget extends StatefulWidget {
  const BannerImageWidget({Key? key}) : super(key: key);

  @override
  State<BannerImageWidget> createState() => _BannerImageWidgetState();
}

class _BannerImageWidgetState extends State<BannerImageWidget> {
  final List<BannerModel> _dataBanner = [
    BannerModel(
        title: 'title',
        description: 'description',
        image: 'assets/banner/banner 1.png'),
    BannerModel(
        title: 'title',
        description: 'description',
        image: 'assets/banner/banner 2.png'),
  ];
  @override
  void initState() {
    super.initState();
    context
        .read<AnimationBannerProvider>()
        .animationMoveOtomation(length: _dataBanner.length);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: PageView.builder(
        itemCount: _dataBanner.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ValueListenableBuilder<int>(
            valueListenable:
                context.read<AnimationBannerProvider>().automaticIndex,
            builder: (context, indexAnimation, _) {
              index = indexAnimation;
              return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor,
                    image: DecorationImage(
                        image: AssetImage(_dataBanner[index].image),
                        fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _dataBanner[index].title,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(_dataBanner[index].description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: secondaryColor)),
                      ],
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
