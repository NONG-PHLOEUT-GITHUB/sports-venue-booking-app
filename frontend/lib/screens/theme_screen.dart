import 'package:flutter/material.dart';
import 'package:frontend/controllers/theme_controller.dart';
import 'package:frontend/widgets/custom_back_button.dart';
import 'package:get/get.dart';
import 'package:frontend/l10n/app_localizations.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.darkMode),
        leading: const CustomBackButton(),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children:
                ThemeMode.values.map((mode) {
                  return _buildThemeCard(context,mode, themeController);
                }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeCard(BuildContext context,ThemeMode mode, ThemeController controller) {
    final modeText = {
      ThemeMode.dark: AppLocalizations.of(context)!.on,
      ThemeMode.light:AppLocalizations.of(context)!.off,
      ThemeMode.system: AppLocalizations.of(context)!.system,
    };

    return Card(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(modeText[mode]!),
        trailing: Radio<ThemeMode>(
          value: mode,
          groupValue: controller.themeMode.value,
          activeColor: Get.theme.colorScheme.primary,
          onChanged: (ThemeMode? selectedMode) {
            if (selectedMode != null) {
              controller.changeThemeMode(selectedMode);
            }
          },
        ),
        onTap: () => controller.changeThemeMode(mode),
      ),
    );
  }
}
