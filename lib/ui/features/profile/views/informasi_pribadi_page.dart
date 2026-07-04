import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../ui/core/widgets/hondaku_avatar.dart';
import 'package:hondaku/ui/core/widgets/hondaku_toast.dart';
import '../widgets/profile_theme.dart';
import '../view_models/profile_view_model.dart';
import 'profile.dart';

class InformasiPribadiPage extends ConsumerStatefulWidget {
  const InformasiPribadiPage({super.key});

  @override
  ConsumerState<InformasiPribadiPage> createState() => _InformasiPribadiPageState();
}

class _InformasiPribadiPageState extends ConsumerState<InformasiPribadiPage> {
  late TextEditingController _namaController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _nikController;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(userProfileProvider);
    _namaController = TextEditingController(text: profile.nama);
    _usernameController = TextEditingController(text: profile.username);
    _emailController = TextEditingController(text: profile.email);
    _phoneController = TextEditingController(text: profile.phone);
    _nikController = TextEditingController(text: profile.nik);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nikController.dispose();
    super.dispose();
  }

  void _saveProfile(ProfileLocalizations loc) {
    final nama = _namaController.text.trim();
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final nik = _nikController.text.trim();

    if (nama.isEmpty) {
      _showError(loc.isEn ? 'Name cannot be empty!' : 'Nama tidak boleh kosong!');
      return;
    }
    if (username.isEmpty) {
      _showError(loc.isEn ? 'Username cannot be empty!' : 'Username tidak boleh kosong!');
      return;
    }
    if (email.isEmpty || !email.contains('@')) {
      _showError(loc.isEn ? 'Please enter a valid email!' : 'Harap masukkan email yang valid!');
      return;
    }
    if (phone.isEmpty || phone.length < 9) {
      _showError(loc.isEn ? 'Please enter a valid phone number!' : 'Harap masukkan nomor HP yang valid!');
      return;
    }
    if (nik.length != 16) {
      _showError(loc.isEn ? 'NIK must be 16 digits!' : 'NIK harus berukuran 16 digit!');
      return;
    }

    final currentProfile = ref.read(userProfileProvider);
    ref.read(userProfileProvider.notifier).updateProfile(
      nama: nama,
      username: username,
      email: email,
      phone: phone,
      nik: nik,
      avatarPath: currentProfile.avatarPath,
      isCustomAvatar: currentProfile.isCustomAvatar,
      avatarBgColor: currentProfile.avatarBgColor,
    );

    HondakuToast.showSuccess(context, loc.profileUpdated);
    Navigator.pop(context);
  }

  void _showError(String message) {
    HondakuToast.showError(context, message);
  }

  @override
  Widget build(BuildContext context) {
    final settingsVal = ref.watch(appSettingsProvider);
    final isDark = false;
    final theme = ProfileThemeColors(isDark);
    final loc = ProfileLocalizations(settingsVal.selectedLanguage);

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
          loc.personalInfo,
          style: TextStyle(color: theme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: theme.surface, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const HondakuAvatar(radius: 50, fontSize: 28),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () => ProfilePage.showAvatarPicker(context, theme, loc, ref),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: theme.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildFieldLabel(loc.fullName, theme),
            _buildTextField(_namaController, loc.fullName, theme),
            const SizedBox(height: 16),
            _buildFieldLabel(loc.username, theme),
            _buildTextField(_usernameController, loc.username, theme),
            const SizedBox(height: 16),
            _buildFieldLabel(loc.email, theme),
            _buildTextField(_emailController, loc.email, theme, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 16),
            _buildFieldLabel(loc.phoneNumber, theme),
            _buildPhoneField(theme),
            const SizedBox(height: 16),
            _buildFieldLabel(loc.nationalId, theme),
            _buildTextField(_nikController, loc.nationalId, theme, keyboardType: TextInputType.number),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _saveProfile(loc),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  elevation: 0,
                ),
                child: Text(
                  loc.saveChanges,
                  style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label, ProfileThemeColors theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 2),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: theme.textSecondary,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    ProfileThemeColors theme, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 14, color: theme.textPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: theme.textSecondary.withValues(alpha: 0.5)),
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildPhoneField(ProfileThemeColors theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: theme.border)),
            ),
            child: Text(
              '+62',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: theme.textPrimary),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: TextStyle(fontSize: 14, color: theme.textPrimary),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
