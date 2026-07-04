import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hondaku/ui/core/widgets/hondaku_toast.dart';
import '../view_models/profile_view_model.dart';
import '../widgets/profile_theme.dart';

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// SUB-PAGE: PAYMENT METHODS (METODE PEMBAYARAN)
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class MetodePembayaranPage extends ConsumerWidget {
  const MetodePembayaranPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    final isDark = false;
    final theme = ProfileThemeColors(isDark);
    final loc = ProfileLocalizations(appSettings.selectedLanguage);
    final methodsList = ref.watch(paymentMethodsProvider);

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
          loc.paymentMethods,
          style: TextStyle(color: theme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.savedPayment,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: theme.textPrimary),
            ),
            const SizedBox(height: 14),
            if (methodsList.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Text(
                    loc.isEn ? 'No payment methods saved' : 'Belum ada metode pembayaran tersimpan',
                    style: TextStyle(color: theme.textSecondary),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: methodsList.length,
                  itemBuilder: (context, idx) {
                    final item = methodsList[idx];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildCardTile(context, ref, item, theme, loc),
                    );
                  },
                ),
              ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: theme.surface,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    builder: (context) {
                      return AddPaymentMethodSheet(theme: theme, loc: loc);
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  elevation: 0,
                ),
                icon: const Icon(Icons.add, color: Colors.white),
                label: Text(
                  loc.addPayment,
                  style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardTile(
    BuildContext context,
    WidgetRef ref,
    PaymentMethodItem item,
    ProfileThemeColors theme,
    ProfileLocalizations loc,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item.isDefault ? theme.red : theme.border,
          width: item.isDefault ? 1.8 : 1.0,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 52,
          height: 36,
          decoration: BoxDecoration(
            color: theme.isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.all(4),
          child: Image.asset(item.logoPath, fit: BoxFit.contain),
        ),
        title: Text(
          item.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: theme.textPrimary),
        ),
        subtitle: Text(
          item.isDefault ? (loc.isEn ? 'Primary Payment Method' : 'Metode Utama') : item.subtitle,
          style: TextStyle(fontSize: 12, color: item.isDefault ? theme.red : theme.textSecondary),
        ),
        trailing: item.isDefault
            ? Icon(Icons.check_circle, color: theme.red)
            : IconButton(
                icon: Icon(Icons.more_vert, color: theme.textSecondary),
                onPressed: () => _showPaymentOptions(context, ref, item, theme, loc),
              ),
        onTap: () {
          if (!item.isDefault) {
            _showPaymentOptions(context, ref, item, theme, loc);
          }
        },
      ),
    );
  }

  void _showPaymentOptions(
    BuildContext context,
    WidgetRef ref,
    PaymentMethodItem item,
    ProfileThemeColors theme,
    ProfileLocalizations loc,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  item.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: theme.textPrimary),
                ),
              ),
              Divider(height: 1, color: theme.border),
              ListTile(
                leading: Icon(Icons.check_circle_outline, color: theme.red),
                title: Text(loc.setAsDefault, style: TextStyle(color: theme.textPrimary)),
                onTap: () {
                  ref.read(paymentMethodsProvider.notifier).setDefaultPayment(item.id);
                  Navigator.pop(context);
                  HondakuToast.showSuccess(
                    context,
                    loc.isEn ? 'Primary payment method updated!' : 'Metode pembayaran utama diperbarui!',
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: Text(loc.remove, style: const TextStyle(color: Colors.red)),
                onTap: () {
                  ref.read(paymentMethodsProvider.notifier).removePaymentMethod(item.id);
                  Navigator.pop(context);
                  HondakuToast.showSuccess(
                    context,
                    loc.isEn ? 'Payment method deleted!' : 'Metode pembayaran dihapus!',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// STATEFUL WIDGET: ADD PAYMENT METHOD SHEET
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class AddPaymentMethodSheet extends ConsumerStatefulWidget {
  final ProfileThemeColors theme;
  final ProfileLocalizations loc;

  const AddPaymentMethodSheet({
    super.key,
    required this.theme,
    required this.loc,
  });

  @override
  ConsumerState<AddPaymentMethodSheet> createState() => _AddPaymentMethodSheetState();
}

class _AddPaymentMethodSheetState extends ConsumerState<AddPaymentMethodSheet> {
  String _selectedType = 'VA';
  String _selectedBank = 'BCA';
  final TextEditingController _numberController = TextEditingController();
  bool _isDefault = false;

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  void _submit() {
    final number = _numberController.text.trim();
    final loc = widget.loc;
    if (number.isEmpty) {
      _showErr(loc.isEn ? 'Account or Card number is required!' : 'Nomor kartu/VA wajib diisi!');
      return;
    }
    if (_selectedType == 'VA' && number.length < 8) {
      _showErr(loc.isEn ? 'Virtual Account number is too short!' : 'Nomor Virtual Account terlalu pendek!');
      return;
    }
    if (_selectedType == 'CARD' && number.length < 15) {
      _showErr(loc.isEn ? 'Credit Card number is invalid!' : 'Nomor kartu kredit tidak valid!');
      return;
    }

    String title = '';
    String logoPath = 'assets/payments/bca.png';
    if (_selectedType == 'VA') {
      title = '$_selectedBank Virtual Account';
      if (_selectedBank == 'MANDIRI') {
        logoPath = 'assets/payments/mandiri.png';
      } else if (_selectedBank == 'BSI') {
        logoPath = 'assets/payments/bsi.png';
      }
    } else {
      final last4 = number.substring(number.length - 4);
      title = 'Visa Ending in $last4';
      logoPath = 'assets/payments/bca.png';
    }

    final id = 'PM-${DateTime.now().millisecondsSinceEpoch}';
    final newItem = PaymentMethodItem(
      id: id,
      title: title,
      subtitle: _selectedType == 'VA' ? 'Bank $_selectedBank' : 'Credit/Debit Card',
      logoPath: logoPath,
      isDefault: _isDefault,
      type: _selectedType,
    );

    ref.read(paymentMethodsProvider.notifier).addPaymentMethod(newItem);
    Navigator.pop(context);
    HondakuToast.showSuccess(
      context,
      loc.isEn ? 'New payment method added!' : 'Metode pembayaran berhasil ditambahkan!',
    );
  }

  void _showErr(String msg) {
    HondakuToast.showError(context, msg);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final loc = widget.loc;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  loc.addPayment,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textPrimary),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: theme.textSecondary),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTypeCard('VA', 'Virtual Account', Icons.account_balance),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTypeCard('CARD', loc.isEn ? 'Credit Card' : 'Kartu Kredit', Icons.credit_card),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_selectedType == 'VA') ...[
              Text(
                loc.isEn ? 'Select Bank' : 'Pilih Bank',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: theme.textSecondary),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedBank,
                    dropdownColor: theme.surface,
                    style: TextStyle(color: theme.textPrimary, fontSize: 14),
                    icon: Icon(Icons.keyboard_arrow_down, color: theme.textSecondary),
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: 'BCA', child: Text('Bank BCA')),
                      DropdownMenuItem(value: 'MANDIRI', child: Text('Bank Mandiri')),
                      DropdownMenuItem(value: 'BSI', child: Text('Bank BSI')),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedBank = val);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                loc.isEn ? 'Virtual Account Number' : 'Nomor Virtual Account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: theme.textSecondary),
              ),
            ] else ...[
              Text(
                loc.isEn ? 'Card Number' : 'Nomor Kartu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: theme.textSecondary),
              ),
            ],
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: theme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.border),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 14, color: theme.textPrimary),
                decoration: InputDecoration(
                  hintText: _selectedType == 'VA' ? 'e.g. 800012345678' : 'e.g. 4111222233334444',
                  hintStyle: TextStyle(color: theme.textSecondary.withValues(alpha: 0.5)),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              activeThumbColor: theme.red,
              title: Text(
                loc.isEn ? 'Set as primary payment method' : 'Jadikan metode pembayaran utama',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: theme.textPrimary),
              ),
              value: _isDefault,
              onChanged: (val) => setState(() => _isDefault = val),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  elevation: 0,
                ),
                child: Text(
                  loc.isEn ? 'Save Payment' : 'Simpan Metode',
                  style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeCard(String type, String title, IconData icon) {
    final theme = widget.theme;
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? (theme.isDark ? const Color(0xFF3E1C1C) : const Color(0xFFFFF2F2))
              : theme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? theme.red : theme.border,
            width: isSelected ? 1.8 : 1.0,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? theme.red : theme.textSecondary, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? theme.red : theme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
