import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/app_colors.dart';
import 'settings_provider.dart';

class SettingsTab extends StatelessWidget {
  static const routeName = "settings";
  late SettingsProvider provider;
  bool darkSwitchValue = false;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    darkSwitchValue = provider.isDarkMode();

    return const Placeholder();
  }
  buildOptionRow(String title, bool value, Function(bool) onChanged,BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 12,),
        Text(title, style: Theme.of(context).textTheme.bodySmall),
        Spacer(),
        Switch(value: value, onChanged: onChanged, activeColor: AppColors.primiary,)
      ],
    );
  }
}