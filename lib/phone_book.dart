import 'dart:math';

import 'package:flutter/material.dart';
import 'package:phone_book_app/models/contact.dart';
import 'package:phone_book_app/resources/strings.dart';
import 'package:phone_book_app/utils/contact_helper.dart' as contact_helper;

class PhoneBook extends StatefulWidget {
  const PhoneBook({
    Key? key,
    required this.onThemeModePressed,
  }) : super(key: key);

  final VoidCallback onThemeModePressed;

  @override
  _PhoneBookState createState() => _PhoneBookState();
}

class _PhoneBookState extends State<PhoneBook> {
  final contacts = List<Contact>.from(contact_helper.longContactList)
    ..sort((a, b) => a.name.compareTo(b.name));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
        actions: [
          IconButton(
            onPressed: widget.onThemeModePressed,
            icon: Icon(
              theme.brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
        ],
      ),
      body: contacts.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Contatos:'),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        final contact = contacts[index];
                        final materialColor = Colors.primaries[
                            Random().nextInt(Colors.primaries.length)];
                        final names = contact.name.split(' ');
                        final indentifier = names.first.characters.first +
                            names.last.characters.first;
                        final url = contact.picture;
                        return Card(
                          child: ListTile(
                            title: Text(contact.name),
                            subtitle: Text(contact.number),
                            leading: CircleAvatar(
                              foregroundImage:
                                  url != null ? NetworkImage(url) : null,
                              backgroundColor: materialColor.withOpacity(0.4),
                              foregroundColor: materialColor.shade800,
                              child: Text(indentifier),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            )
          : const Text('A sua lista de contato está vazia!'),
    );
  }
}
