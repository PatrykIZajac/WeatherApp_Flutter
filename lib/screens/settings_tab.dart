import 'package:first_app/generated/l10n.dart';
import 'package:first_app/local_storage/user_preferences.dart';
import 'package:first_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    const unit_hpa = 'hpa';
    const unit_psi = 'psi';
    const unit_km = 'km/h';
    const unit_mph = 'mph';

    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          Text(
            '${delegate.TemperatureMeasureText}',
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: ToggleSwitch(
              initialLabelIndex: int.parse(UserPreferences().getMeasureUnit()),
              labels: ['K\u00B0', 'F\u00B0', 'C\u00B0'],
              inactiveBgColor: Colors.white,
              inactiveFgColor: Theme.of(context).primaryColor,
              activeBgColor: Theme.of(context).primaryColor,
              onToggle: (index) {
                UserPreferences().setMeasureUnit(index.toString());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    '${delegate.LanguageText}',
                    style: TextStyle(
                        fontSize: 30, color: Theme.of(context).primaryColor),
                  ),
                ),
                Center(
                  child: DropdownButton(
                      dropdownColor: Color(0xFF1E1E20),
                      value: UserPreferences().getLang(),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 20),
                      underline: Container(
                        height: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.public,
                          size: 20,
                        ),
                      ),
                      items: AppLocalizationDelegate()
                          .supportedLocales
                          .map<DropdownMenuItem<String>>((Locale locale) {
                        return DropdownMenuItem<String>(
                            value: locale.languageCode,
                            child: Text(locale.languageCode));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          S.load(Locale(value));
                        });
                        UserPreferences().setLang(value);
                      }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    '${delegate.SpeedUnit}',
                    style: TextStyle(
                        fontSize: 30, color: Theme.of(context).primaryColor),
                  ),
                ),
                DropdownButton(
                    dropdownColor: Color(0xFF1E1E20),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(Icons.speed),
                    ),
                    value: UserPreferences().getSpeedUnit(),
                    items: <String>[unit_km, unit_mph]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        UserPreferences().setSpeedUnit(value);
                      });
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    '${delegate.PressureText}',
                    style: TextStyle(
                        fontSize: 30, color: Theme.of(context).primaryColor),
                  ),
                ),
                DropdownButton(
                    dropdownColor: Color(0xFF1E1E20),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(Icons.speed),
                    ),
                    value: UserPreferences().getPressureUnit(),
                    items: <String>[unit_hpa, unit_psi]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        UserPreferences().setPressureUnit(value);
                      });
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${delegate.darkModeText}',
                  style: TextStyle(
                      fontSize: 30, color: Theme.of(context).primaryColor),
                ),
                Switch(
                  value: context.watch<ThemeProvider>().dark,
                  onChanged: (value) {
                    context.read<ThemeProvider>().setLight(value);
                    setState(() {
                      UserPreferences().setDarkMode(value.toString());
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                  activeTrackColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
