import 'package:hondaku/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hondaku/ui/core/widgets/hondaku_toast.dart';
import '../view_models/profile_view_model.dart';
import '../widgets/profile_theme.dart';

// SUB-PAGE: SETTINGS (PENGATURAN)

class PengaturanPage extends ConsumerWidget {
  const PengaturanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    final loc = AppLocalizations.of(context)!;
    const isDark = false;
    final theme = ProfileThemeColors(isDark);
    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.surface,
        elevation: 0.5,
        iconTheme: IconThemeData(color: theme.textPrimary),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.textPrimary, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          loc.settings,
          style: TextStyle(color: theme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            loc.appAndAccount,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: theme.textSecondary),
          ),
          const SizedBox(height: 10),
          _buildSwitchTile(
            title: loc.appNotifications,
            subtitle: loc.notificationsDesc,
            value: appSettings.notifEnabled,
            onChanged: (v) {
              ref.read(appSettingsProvider.notifier).updateSettings(notifEnabled: v);
            },
            theme: theme,
          ),
          const SizedBox(height: 10),
          _buildSwitchTile(
            title: loc.biometricLogin,
            subtitle: loc.biometricDesc,
            value: appSettings.biometricEnabled,
            onChanged: (v) {
              ref.read(appSettingsProvider.notifier).updateSettings(biometricEnabled: v);
              HondakuToast.showSuccess(
                context,
                v
                    ? ((Localizations.localeOf(context).languageCode == 'en') ? 'Biometric login enabled!' : 'Login biometrik diaktifkan!')
                    : ((Localizations.localeOf(context).languageCode == 'en') ? 'Biometric login disabled!' : 'Login biometrik dinonaktifkan!'),
              );
            },
            theme: theme,
          ),
          const SizedBox(height: 14),
          Text(
            loc.localization,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: theme.textSecondary),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: theme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.border),
            ),
            child: ListTile(
              title: Text(loc.languageLabel, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: theme.textPrimary)),
              subtitle: Text(appSettings.selectedLanguage, style: TextStyle(fontSize: 12, color: theme.textSecondary)),
              trailing: Icon(Icons.chevron_right, color: theme.textSecondary),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: theme.surface,
                  builder: (context) {
                    return SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text('Bahasa Indonesia', style: TextStyle(color: theme.textPrimary)),
                            trailing: appSettings.selectedLanguage == 'Bahasa Indonesia' ? Icon(Icons.check, color: theme.red) : null,
                            onTap: () {
                              ref.read(appSettingsProvider.notifier).updateSettings(selectedLanguage: 'Bahasa Indonesia');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('English', style: TextStyle(color: theme.textPrimary)),
                            trailing: appSettings.selectedLanguage == 'English' ? Icon(Icons.check, color: theme.red) : null,
                            onTap: () {
                              ref.read(appSettingsProvider.notifier).updateSettings(selectedLanguage: 'English');
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required ProfileThemeColors theme,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.border),
      ),
      child: SwitchListTile(
        activeThumbColor: theme.red,
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: theme.textPrimary)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: theme.textSecondary)),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
