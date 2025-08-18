import 'package:flutter/material.dart';
import 'package:frontend/controllers/locale_controller.dart';
import 'package:frontend/controllers/profile_controller.dart';
import 'package:frontend/screens/change_password_screen.dart';
import 'package:frontend/screens/theme_screen.dart';
import 'package:get/get.dart';
import 'package:frontend/screens/edite_account.dart';
import 'package:frontend/screens/switch_language_screen.dart';
import 'package:frontend/controllers/theme_controller.dart';
import 'package:frontend/l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ProfileController controller = Get.put(ProfileController());

  String _getThemeModeLabel(BuildContext context, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return AppLocalizations.of(context)!.on;
      case ThemeMode.light:
        return AppLocalizations.of(context)!.off;
      case ThemeMode.system:
      return AppLocalizations.of(context)!.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final localeController = Get.find<LocaleController>();
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.account)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 16),
            _buildSettingsCard([
              Obx(
                () => _buildSettingsTile(
                  icon: Icons.language_outlined,
                  title: localization.language,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        localeController.locale.languageCode == 'km'
                            ? AppLocalizations.of(context)!.khmer
                            : AppLocalizations.of(context)!.english,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios, size: 18),
                    ],
                  ),
                  onTap: () => Get.to(() => SwitchLanguageScreen()),
                ),
              ),
              Obx(
                () => _buildSettingsTile(
                  icon: Icons.dark_mode,
                  title: AppLocalizations.of(context)!.darkMode,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _getThemeModeLabel(
                          context,
                          themeController.themeMode.value,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios, size: 18),
                    ],
                  ),
                  onTap: () => Get.to(() => const ThemeScreen()),
                ),
              ),
            ]),
            const SizedBox(height: 16),
            _buildSettingsCard([
              _buildSettingsTile(
                icon: Icons.info_outline,
                title: AppLocalizations.of(context)!.tutorial,
                onTap: () => debugPrint('Support'),
              ),
              // _buildSettingsTile(
              //   icon: Icons.history,
              //   title: 'Order History',
              //   onTap: () => debugPrint('History'),
              // ),
              _buildSettingsTile(
                icon: Icons.lock,
                title: localization.changePassword,
                onTap: () => Get.to(() => ChangePasswordScreen()),
              ),
            ]),
            const SizedBox(height: 16),
            _buildSettingsCard([
              _buildSettingsTile(
                icon: Icons.logout,
                title: AppLocalizations.of(context)!.logout,
                onTap: () => controller.logout(),
                isLogout: true,
              ),
            ]),
          ],
        ),
      ),
    );
  }

  final editButton = Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26, width: 1.0),
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: IconButton(
        icon: Icon(Icons.edit, color: Get.theme.colorScheme.primary),
        onPressed: () => Get.to(() => EditProfilePage()),
      ),
    ),
  );

  Widget _buildProfileHeader() {
    return Obx(() {
      final user = controller.userData;

      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 1,
        color: Get.theme.colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/profile.jpeg'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${user['name'] ?? ''}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${user['email'] ?? ''}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              editButton,
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSettingsCard(List<Widget> tiles) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 1,
      color: Get.theme.colorScheme.surface,
      child: Column(
        children: List.generate(tiles.length * 2 - 1, (index) {
          if (index.isOdd) {
            return Divider(
              height: 1,
              indent: 60,
              endIndent: 16,
              color: Colors.grey[200],
            );
          }
          return tiles[index ~/ 2];
        }),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
    bool isLogout = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: isLogout ? Colors.red : null),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isLogout ? Colors.red : null,
                ),
              ),
            ),
            trailing ??
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: isLogout ? Colors.red : null,
                ),
          ],
        ),
      ),
    );
  }
}
