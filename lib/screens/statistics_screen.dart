import 'package:atrap_io/responsive.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  static const routeName = '/statistics';

  const StatisticsScreen({Key? key}) : super(key: key);

  Widget _page({
    required String site,
    required String stats,
  }) =>
      Card(
        child: ListTile(
          title: Text(site),
          trailing: Text(stats),
        ),
      );

  Widget _statsCard({
    required BuildContext context,
    required String stats,
    required String title,
  }) =>
      Padding(
        padding: const EdgeInsets.only(
          bottom: 20.0,
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8.0,
                  ),
                  child: Text(
                    stats,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
        ),
      );

  Widget _view(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      bottom: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "A.I-2021123-1",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 16 / 13,
              ),
              delegate: SliverChildListDelegate.fixed([
                _statsCard(context: context, stats: "5000", title: "Visites"),
                _statsCard(
                    context: context, stats: "5000", title: "Conversions"),
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Nombre de viste par page",
                      style: Theme.of(context).textTheme.headline6!.copyWith(),
                    ),
                  ),
                  _page(
                    site: "google.com",
                    stats: "1.M",
                  ),
                  _page(
                    site: "google.com",
                    stats: "1.M",
                  ),
                  _page(
                    site: "google.com",
                    stats: "1.M",
                  ),
                ],
              ),
            )
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
        desktop: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (MediaQuery.of(context).size.width - 800) / 2,
          ),
          child: _view(context),
        ),
      ),
    );
  }
}
