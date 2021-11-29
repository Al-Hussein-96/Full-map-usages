import 'package:flutter/material.dart';
import 'package:full_map_uses/models/suggestion.dart';
import 'package:full_map_uses/provider/place_api_provider.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  final sessionToken;
  late PlaceApiProvider apiClient;

  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        // close(context,);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("Mohammad");

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print(query);
    return FutureBuilder<List<Suggestion>>(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(
          query, Localizations
          .localeOf(context)
          .languageCode),
      builder: (context, snapshot) {
        if(query == ''){
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Text('Enter your address'),
          );
        }else{
          if(snapshot.hasData){
            List<Suggestion>? list = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) =>
                  ListTile(
                    title:
                    Text((list![index]).description),
                    onTap: () {
                      close(context, list[index]);
                    },
                  ),
              itemCount: list!.length,
            );
          }else{
            return Container(child: Text('Loading...'));
          }
        }



      },
    );
  }
}
