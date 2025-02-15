import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../services/local_storage.dart';
import 'add_contact_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalStorage _localStorage = LocalStorage();
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final contacts = await _localStorage.getAllContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  Future<void> _deleteContact(String id) async {
    await _localStorage.removeContact(id);
    _loadContacts();
  }

  void _navigateToAddContact() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddContactScreen()),
    );
    _loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8C2), // Amarelo suave
      appBar: AppBar(
        title: const Text(
          '📖 Lista Telefônica',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFD700), // Amarelo ouro
        elevation: 4,
      ),
      body: _contacts.isEmpty
          ? const Center(
              child: Text(
                'Nenhum contato cadastrado.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side:
                          const BorderSide(color: Color(0xFF0047AB), width: 2),
                    ),
                    child: ListTile(
                      leading:
                          const Icon(Icons.person, color: Color(0xFF0047AB)),
                      title: Text(
                        contact.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        contact.phoneNumber,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteContact(contact.id),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0047AB),
        onPressed: _navigateToAddContact,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
