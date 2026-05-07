import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../home/aktivitas_store.dart';
import 'konfirmasi_pengajuan_page.dart';

enum DocStatus { belum, terunggah }

class DokumenItem {
  final String id;
  final String judul;
  final String deskripsi;
  DocStatus status;
  File? file;
  String? fileName;
  bool isPdf;

  DokumenItem({
    required this.id,
    required this.judul,
    required this.deskripsi,
    this.status = DocStatus.belum,
    this.file,
    this.fileName,
    this.isPdf = false,
  });
}

class UploadDokumenKreditPage extends StatefulWidget {
  const UploadDokumenKreditPage({
    super.key,
    required this.namaMotor,
    required this.selectedLeasing,
    required this.angsuran,
    required this.tenor,
    required this.dpNominal,
    required this.hargaOTR,
  });

  final String namaMotor;
  final String selectedLeasing;
  final double angsuran;
  final int tenor;
  final double dpNominal;
  final double hargaOTR;

  @override
  State<UploadDokumenKreditPage> createState() =>
      _UploadDokumenKreditPageState();
}

class _UploadDokumenKreditPageState extends State<UploadDokumenKreditPage> {
  static const _red = Color(0xFFC40000);
  static const int _maxFileSize = 5 * 1024 * 1024; // 5MB

  final List<DokumenItem> _dokumen = [
    DokumenItem(
      id: 'ktp',
      judul: 'Foto KTP',
      deskripsi: 'Pastikan seluruh bagian KTP terbaca jelas dan tidak buram.',
    ),
    DokumenItem(
      id: 'selfie',
      judul: 'Foto Selfie + KTP',
      deskripsi: 'Pegang KTP di bawah dagu, wajah terlihat jelas.',
    ),
    DokumenItem(
      id: 'kk',
      judul: 'Foto KK',
      deskripsi: 'Unggah Kartu Keluarga terbaru yang masih berlaku.',
    ),
  ];

  bool get _semuaTerunggah =>
      _dokumen.every((d) => d.status == DocStatus.terunggah);

  Future<void> _pickDocument(DokumenItem item) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final size = await file.length();

        if (size > _maxFileSize) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ukuran file terlalu besar. Maksimal 5MB.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        setState(() {
          item.file = file;
          item.fileName = result.files.single.name;
          item.isPdf = result.files.single.extension?.toLowerCase() == 'pdf';
          item.status = DocStatus.terunggah;
        });
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  void _kirimPengajuan() {
    final now = DateTime.now();
    final referenceId =
        'AHM-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-${now.millisecondsSinceEpoch.toString().substring(7)}';

    AktivitasStore.upsertKreditSubmitted(
      id: referenceId,
      namaMotor: widget.namaMotor,
      tipeUnit: 'Kredit ${widget.tenor} Bulan - ${widget.selectedLeasing}',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => KonfirmasiPengajuanPage(
          referenceId: referenceId,
          namaMotor: widget.namaMotor,
          leasing: widget.selectedLeasing,
          angsuranPerBulan: widget.angsuran,
          tenor: widget.tenor,
          dpNominal: widget.dpNominal,
          hargaOTR: widget.hargaOTR,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Honda BeAT',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildStepper(),
            const SizedBox(height: 20),
            ..._dokumen.map(_buildDokumenCard),
            const SizedBox(height: 12),
            _buildInfoBox(),
            const SizedBox(height: 24),
            _buildKirimButton(),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Data Anda dilindungi oleh enkripsi keamanan standar perbankan.',
                style: TextStyle(fontSize: 11, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kredit Document Upload',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Silakan unggah dokumen legalitas untuk melanjutkan proses pengajuan kredit motor Honda BeAT Anda.',
          style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildStepper() {
    // Menghitung berapa banyak dokumen yang sudah diunggah
    final uploadedCount = _dokumen.where((d) => d.status == DocStatus.terunggah).length;
    const totalDocs = 3;

    return Row(
      children: List.generate(totalDocs, (i) {
        final isCompleted = i < uploadedCount;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < totalDocs - 1 ? 6 : 0),
            height: 4,
            decoration: BoxDecoration(
              color: isCompleted ? _red : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDokumenCard(DokumenItem item) {
    final isTerunggah = item.status == DocStatus.terunggah;

    return GestureDetector(
      onTap: () => _pickDocument(item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isTerunggah ? Colors.green.shade200 : Colors.transparent,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF0F0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isTerunggah ? Icons.insert_drive_file : Icons.camera_alt,
                    color: _red,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.judul,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.deskripsi,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                if (isTerunggah)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green.shade600,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'TERUNGGAH',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
            if (isTerunggah && item.file != null) ...[
              const SizedBox(height: 12),
              if (item.isPdf)
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.picture_as_pdf, color: _red, size: 32),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item.fileName ?? 'Dokumen PDF',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                )
              else
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    item.file!,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () => _pickDocument(item),
                child: Text(
                  item.isPdf ? 'Ganti dokumen' : 'Ganti foto',
                  style: const TextStyle(
                    fontSize: 12,
                    color: _red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, size: 16, color: Colors.grey),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Dokumen Anda akan diverifikasi oleh tim analis kredit kami dalam waktu 1x24 jam kerja.',
              style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKirimButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _kirimPengajuan(),
        style: ElevatedButton.styleFrom(
          backgroundColor: _red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Kirim Pengajuan',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
