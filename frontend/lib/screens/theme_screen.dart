import 'package:flutter/material.dart';
import 'package:frontend/controllers/theme_controller.dart';
import 'package:frontend/widgets/custom_back_button.dart';
import 'package:get/get.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dark Mode'),
        leading: const CustomBackButton(),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children:
                ThemeMode.values.map((mode) {
                  return _buildThemeCard(mode, themeController);
                }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeCard(ThemeMode mode, ThemeController controller) {
    final modeText = {
      ThemeMode.dark: 'On',
      ThemeMode.light: 'Off',
      ThemeMode.system: 'System',
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
