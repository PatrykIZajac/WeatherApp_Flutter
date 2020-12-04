import 'package:first_app/generated/l10n.dart';
import 'package:first_app/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class inputWidget extends StatefulWidget {
  @override
  _inputWidgetState createState() => _inputWidgetState();
}

class _inputWidgetState extends State<inputWidget> {
  final nameHolder = TextEditingController();

  clearTextInput() {
    nameHolder.clear();
  }

  @override
  void dispose() {
    nameHolder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextField(
              style: TextStyle(color: Theme.of(context).primaryColor),
              cursorColor: Theme.of(context).primaryColor,
              controller: nameHolder,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  hintText: '${delegate.SearchInputText}',
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor)),
              onSubmitted: (String input) {
                context.read<WeatherProvider>().getWeatherByName(input);
                clearTextInput();
              },
            ),
          ),
        ),
        IconButton(
            icon: Icon(
              Icons.place,
              color: Theme.of(context).primaryColor,
              size: 35,
            ),
            onPressed: () {
              print("data fetch from localisation");
              context.read<WeatherProvider>().getWeatherByCurrentPosition();
            })
      ],
    );
  }
}
