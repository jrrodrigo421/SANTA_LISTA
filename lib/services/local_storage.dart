import 'package:hive/hive.dart';
import '../models/contact.dart';

class LocalStorage {
  static const String _boxName = 'contacts';

  // Abre a caixa (Hive)
  Future<Box> _openBox() async {
    return await Hive.openBox(_boxName);
  }

  // Adiciona contato
  Future<void> addContact(Contact contact) async {
    final box = await _openBox();
    await box.put(contact.id, contact.toMap());
  }

  // Obtém todos os contatos
  Future<List<Contact>> getAllContacts() async {
    final box = await _openBox();
    return box.values
        .map((item) => Contact.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }

  // Remove contato
  Future<void> removeContact(String id) async {
    final box = await _openBox();
    await box.delete(id);
  }
}
