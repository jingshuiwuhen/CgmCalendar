import 'package:cgm_calendar/model/year_page_model.dart';
import 'package:cgm_calendar/widgets/cell_one_year.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearPage extends StatelessWidget {
  bool _needCalculate = false;
  bool _todayBtnClicked = false;
  final Key _centerKey = const ValueKey("second-sliver-list");
  final ScrollController _scrollController = ScrollController();

  YearPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<YearPageModel>(
      create: (_) => YearPageModel(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.red,
          elevation: 1,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
              )
            ],
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _todayBtnClicked = true;
                    Provider.of<YearPageModel>(context, listen: false)
                        .initData();
                    _scrollController.animateTo(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.decelerate);
                  },
                  icon: const Icon(
                    Icons.calendar_today,
                    color: Colors.red,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.red,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.info_outline,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels == 0) {
              _todayBtnClicked = false;
            }

            if (_todayBtnClicked) {
              return true;
            }

            var itemHeight = (notification.metrics.viewportDimension +
                    notification.metrics.maxScrollExtent) /
                Provider.of<YearPageModel>(context, listen: false)
                    .newYears
                    .length;
            if (notification.metrics.pixels >
                (notification.metrics.maxScrollExtent - 100)) {
              if (_needCalculate) {
                _needCalculate = false;
                Provider.of<YearPageModel>(context, listen: false)
                    .addNewYears(true);
              }
            } else if (itemHeight *
                        Provider.of<YearPageModel>(context, listen: false)
                            .oldYears
                            .length +
                    notification.metrics.pixels <
                100) {
              if (_needCalculate) {
                _needCalculate = false;
                Provider.of<YearPageModel>(context, listen: false)
                    .addOldYears(true);
              }
            } else {
              _needCalculate = true;
            }

            return true;
          },
          child: CustomScrollView(
            controller: _scrollController,
            center: _centerKey,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  ((context, index) {
                    return CellOneYear(
                      yearModel: context.watch<YearPageModel>().oldYears[index],
                    );
                  }),
                  childCount: context.watch<YearPageModel>().oldYears.length,
                ),
              ),
              SliverList(
                key: _centerKey,
                delegate: SliverChildBuilderDelegate(
                  ((context, index) {
                    return CellOneYear(
                      yearModel: context.watch<YearPageModel>().newYears[index],
                    );
                  }),
                  childCount: context.watch<YearPageModel>().newYears.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
