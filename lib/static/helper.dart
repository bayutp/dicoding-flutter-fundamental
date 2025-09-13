class Helper {
  static String imgUrl(String url, String size) =>
      'https://restaurant-api.dicoding.dev/images/$size/$url';

  static String errMsg = "Terjadi kesalahan.";
  static String errFmt = "Data dari server tidak valid.";
  static String errInet = "Tidak ada koneksi internet.";
  static String errServer = "Gagal terhubung ke server. Coba lagi nanti.";
}
