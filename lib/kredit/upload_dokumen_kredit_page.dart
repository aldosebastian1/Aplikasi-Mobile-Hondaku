import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../home/aktivitas_store.dart';
import 'konfirmasi_pengajuan_page.dart';

enum DocStatus { belum, terunggah }

class DokumenItem {
  final String id;
  final String judul;
  final String deskripsi;
  DocStatus status;
  File? file;

  DokumenItem({
    required this.id,
    required this.judul,
    required this.deskripsi,
    this.status = DocStatus.belum,
    this.file,
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
  final _picker = ImagePicker();

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

  Future<void> _pickImage(DokumenItem item) async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) {
      setState(() {
        item.file = File(picked.path);
        item.status = DocStatus.terunggah;
      });
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
    // Step 1: Simulasi Kredit (done), Step 2: Upload Dokumen (current), Step 3: Konfirmasi
    const totalStep = 3;
    const currentStep = 2;
    return Row(
      children: List.generate(totalStep, (i) {
        final stepNo = i + 1;
        final isDone = stepNo < currentStep;
        final isCurrent = stepNo == currentStep;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < totalStep - 1 ? 6 : 0),
            height: 4,
            decoration: BoxDecoration(
              color: (isDone || isCurrent) ? _red : Colors.grey.shade300,
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
      onTap: () => _pickImage(item),
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
                onTap: () => _pickImage(item),
                child: const Text(
                  'Ganti foto',
                  style: TextStyle(
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
        onPressed: _semuaTerunggah ? _kirimPengajuan : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _red,
          disabledBackgroundColor: Colors.grey.shade300,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Kirim Pengajuan',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
