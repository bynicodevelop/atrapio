import 'package:atrap_io/responsive.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  static const routeName = '/statistics';

  const StatisticsScreen({Key? key}) : super(key: key);

  Widget _page() => const Card(
        child: ListTile(
          title: Text("google.com"),
          trailing: Text("1.M"),
        ),
      );

  Widget _view(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "User Tracking ID",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "5000",
                        style:
                            Theme.of(context).textTheme.headline3!.copyWith(),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Visite",
                        style:
                            Theme.of(context).textTheme.headline6!.copyWith(),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "5000",
                        style:
                            Theme.of(context).textTheme.headline3!.copyWith(),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Conversion",
                        style:
                            Theme.of(context).textTheme.headline6!.copyWith(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Nombre de viste par page",
                  style: Theme.of(context).textTheme.headline6!.copyWith(),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            // SliverList(
            //   delegate: SliverChildListDelegate(
            //     [
            //       _page(),
            //       _page(),
            //       _page(),
            //       _page(),
            //     ],
            //   ),
            // ),
            SizedBox(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  _page(),
                ],
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "STATISTIQUES",
        ),
      ),
      body: Responsive(
        mobile: _view(context),
        tablet: _view(context),
        desktop: _view(context),
      ),
    );
  }
}
