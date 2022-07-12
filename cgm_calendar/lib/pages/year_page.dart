import 'package:cgm_calendar/model/year_page_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearPage extends StatelessWidget {
  bool _needCalculate = false;
  final Key _centerKey = const ValueKey("second-sliver-list");

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
                onPressed: () {},
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
      body: ChangeNotifierProvider<YearPageModel>(
        create: (_) => YearPageModel(),
        builder: (context, child) => NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            debugPrint(
                "viewportDimension : ${notification.metrics.viewportDimension}");
            debugPrint("scroll : ${notification.metrics.pixels}");
            debugPrint("max : ${notification.metrics.maxScrollExtent}");
            if (notification.metrics.pixels >
                (notification.metrics.maxScrollExtent - 100)) {
              if (_needCalculate) {
                _needCalculate = false;
                Provider.of<YearPageModel>(context, listen: false).addData();
              }
            } else if (notification.metrics.viewportDimension +
                    notification.metrics.maxScrollExtent +
                    notification.metrics.pixels <
                100) {
              if (_needCalculate) {
                _needCalculate = false;
                Provider.of<YearPageModel>(context, listen: false).addData();
              }
            } else {
              _needCalculate = true;
            }

            return true;
          },
          child: CustomScrollView(
            center: _centerKey,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  ((context, index) {
                    return Container(
                      height: 100,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 1))),
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        context
                            .watch<YearPageModel>()
                            .oldYears[index]
                            .year
                            .toString(),
                      ),
                    );
                  }),
                  childCount: context.watch<YearPageModel>().oldYears.length,
                ),
              ),
              SliverList(
                key: _centerKey,
                delegate: SliverChildBuilderDelegate(
                  ((context, index) {
                    return Container(
                      height: 100,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 1))),
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        context
                            .watch<YearPageModel>()
                            .newYears[index]
                            .year
                            .toString(),
                      ),
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

// class YearPage extends StatefulWidget {
//   YearPage({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _YearPageState();
// }

// class _YearPageState extends State<YearPage> {
//   List<String> data = [
//     "2018",
//     "2019",
//     "2020",
//     "2021",
//     "2022",
//     "2023",
//     "2024",
//     "2025",
//     "2026",
//   ];
//   int year = 0;
//   bool needCalculate = false;
//   ScrollController controller = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final contentSize = controller.position.viewportDimension +
//           controller.position.maxScrollExtent;
//       final target = contentSize * 4 / data.length;
//       controller.jumpTo(target);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.red,
//         elevation: 1,
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.add,
//             ),
//           )
//         ],
//       ),
//       bottomNavigationBar: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey,
//               blurRadius: 1,
//             )
//           ],
//         ),
//         child: SafeArea(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.calendar_today,
//                   color: Colors.red,
//                 ),
//               ),
//               const Spacer(),
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.menu,
//                   color: Colors.red,
//                 ),
//               ),
//               const Spacer(),
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.info_outline,
//                   color: Colors.red,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: NotificationListener<ScrollNotification>(
//         onNotification: (notification) {
//           if (notification.metrics.pixels < 10) {
//             if (!needCalculate) {
//               return true;
//             }

//             String first = data[0];
//             year = int.parse(first);
//             List<String> newData = [
//               (year - 4).toString(),
//               (year - 3).toString(),
//               (year - 2).toString(),
//               (year - 1).toString(),
//             ];
//             newData.addAll(data);
//             data = newData;
//           } else if (notification.metrics.pixels >
//               (notification.metrics.maxScrollExtent - 100)) {
//             if (!needCalculate) {
//               return true;
//             }
//             String last = data[data.length - 1];
//             year = int.parse(last);
//             List<String> newData = [
//               (year + 1).toString(),
//               (year + 2).toString(),
//               (year + 3).toString(),
//               (year + 4).toString(),
//             ];
//             data.addAll(newData);
//           } else {
//             needCalculate = true;
//             return true;
//           }

//           needCalculate = false;
//           setState(() {
//             data;
//             final contentSize = controller.position.viewportDimension +
//                 controller.position.maxScrollExtent;
//             final target = contentSize * 4 / data.length;
//             controller.jumpTo(target + controller.offset);
//           });
//           debugPrint("scroll : ${notification.metrics.pixels}");
//           debugPrint("max : ${notification.metrics.maxScrollExtent}");
//           return true;
//         },
//         child: ListView.builder(
//           controller: controller,
//           itemCount: data.length,
//           itemBuilder: ((context, index) {
//             return Container(
//               height: 200,
//               decoration: const BoxDecoration(
//                   border: Border(
//                       bottom: BorderSide(color: Colors.black, width: 1))),
//               margin: const EdgeInsets.all(10),
//               child: Text(data[index]),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
