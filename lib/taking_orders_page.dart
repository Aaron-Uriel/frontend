import 'package:flutter/material.dart';

import 'package:taquexpress/database_models_as_classes.dart';

class TakingOrdersPage extends StatefulWidget {
  TakingOrdersPage({Key? key, required this.futureClient}): super(key: key);

  final Future<Client> futureClient;

  @override
  _TakingOrdersPageState createState() => _TakingOrdersPageState();
}

class _TakingOrdersPageState extends State<TakingOrdersPage> {
  @override
  Widget build(BuildContext context) {
    final windowsSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: windowsSize.height * 0.05,
                  bottom: windowsSize.height * 0.05,
                  left: windowsSize.width * 0.025,
                  right: windowsSize.height * 0.025,
                ),
                child: FutureBuilder<Client>(
                  future: widget.futureClient,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final Client client = snapshot.data!;

                      final title = (client.tableId == null)
                      ? 'Orden para llevar'
                      : 'Orden para mesa ${client.tableId}';

                      return Text(
                        title,
                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.center,
                      );
                    } else
                    if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Column(
                      children: [
                        CircularProgressIndicator(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}