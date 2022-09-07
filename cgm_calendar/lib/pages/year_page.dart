import 'package:cgm_calendar/pages/set_schedule_page.dart';
import 'package:cgm_calendar/view_models/year_page_view_model.dart';
import 'package:cgm_calendar/widgets/cell_one_year.dart';
import 'package:cgm_calendar/widgets/left_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class YearPage extends StatelessWidget {
  final Key _centerKey = const ValueKey("second-sliver-list");
  final ScrollController _scrollController = ScrollController();
  late YearPageViewModel _rViewModel;
  late YearPageViewModel _wViewModel;

  YearPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => YearPageViewModel(),
      builder: (context, child) {
        _rViewModel = context.read<YearPageViewModel>();
        _wViewModel = context.watch<YearPageViewModel>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.red,
            elevation: 1,
            leading: const SizedBox(
              height: 0,
              width: 0,
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  await Navigator.of(context).push(_createRoute());
                  _rViewModel.refresh();
                },
                icon: const Icon(
                  Icons.add,
                ),
              ),
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
                  Builder(
                    builder: ((context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.red,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          drawer: const LeftDrawer(),
          body: CustomScrollView(
            controller: _scrollController,
            center: _centerKey,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return CellOneYear(
                        yearModel: _wViewModel.oldYears[index],
                        oneYearClick: () => _rViewModel.refresh());
                  },
                  childCount: _wViewModel.oldYears.length,
                ),
              ),
              SliverList(
                key: _centerKey,
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return CellOneYear(
                        yearModel: _wViewModel.newYears[index],
                        oneYearClick: () => _rViewModel.refresh());
                  },
                  childCount: _wViewModel.newYears.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          SetSchedulePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
