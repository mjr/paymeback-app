// ignore: import_of_legacy_library_into_null_safe
import 'package:contact_picker/contact_picker.dart';

Future<Contact?> openContactBook() async {
  try {
    return await ContactPicker().selectContact();
  } catch (e) {
    return null;
  }
}
