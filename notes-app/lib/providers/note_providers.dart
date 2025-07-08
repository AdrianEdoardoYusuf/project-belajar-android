import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/databases/db_service.dart';
import 'package:notes_app_sqflite/models/notes_models.dart';
import 'package:notes_app_sqflite/page/detail_note/detail_note_page.dart';
import 'package:notes_app_sqflite/utils/navigator_custom.dart';
import 'package:notes_app_sqflite/utils/state_data.dart';
import 'package:notes_app_sqflite/widgets/snackbar_custom.dart';

class NotesProviders extends ChangeNotifier {
  NotesProviders() {
    getDataNotes();
  }
  final DataBaseService _database = DataBaseService();

  StateData? _state;
  StateData get state => _state ?? StateData.loading;
  List<NoteModels> _dataNote = [];
  List<NoteModels> get dataNote => _dataNote;

  StateData? _stateDetail;
  StateData get stateDetail => _stateDetail ?? StateData.loading;
  NoteModels _detailNOte = NoteModels.fromJson({});
  NoteModels get detailNOte => _detailNOte;

  Future getDataNotes() async {
    _state = StateData.loading;
    try {
      final List<NoteModels> response = await _database.get();
      for (var item in response) {
        _dataNote.add(item);
      }

      _state = StateData.hasData;
      _dataNote = response;
    } catch (e) {
      _state = StateData.error;
      _dataNote = [];
    }
    notifyListeners();
  }

  Future createNewNote(
      {required String title, required String description}) async {
    try {
      final int response = await _database.post(
        NoteModels(
          title: title,
          id: '',
          description: description,
        ),
      );

      if (response >= 0) {
        SnacbarCustom.snackbarSucces(message: 'Catatan berhasil dibuat');

        getDataNotes();
        Navigation.pop();
        Navigation.pushPage(
            route: DetailNotePage.routeNamed, arguments: "$response");
      } else {
        SnacbarCustom.snackbarError(message: 'Gagal membuat catatan');
        print('gagal buat');
      }
    } catch (e) {
      SnacbarCustom.snackbarError(
          message: 'Terjadi kesalahan, Coba lagi nanti!');
      print('gagal buat note');
    }
  }

  Future detailNote({required String id}) async {
    _stateDetail = StateData.loading;
    try {
      final NoteModels response = await _database.getByID(id: int.parse(id));
      if (response.id != 'null') {
        _stateDetail = StateData.hasData;
        _detailNOte = response;
      } else {
        _stateDetail = StateData.error;
        _detailNOte = NoteModels.fromJson({});
      }
    } catch (e) {
      _stateDetail = StateData.error;
      _detailNOte = NoteModels.fromJson({});
    }
    notifyListeners();
  }

  Future removeNote({required String id}) async {
    try {
      final bool response = await _database.delete(id: int.parse(id));
      getDataNotes();
      SnacbarCustom.snackbarSucces(message: "Catatan berhasil dihapus*");
    } catch (e) {
      SnacbarCustom.snackbarError(message: "Gagal hapus catatan*");
    }
    notifyListeners();
  }

  Future updateNote({
    required String id,
    required String title,
    required String description,
  }) async {
    try {
      final NoteModels data =
          NoteModels(title: title, id: id, description: description);
      final bool response = await _database.put(data);
      if (response == true) {
        getDataNotes();
        detailNote(id: id);
        SnacbarCustom.snackbarSucces(message: "Berhasil perbarui note*");
      } else {
        SnacbarCustom.snackbarError(message: "Gagal perbarui note*");
      }
    } catch (e) {
      print('catch');
      SnacbarCustom.snackbarError(message: "Gagal perbarui note*");
    }
  }
}
