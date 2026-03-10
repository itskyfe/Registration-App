import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/registration_provider.dart';

class RegistrantListPage extends StatefulWidget {
  const RegistrantListPage({super.key});

  @override
  State<RegistrantListPage> createState() => _RegistrantListPageState();
}

class _RegistrantListPageState extends State<RegistrantListPage> {

  String search = "";

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<RegistrationProvider>();

    final data = provider.registrants.where((r) {
      return r.name.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Peserta (${provider.count})"),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort_by_alpha),
            onPressed: () {
              provider.sortByName();
            },
          )
        ],
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search peserta...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v){
                setState(() {
                  search = v;
                });
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context,index){

                final registrant = data[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(registrant.name[0]),
                    ),
                    title: Text(registrant.name),
                    subtitle: Text(registrant.email),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete,color: Colors.red),
                      onPressed: (){

                        provider.removeRegistrant(registrant.id);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${registrant.name} dihapus"),
                          ),
                        );

                      },
                    ),
                    onTap: (){
                      Navigator.pushNamed(
                        context,
                        "/detail",
                        arguments: registrant.id,
                      );
                    },
                  ),
                );

              },
            ),
          )
        ],
      ),
    );
  }
}