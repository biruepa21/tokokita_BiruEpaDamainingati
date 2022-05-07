import 'package:flutter/material.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class ProdukForm extends StatefulWidget {
  Produk produk;
  ProdukForm({required this.produk});
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PRODUK";
  String tombolSubmit = "SIMPAN";

  final _kodeProdukTextBoxController = TextEditingController();
  final _namaProdukTextBoxController = TextEditingController();
  final _hargaProdukTextBoxController = TextEditingController();

  void initState() {
    //TODO : IMPLEMENT initState
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _kodeProdukTextBoxController.text = widget.produk.kodeProduk;
        _namaProdukTextBoxController.text = widget.produk.namaProduk;
        _hargaProdukTextBoxController.text =
            widget.produk.hargaProduk.toString();
      });
    } else {
      judul = "TAMBAH PRODUK";
      tombolSubmit = "SIMPAN";
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _kodeProdukTextField(),
                  _namaProdukTextField(),
                  _hargaProdukTextField(),
                  _buttonSubmit()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox Kode Produk
  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Kode Produk"),
      keyboardType: TextInputType.text,
      controller: _kodeProdukTextBoxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Produk Harus Diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Nama Produk
  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Nama Produk"),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextBoxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Produk Harus Diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Harga Produk
  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Harga"),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextBoxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga Harus Diisi";
        }
        return null;
      },
    );
  }

  //Membuat Tombol Simpan/ Ubah
  Widget _buttonSubmit() {
    return OutlineButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.produk != null) {
                // Kondisi Update
                ubah();
              } else {
                // Kondisi Tambah Produk
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Produk createProduk = Produk();
    createProduk.kodeProduk = _kodeProdukTextBoxController.text;
    createProduk.namaProduk = _namaProdukTextBoxController.text;
    createProduk.hargaProduk = int.parse(_hargaProdukTextBoxController.text);
    ProdukBloc.addProduk(produk: createProduk).then((value) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => ProdukPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
                okClick: () {},
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Produk updateProduk = Produk();
    updateProduk.id = widget.produk.id;
    updateProduk.kodeProduk = _kodeProdukTextBoxController.text;
    updateProduk.namaProduk = _namaProdukTextBoxController.text;
    updateProduk.hargaProduk = int.parse(_hargaProdukTextBoxController.text);
    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => ProdukPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
                okClick: () {},
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
