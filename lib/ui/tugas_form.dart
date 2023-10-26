import 'package:flutter/material.dart';
import 'package:tokokita/bloc/tugas_bloc.dart';
import 'package:tokokita/ui/tugas_page.dart';
import 'package:tokokita/model/tugas.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class TugasForm extends StatefulWidget {
  Tugas? tugas;
  TugasForm({Key? key, this.tugas}) : super(key: key);
  @override
  _TugasFormState createState() => _TugasFormState();
}

class _TugasFormState extends State<TugasForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH TUGAS";
  String tombolSubmit = "SIMPAN";

  final _titleTugasTextboxController = TextEditingController();
  final _deskTugasTextboxController = TextEditingController();
  final _deadlineTugasTextboxController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.tugas != null) {
      setState(() {
        judul = "UBAH Tugas ADY";
        tombolSubmit = "UBAH";
        _titleTugasTextboxController.text = widget.tugas!.titleTugas!;
        _deskTugasTextboxController.text = widget.tugas!.deskTugas!;
        _deadlineTugasTextboxController.text =
            widget.tugas!.deadlineTugas.toString();
      });
    } else {
      judul = "TAMBAH Tugas ADY";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _titleTugasTextField(),
                _deskTugasTextField(),
                _deadlineTugasTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

//Membuat Textbox title Tugas
  Widget _titleTugasTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "title Tugas"),
      keyboardType: TextInputType.text,
      controller: _titleTugasTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "title Tugas harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox desk Tugas
  Widget _deskTugasTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "desk Tugas"),
      keyboardType: TextInputType.text,
      controller: _deskTugasTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "desk Tugas harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox deadline Tugas
  Widget _deadlineTugasTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "deadline"),
      keyboardType: TextInputType.number,
      controller: _deadlineTugasTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "deadline harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.tugas != null) {
                //kondisi update Tugas
                ubah();
              } else {
                //kondisi tambah Tugas
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
    Tugas createTugas = Tugas(id: null);
    createTugas.titleTugas = _titleTugasTextboxController.text;
    createTugas.deskTugas = _deskTugasTextboxController.text;

    createTugas.deadlineTugas = int.parse(_deadlineTugasTextboxController.text);
    TugasBloc.addTugas(tugas: createTugas).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const TugasPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
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
    Tugas updateTugas = Tugas(id: null);
    updateTugas.titleTugas = _titleTugasTextboxController.text;
    updateTugas.deskTugas = _deskTugasTextboxController.text;
    updateTugas.deadlineTugas = int.parse(_deadlineTugasTextboxController.text);
    TugasBloc.updateTugas(tugas: updateTugas).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const TugasPage()));
    }, onError: (error) {
      print('error = $error');
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan cobalagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
