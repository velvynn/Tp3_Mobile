import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  // Controllers
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();

  // State Variables
  double? _hasilBMI;
  String _keterangan = "Silakan Masukkan Data Anda";
  String _jenisKelamin = "Laki-laki"; // Default

  // Logika Perhitungan BMI
  void _hitungBMI() {
    final double bb = double.tryParse(_bbController.text) ?? 0;
    // Konversi tinggi dari cm ke meter
    final double tbCm = double.tryParse(_tbController.text) ?? 0;

    setState(() {
      if (bb > 0 && tbCm > 0) {
        final double tbM = tbCm / 100;
        final double hasil = bb / (tbM * tbM);

        _hasilBMI = hasil;

        // Logika Kategori BMI (Standar WHO)
        if (hasil < 18.5) {
          _keterangan = "Berat Badan Kurus";
        } else if (hasil >= 18.5 && hasil < 25) {
          _keterangan = "Berat Badan Ideal";
        } else if (hasil >= 25 && hasil < 30) {
          _keterangan = "Kelebihan Berat Badan";
        } else {
          _keterangan = "Obesitas";
        }
      } else {
        _hasilBMI = null;
        _keterangan = "Data anda tidak valid!";
      }
    });
  }

  // Fungsi Reset
  void _resetForm() {
    setState(() {
      _bbController.clear();
      _tbController.clear();
      _hasilBMI = null;
      _keterangan = "Silakan Masukkan Data Anda";
      _jenisKelamin = "Laki-laki";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Background lebih lembut
      appBar: AppBar(
        title: const Text(
          'Kalkulator BMI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.accessibility_rounded),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Card Input Data ---
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Pilihan Jenis Kelamin
                      const Text(
                        "Jenis Kelamin",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ChoiceChip(
                              label: const Text("Laki-laki"),
                              selected: _jenisKelamin == "Laki-laki",
                              onSelected: (selected) {
                                setState(() {
                                  _jenisKelamin = "Laki-laki";
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ChoiceChip(
                              label: const Text("Perempuan"),
                              selected: _jenisKelamin == "Perempuan",
                              onSelected: (selected) {
                                setState(() {
                                  _jenisKelamin = "Perempuan";
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 30),

                      // Input Berat Badan
                      TextField(
                        controller: _bbController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          icon: const Icon(
                            Icons.line_weight_outlined,
                            color: Colors.teal,
                          ),
                          labelText: 'Berat Badan (kg)',
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Input Tinggi Badan
                      TextField(
                        controller: _tbController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          icon: const Icon(
                            Icons.height,
                            color: Colors.teal,
                          ),
                          labelText: 'Tinggi Badan (cm)',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // --- Tombol Aksi ---
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _hitungBMI,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calculate),
                          SizedBox(width: 8),
                          Text("Hitung BMI", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Tombol Reset
                  ElevatedButton(
                    onPressed: _resetForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Icon(Icons.refresh),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // --- Hasil Perhitungan ---
              Text(
                'Hasil:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 10),

              // Tampilan Hasil (Hanya muncul jika _hasilBMI tidak null)
              if (_hasilBMI != null)
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    border: Border.all(color: Colors.teal, width: 2),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _jenisKelamin.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _hasilBMI!.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _keterangan,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                )
              else
                // Tampilan jika belum menghitung
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      _keterangan,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}