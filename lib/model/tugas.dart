class Tugas {
  int? id;
  String? titleTugas;
  String? deskTugas;
  int? deadlineTugas;

  Tugas({this.id, this.titleTugas, this.deskTugas, this.deadlineTugas});

  factory Tugas.fromJson(Map<String, dynamic> obj) {
    return Tugas(
        id: int.parse(obj['id']),
        titleTugas: obj['title'],
        deskTugas: obj['description'],
        deadlineTugas: int.parse(obj['deadline']));
  }
}
