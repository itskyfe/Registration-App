import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/registrant_model.dart';
import '../providers/registration_provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();

  String gender = "Laki-laki";
  String? prodi;

  final List<String> prodiList = [
    "Teknik Informatika",
    "Sistem Informasi",
    "Teknik Komputer",
    "Data Science",
    "Desain Komunikasi Visual",
  ];

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<RegistrationProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Registrasi Event"),
        actions: [

          /// DARK MODE
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: (){
              provider.toggleTheme();
            },
          ),

          /// LIST PESERTA
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.people),
                onPressed: (){
                  Navigator.pushNamed(context, "/list");
                },
              ),
              if(provider.count > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.red,
                    child: Text(
                      provider.count.toString(),
                      style: const TextStyle(fontSize: 11,color: Colors.white),
                    ),
                  ),
                )
            ],
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key:_formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              const Text(
                "📝 Form Registrasi",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              /// NAMA
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  labelText: "Nama Lengkap",
                  prefixIcon: const Icon(Icons.person,color: Colors.indigo),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator:(v){
                  if(v == null || v.isEmpty){
                    return "Nama wajib diisi";
                  }
                  if(v.length < 3){
                    return "Minimal 3 karakter";
                  }
                  return null;
                },
              ),

              const SizedBox(height:15),

              /// EMAIL
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email,color: Colors.indigo),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator:(v){
                  if(v == null || v.isEmpty){
                    return "Email wajib diisi";
                  }
                  if(!v.contains("@")){
                    return "Email tidak valid";
                  }
                  return null;
                },
              ),

              const SizedBox(height:15),

              /// GENDER
              const Text(
                "Jenis Kelamin",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              Row(
                children: [

                  Expanded(
                    child: RadioListTile<String>(
                      value: "Laki-laki",
                      groupValue: gender,
                      title: const Text("Laki-laki"),
                      activeColor: Colors.indigo,
                      onChanged:(v){
                        setState(() {
                          gender = v!;
                        });
                      },
                    ),
                  ),

                  Expanded(
                    child: RadioListTile<String>(
                      value: "Perempuan",
                      groupValue: gender,
                      title: const Text("Perempuan"),
                      activeColor: Colors.indigo,
                      onChanged:(v){
                        setState(() {
                          gender = v!;
                        });
                      },
                    ),
                  )

                ],
              ),

              const SizedBox(height:10),

              /// PROGRAM STUDI
              DropdownButtonFormField<String>(
                value: prodi,
                decoration: InputDecoration(
                  labelText: "Program Studi",
                  prefixIcon: const Icon(Icons.school,color: Colors.indigo),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                hint: const Text("Pilih Program Studi"),
                items: prodiList.map((e){
                  return DropdownMenuItem<String>(
                    value:e,
                    child:Text(e),
                  );
                }).toList(),
                onChanged:(v){
                  setState(() {
                    prodi = v;
                  });
                },
                validator:(v){
                  if(v == null){
                    return "Pilih program studi";
                  }
                  return null;
                },
              ),

              const SizedBox(height:20),

              /// BUTTON DAFTAR
              ElevatedButton.icon(
                icon: const Icon(Icons.app_registration),
                label: const Text("DAFTAR SEKARANG"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical:16),
                ),
                onPressed:(){

                  if(!_formKey.currentState!.validate()) return;

                  final registrant = Registrant(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _name.text.trim(),
                    email: _email.text.trim(),
                    gender: gender,
                    programStudi: prodi!,
                    dateOfBirth: DateTime(2000),
                  );

                  provider.addRegistrant(registrant);

                  _name.clear();
                  _email.clear();

                  setState(() {
                    gender = "Laki-laki";
                    prodi = null;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("${registrant.name} berhasil didaftarkan"),
                    ),
                  );

                },
              ),

              const SizedBox(height:10),

              /// RESET
              OutlinedButton(
                onPressed:(){
                  _name.clear();
                  _email.clear();
                  setState(() {
                    gender = "Laki-laki";
                    prodi = null;
                  });
                },
                child: const Text("Reset Form"),
              )

            ],
          ),
        ),
      ),
    );
  }
}