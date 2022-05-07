class Produk {
  int id;
  String kodeProduk;
  String namaProduk;
  int hargaProduk;

  Produk(
      { this.id=0,
       this.kodeProduk='',
       this.namaProduk='',
       this.hargaProduk=0});

  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
        id: obj['id'],
        kodeProduk: obj['kodeProduk'],
        namaProduk: obj['namaProduk'],
        hargaProduk: obj['harga']);
  }
}
