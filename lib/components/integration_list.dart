import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/providers/user_provider.dart';
import 'package:yonomi_flutter_demo/themes/app_themes.dart';

class IntegrationList extends StatelessWidget {
  final Future<List<Integration>>? integrations;
  final ValueChanged<String?>? onPress;

  const IntegrationList({Key? key, this.integrations, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: integrations,
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return Text("Couldn't load integrations");
          } else if (snapshot.hasData) {
            var integrationsFromSnapshot = snapshot.data as List<Integration>;
            if (integrationsFromSnapshot.isEmpty) {
              return Text('No Integration Found');
            }
            final idChips = integrationsFromSnapshot
                .map<Widget>((integration) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ActionChip(
                        label: Text(
                          integration.displayName!,
                          style: AppThemes.deviceItemTextName,
                        ),
                        onPressed: () => onPress!(integration.id),
                        backgroundColor: Colors.white,
                      ),
                    ))
                .toList();
            return Wrap(
              children: idChips,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
              heightFactor: 4.0,
            );
          }
        });
  }
}
