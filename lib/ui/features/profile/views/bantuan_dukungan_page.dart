import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hondaku/ui/core/widgets/hondaku_toast.dart';
import '../view_models/profile_view_model.dart';
import '../widgets/profile_theme.dart';

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// SUB-PAGE: HELP & SUPPORT (BANTUAN & DUKUNGAN)
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class BantuanDukunganPage extends ConsumerStatefulWidget {
  const BantuanDukunganPage({super.key});

  @override
  ConsumerState<BantuanDukunganPage> createState() => _BantuanDukunganPageState();
}

class _BantuanDukunganPageState extends ConsumerState<BantuanDukunganPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, String>> _allFaqs = [
    {
      'q_id': 'Bagaimana cara membatalkan booking unit?',
      'q_en': 'How do I cancel my booking?',
      'a_id': 'Uang booking fee dapat dikembalikan penuh jika pembatalan diajukan sebelum proses persiapan unit selesai. Silakan hubungi Sales Consultant Anda.',
      'a_en': 'The booking fee can be fully refunded if the cancellation is submitted before unit preparation is complete. Please contact your Sales Consultant.',
    },
    {
      'q_id': 'Berapa lama proses pengiriman motor?',
      'q_en': 'How long does the motorcycle delivery take?',
      'a_id': 'Pengiriman untuk wilayah Medan biasanya memakan waktu 1-3 hari kerja setelah dokumen kredit diverifikasi atau pembayaran tunai diterima.',
      'a_en': 'Delivery for the Medan area usually takes 1-3 business days after credit documents are verified or cash payment is received.',
    },
    {
      'q_id': 'Apakah data KTP saya aman?',
      'q_en': 'Is my ID (KTP) data secure?',
      'a_id': 'Ya, seluruh informasi identitas Anda dilindungi dengan standar enkripsi perbankan dan hanya digunakan untuk keperluan pengurusan surat jalan STNK/BPKB.',
      'a_en': 'Yes, all your identity information is protected with banking-grade encryption standards and only used for processing STNK/BPKB registration.',
    },
    {
      'q_id': 'Bagaimana cara membayar Virtual Account?',
      'q_en': 'How do I pay via Virtual Account?',
      'a_id': 'Salin nomor Virtual Account yang tertera di detail pesanan Anda, buka aplikasi Mobile Banking Anda, pilih menu Transfer VA, tempel nomor, dan selesaikan pembayaran.',
      'a_en': 'Copy the Virtual Account number shown in your order details, open your Mobile Banking app, select Transfer VA, paste the number, and complete the payment.',
    },
    {
      'q_id': 'Bagaimana cara mendaftarkan motor ke garasi?',
      'q_en': 'How do I add a motorcycle to my garage?',
      'a_id': 'Motor yang Anda beli melalui aplikasi Hondaku akan secara otomatis terdaftar di garasi setelah status pengiriman selesai.',
      'a_en': 'Motorcycles purchased via the Hondaku app will be automatically registered to your garage once the delivery is marked as completed.',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> _filteredFaqs(bool isEn) {
    if (_searchQuery.isEmpty) return _allFaqs;
    final query = _searchQuery.toLowerCase();
    return _allFaqs.where((faq) {
      final q = (isEn ? faq['q_en'] : faq['q_id'])!.toLowerCase();
      final a = (isEn ? faq['a_en'] : faq['a_id'])!.toLowerCase();
      return q.contains(query) || a.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appSettings = ref.watch(appSettingsProvider);
    final isDark = appSettings.darkModeEnabled;
    final theme = ProfileThemeColors(isDark);
    final loc = ProfileLocalizations(appSettings.selectedLanguage);
    final faqs = _filteredFaqs(loc.isEn);

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
          loc.helpSupport,
          style: TextStyle(color: theme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.contactUs, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: theme.textPrimary)),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _buildContactCard(
                    context,
                    icon: Icons.phone_in_talk,
                    title: 'Call Center',
                    subtitle: '1-500-989',
                    onTap: () => _showDialerMock(context, '1-500-989', theme, loc),
                    theme: theme,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildContactCard(
                    context,
                    icon: Icons.chat,
                    title: 'WhatsApp Chat',
                    subtitle: '+62 812-3456-7890',
                    onTap: () => _showWhatsAppChatMock(context, theme, loc),
                    theme: theme,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(loc.popularFaq, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: theme.textPrimary)),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: theme.surface,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (context) {
                        return SupportTicketSheet(theme: theme, loc: loc);
                      },
                    );
                  },
                  child: Text(
                    loc.isEn ? 'Submit Ticket' : 'Kirim Tiket',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: theme.red),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Custom Search Bar
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: theme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.border),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                style: TextStyle(color: theme.textPrimary, fontSize: 14),
                decoration: InputDecoration(
                  hintText: loc.searchFaqHint,
                  hintStyle: TextStyle(color: theme.textSecondary.withValues(alpha: 0.5), fontSize: 14),
                  prefixIcon: Icon(Icons.search, size: 18, color: theme.textSecondary),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (faqs.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Text(
                    loc.isEn ? 'No matching questions' : 'Pertanyaan tidak ditemukan',
                    style: TextStyle(color: theme.textSecondary),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: faqs.length,
                itemBuilder: (context, idx) {
                  final item = faqs[idx];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildFaqItem(
                      context,
                      loc.isEn ? item['q_en']! : item['q_id']!,
                      loc.isEn ? item['a_en']! : item['a_id']!,
                      theme,
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required ProfileThemeColors theme,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: theme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: theme.isDark ? 0.2 : 0.02),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: theme.red, size: 32),
            const SizedBox(height: 12),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: theme.textPrimary)),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(fontSize: 11, color: theme.textSecondary), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(BuildContext context, String question, String answer, ProfileThemeColors theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.border),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: theme.red,
          collapsedIconColor: theme.textSecondary,
          title: Text(
            question,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: theme.textPrimary),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                answer,
                style: TextStyle(fontSize: 12, color: theme.textSecondary, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialerMock(BuildContext context, String number, ProfileThemeColors theme, ProfileLocalizations loc) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 40,
                backgroundColor: theme.red,
                child: const Icon(Icons.support_agent, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 20),
              const Text(
                'Hondaku Care',
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                number,
                style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text(
                loc.isEn ? 'Dialing...' : 'Menghubungi...',
                style: const TextStyle(color: Colors.greenAccent, fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.call_end, color: Colors.white, size: 28),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showWhatsAppChatMock(BuildContext context, ProfileThemeColors theme, ProfileLocalizations loc) {
    final messageController = TextEditingController();
    final listScrollController = ScrollController();
    final List<Map<String, dynamic>> mockMessages = [
      {
        'sender': 'agent',
        'text': loc.isEn
            ? 'Hello! Welcome to Hondaku Care Medan. How can we help you today?'
            : 'Halo! Selamat datang di Customer Care Hondaku Medan. Ada yang bisa kami bantu hari ini?',
        'time': 'Just now',
      }
    ];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setChatState) {
            return Dialog(
              backgroundColor: theme.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: SizedBox(
                height: 450,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: const BoxDecoration(
                        color: Color(0xFF075E54),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.support_agent, color: Color(0xFF075E54)),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hondaku Care Support',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                Text(
                                  loc.isEn ? 'Online' : 'Aktif',
                                  style: const TextStyle(color: Colors.greenAccent, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white, size: 20),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: theme.isDark ? const Color(0xFF151515) : const Color(0xFFECE5DD),
                        padding: const EdgeInsets.all(12),
                        child: ListView.builder(
                          controller: listScrollController,
                          itemCount: mockMessages.length,
                          itemBuilder: (context, index) {
                            final msg = mockMessages[index];
                            final isAgent = msg['sender'] == 'agent';
                            return Align(
                              alignment: isAgent ? Alignment.centerLeft : Alignment.centerRight,
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isAgent
                                      ? (theme.isDark ? const Color(0xFF242424) : Colors.white)
                                      : const Color(0xFFDCF8C6),
                                  borderRadius: BorderRadius.circular(12).copyWith(
                                    topLeft: isAgent ? Radius.zero : const Radius.circular(12),
                                    topRight: isAgent ? const Radius.circular(12) : Radius.zero,
                                  ),
                                ),
                                child: Text(
                                  msg['text'],
                                  style: TextStyle(
                                    color: isAgent && theme.isDark ? Colors.white : Colors.black87,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.surface,
                        border: Border(top: BorderSide(color: theme.border)),
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: messageController,
                              style: TextStyle(color: theme.textPrimary, fontSize: 13),
                              decoration: InputDecoration(
                                hintText: loc.isEn ? 'Type a message...' : 'Ketik pesan...',
                                hintStyle: TextStyle(color: theme.textSecondary.withValues(alpha: 0.5), fontSize: 13),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send, color: Color(0xFF075E54)),
                            onPressed: () {
                              final text = messageController.text.trim();
                              if (text.isNotEmpty) {
                                setChatState(() {
                                  mockMessages.add({
                                    'sender': 'user',
                                    'text': text,
                                    'time': 'Just now',
                                  });
                                  messageController.clear();
                                });
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  if (listScrollController.hasClients) {
                                    listScrollController.animateTo(
                                      listScrollController.position.maxScrollExtent,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeOut,
                                    );
                                  }
                                });
                                Future.delayed(const Duration(milliseconds: 1200), () {
                                  if (context.mounted) {
                                    setChatState(() {
                                      mockMessages.add({
                                        'sender': 'agent',
                                        'text': loc.isEn
                                            ? 'Thank you for contacting us. An consultant will connect with you shortly.'
                                            : 'Terima kasih telah menghubungi. Consultant kami akan segera membalas chat Anda.',
                                        'time': 'Just now',
                                      });
                                    });
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      if (listScrollController.hasClients) {
                                        listScrollController.animateTo(
                                          listScrollController.position.maxScrollExtent,
                                          duration: const Duration(milliseconds: 300),
                                          curve: Curves.easeOut,
                                        );
                                      }
                                    });
                                  }
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// STATEFUL WIDGET: SUBMIT SUPPORT TICKET
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class SupportTicketSheet extends StatefulWidget {
  final ProfileThemeColors theme;
  final ProfileLocalizations loc;

  const SupportTicketSheet({
    super.key,
    required this.theme,
    required this.loc,
  });

  @override
  State<SupportTicketSheet> createState() => _SupportTicketSheetState();
}

class _SupportTicketSheetState extends State<SupportTicketSheet> {
  String _category = 'Booking';
  final TextEditingController _descController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  void _submitTicket() {
    final desc = _descController.text.trim();
    if (desc.isEmpty) {
      HondakuToast.showError(
        context,
        widget.loc.isEn ? 'Please describe your issue!' : 'Harap jelaskan kendala Anda!',
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: widget.theme.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  widget.loc.isEn ? 'Ticket Submitted' : 'Tiket Dikirim',
                  style: TextStyle(color: widget.theme.textPrimary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Text(
              widget.loc.isEn
                  ? 'Your support ticket has been submitted. Our team will contact you within 24 hours.'
                  : 'Tiket bantuan Anda telah terkirim. Tim Customer Care kami akan segera menghubungi Anda dalam 24 jam.',
              style: TextStyle(color: widget.theme.textPrimary),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK', style: TextStyle(color: widget.theme.red, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final loc = widget.loc;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                loc.ticketTitle,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textPrimary),
              ),
              if (!_isSubmitting)
                IconButton(
                  icon: Icon(Icons.close, color: theme.textSecondary),
                  onPressed: () => Navigator.pop(context),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (_isSubmitting) ...[
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: CircularProgressIndicator(),
              ),
            ),
          ] else ...[
            Text(
              loc.ticketCategory,
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
                  value: _category,
                  dropdownColor: theme.surface,
                  style: TextStyle(color: theme.textPrimary, fontSize: 14),
                  icon: Icon(Icons.keyboard_arrow_down, color: theme.textSecondary),
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(value: 'Booking', child: Text(loc.isEn ? 'Booking & Order' : 'Pemesanan & Booking')),
                    DropdownMenuItem(value: 'Pembayaran', child: Text(loc.isEn ? 'Payments' : 'Pembayaran')),
                    DropdownMenuItem(value: 'Pengiriman', child: Text(loc.isEn ? 'Unit Delivery' : 'Pengiriman Unit')),
                    DropdownMenuItem(value: 'Lainnya', child: Text(loc.isEn ? 'Others' : 'Pertanyaan Lainnya')),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _category = val);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              loc.isEn ? 'Description' : 'Deskripsi Masalah',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: theme.textSecondary),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: theme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.border),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _descController,
                maxLines: 4,
                style: TextStyle(fontSize: 14, color: theme.textPrimary),
                decoration: InputDecoration(
                  hintText: loc.ticketDescription,
                  hintStyle: TextStyle(color: theme.textSecondary.withValues(alpha: 0.5)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitTicket,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  elevation: 0,
                ),
                child: Text(
                  loc.submitTicket,
                  style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
