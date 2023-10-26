class Tugas {
  int? id;
  String? titleTugas;
  String? deskTugas;
  String? deadlineTugas;

  Tugas({this.id, this.titleTugas, this.deskTugas, this.deadlineTugas});

  factory Tugas.fromJson(Map<String, dynamic> obj) {
    return Tugas(
        id: obj['id'],
        titleTugas: obj['title'],
        deskTugas: obj['description'],
        deadlineTugas: obj['deadline']);
  }
}
