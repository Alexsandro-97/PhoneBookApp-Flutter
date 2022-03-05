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
                  child: ListView.separated(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        /* color: index % 2 == 0
                            ? theme.backgroundColor
                            : theme.primaryColor, */
                        child: Text('${contact.name}\n${contact.number}'),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.black54,
                      height: 1.0,
                      thickness: 1.0,
                    ),
                  ),
                ),
              ],
            )
          : const Text('A sua lista de contato está vazia!'),
    );
  }
}
