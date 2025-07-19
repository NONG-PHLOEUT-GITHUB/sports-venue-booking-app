import 'package:flutter/material.dart';
import 'package:frontend/screens/edite_account.dart';
import 'package:frontend/screens/switch_language_screen.dart';
import 'package:frontend/utils/theme_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<ProfilePage> {
  String _fullName = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _fullName = prefs.getString('user_full_name') ?? 'Nong';
        _email = prefs.getString('user_email') ?? 'nong168@gmail.com';
      });
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 16),
            _buildSettingsOptions(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: const AssetImage('assets/images/profile.jpeg'),
            backgroundColor: Colors.grey[200],
            onBackgroundImageError: (exception, stackTrace) {
              debugPrint('Error loading image: $exception');
            },
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _fullName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _email,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfilePage(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.lightGreen.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.edit, color: Colors.lightGreen),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsOptions() {
    final ThemeController themeController = Get.find();

    return Obx(() {
      bool isDark = themeController.isDark;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            _buildSettingsSection([
              _buildSettingsTile(
                icon: Icons.language_outlined,
                title: 'Change Language',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SwitchLanguagePage(),
                    ),
                  );
                },
              ),
              _buildSettingsTile(
                icon: Icons.dark_mode,
                title: 'Theme',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isDark ? 'Dark' : 'Light',
                      style: TextStyle(fontSize: 14),
                    ),
                    Transform.scale(
                      scale: 0.75,
                      child: Switch(
                        value: isDark,
                        onChanged: (value) {
                          themeController.toggleTheme(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            const SizedBox(height: 16),
            _buildSettingsSection([
              _buildSettingsTile(
                icon: Icons.info_outline,
                title: 'Helps & Supports',
                onTap: () {
                  debugPrint('Helps & Supports tapped');
                },
              ),
              _buildSettingsTile(
                icon: Icons.history,
                title: 'Order History',
                onTap: () {
                  debugPrint('Order History tapped');
                },
              ),
              _buildSettingsTile(
                icon: Icons.lock,
                title: 'Change Password',
                onTap: () {
                  debugPrint('Change Password tapped');
                },
              ),
            ]),
            const SizedBox(height: 16),
            _buildSettingsSection([
              _buildSettingsTile(
                icon: Icons.logout,
                title: 'Logout',
                onTap: _logout,
                isLogout: true,
                isLastInGroup: true,
              ),
            ]),
          ],
        ),
      );
    });
  }

  Widget _buildSettingsSection(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children:
            children.map((widget) {
              if (widget is _SettingsTile) {
                return Column(
                  children: [
                    widget,
                    if (!widget.isLastInGroup)
                      Divider(
                        height: 1,
                        indent: 60,
                        endIndent: 16,
                        color: Colors.grey[200],
                      ),
                  ],
                );
              }
              return widget;
            }).toList(),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    final VoidCallback? onTap,
    bool isLogout = false,
    bool isLastInGroup = false,
    final Widget? trailing,
  }) {
    return _SettingsTile(
      icon: icon,
      title: title,
      onTap: onTap,
      isLogout: isLogout,
      isLastInGroup: isLastInGroup,
      trailing: trailing,
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool isLogout;
  final bool isLastInGroup;
  final Widget? trailing;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isLogout = false,
    this.isLastInGroup = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    // Determine vertical padding more precisely based on the type of trailing widget.
    // If no trailing widget, or default arrow, use a standard padding.
    // If a Switch is the trailing widget, use less vertical padding to compensate for its height.
    double verticalPadding;
    if (trailing is Row &&
        (trailing as Row).children.any(
          (c) => c is Transform && (c as Transform).child is Switch,
        )) {
      verticalPadding = 6.0; // Reduced padding for the Theme row (with Switch)
    } else {
      verticalPadding = 11.0; // Standard padding for other rows
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: verticalPadding,
        ),
        child: Row(
          children: [
            Icon(icon, color: isLogout ? Colors.red : Colors.black54),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isLogout ? Colors.red : Colors.black,
                ),
              ),
            ),
            if (trailing != null)
              trailing!
            else
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: isLogout ? Colors.red : Colors.grey,
              ),
          ],
        ),
      ),
    );
  }
}
