class ApiUrl {
  static const String baseUrl =
      'https://responsi1b.dalhaqq.xyz/api/assignments';

  static const String listTugas = baseUrl;
  static const String createTugas = baseUrl;

  static String updateTugas(int id) {
    return baseUrl + id.toString() + '/update';
  }

  static String showTugas(int id) {
    return baseUrl + id.toString();
  }

  static String deleteTugas(int id) {
    return baseUrl + id.toString() + '/delete';
  }
}
