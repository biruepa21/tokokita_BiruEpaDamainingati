import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';

class ProdukDetail extends StatefulWidget {
  Produk produk;
  ProdukDetail({required this.produk});
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Kode : ${widget.produk.kodeProduk}",
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.produk.namaProduk}",
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              "Harga : Rp. ${widget.produk.hargaProduk.toString()}",
              style: TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Tombol Edit
        RaisedButton(
            child: Text("EDIT"),
            color: Colors.green,
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ProdukForm(
                            produk: widget.produk,
                          )));
            }),
        //Tombol Hapus
        RaisedButton(
            child: Text("DELETE"),
            color: Colors.red,
            onPressed: () => confirmHapus()),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = new AlertDialog(
      content: Text("Yakin ingin menghapus data ini ?"),
      actions: [
        // Tombol Hapus
        OutlineButton(
          child: const Text("Ya"),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProdukForm(
                          produk: widget.produk,
                        )));
          },
        ),
        // Tombol Batal
        OutlineButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
