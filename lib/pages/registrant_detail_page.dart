import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/registration_provider.dart';

class RegistrantDetailPage extends StatelessWidget {
  const RegistrantDetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    final id = ModalRoute.of(context)!.settings.arguments as String;

    final registrant =
        context.read<RegistrationProvider>().getById(id);

    if (registrant == null) {
      return const Scaffold(
        body: Center(child: Text("Data tidak ditemukan")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(registrant.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            CircleAvatar(
              radius: 40,
              child: Text(
                registrant.name[0],
                style: const TextStyle(fontSize: 30),
              ),
            ),

            const SizedBox(height:20),

            ListTile(
              leading: const Icon(Icons.email),
              title: Text(registrant.email),
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: Text(registrant.gender),
            ),

            ListTile(
              leading: const Icon(Icons.school),
              title: Text(registrant.programStudi),
            ),

            ListTile(
              leading: const Icon(Icons.cake),
              title: Text(
                  "${registrant.formattedDateOfBirth} (${registrant.age} tahun)"
              ),
            ),
          ],
        ),
      ),
    );
  }
}