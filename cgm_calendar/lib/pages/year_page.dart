import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/widgets/cell_one_year.dart';
import 'package:flutter/material.dart';

class YearPage extends StatelessWidget {
  final Key _centerKey = const ValueKey("second-sliver-list");
  final ScrollController _scrollController = ScrollController();

  YearPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOutSine,
                  );
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
      body: CustomScrollView(
        controller: _scrollController,
        center: _centerKey,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              ((context, index) {
                return CellOneYear(
                  yearModel: Global.oldYears[index],
                );
              }),
              childCount: Global.oldYears.length,
            ),
          ),
          SliverList(
            key: _centerKey,
            delegate: SliverChildBuilderDelegate(
              ((context, index) {
                return CellOneYear(
                  yearModel: Global.newYears[index],
                );
              }),
              childCount: Global.newYears.length,
            ),
          ),
        ],
      ),
    );
  }
}
