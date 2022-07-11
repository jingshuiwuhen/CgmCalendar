import 'package:flutter/material.dart';

class YearPage extends StatefulWidget {
  YearPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _YearPageState();
}

class _YearPageState extends State<YearPage> {
  List<String> data = [
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
  ];

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
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          debugPrint("scroll : ${notification.metrics.pixels}");
          debugPrint("max : ${notification.metrics.maxScrollExtent}");
          return true;
        },
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: ((context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              child: Text(data[index]),
            );
          }),
        ),
      ),
    );
  }
}
