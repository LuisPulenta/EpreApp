import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:connectivity/connectivity.dart';
import 'package:email_validator/email_validator.dart';
import 'package:epreapp/components/loader_component.dart';
import 'package:epreapp/helpers/helpers.dart';
import 'package:epreapp/models/models.dart';
import 'package:epreapp/screens/screens.dart';
import 'package:epreapp/themes/app_theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ReclamosScreen extends StatefulWidget {
  const ReclamosScreen({Key? key}) : super(key: key);

  @override
  _ReclamosScreenState createState() => _ReclamosScreenState();
}

class _ReclamosScreenState extends State<ReclamosScreen>
    with SingleTickerProviderStateMixin {
//--------------------------------------------------------
//--------------------- Variables ------------------------
//--------------------------------------------------------

  //--------------------- Variables Generales --------------------
  TabController? _tabController;
  bool _tabBar1Ok = false;
  bool _tabBar2Ok = false;
  bool _tabBar3Ok = false;
  bool _tabBar4Ok = false;
  bool _tabBar5Ok = false;
  bool _tabBar6Ok = false;

  bool _showLoader = false;

  //--------------------- Variables del 1° TabBar --------------------
  String _firstname = '';
  String _firstnameError = '';
  bool _firstnameShowError = false;
  TextEditingController _firstnameController = TextEditingController();

  String _lastname = '';
  String _lastnameError = '';
  bool _lastnameShowError = false;
  TextEditingController _lastnameController = TextEditingController();

  String _document = '';
  String _documentError = '';
  bool _documentShowError = false;
  TextEditingController _documentController = TextEditingController();

  bool _nombrePropio = false;

  String _firstnameRep = '';
  String _firstnameRepError = '';
  bool _firstnameRepShowError = false;
  TextEditingController _firstnameRepController = TextEditingController();

  String _lastnameRep = '';
  String _lastnameRepError = '';
  bool _lastnameRepShowError = false;
  TextEditingController _lastnameRepController = TextEditingController();

  String _documentRep = '';
  String _documentRepError = '';
  bool _documentRepShowError = false;
  TextEditingController _documentRepController = TextEditingController();

  //--------------------- Variables del 2° TabBar --------------------

  String _address = '';
  String _addressError = '';
  bool _addressShowError = false;
  TextEditingController _addressController = TextEditingController();

  String _locality = 'Elija una Localidad...';
  String _localityError = '';
  bool _localityShowError = false;
  List<Locality> _localities = [];

  String _cp = '';
  String _cpError = '';
  bool _cpShowError = false;
  TextEditingController _cpController = TextEditingController();

  String _nis = '';
  String _nisError = '';
  bool _nisShowError = false;
  TextEditingController _nisController = TextEditingController();

  String _nroCuenta = '';
  String _nroCuentaError = '';
  bool _nroCuentaShowError = false;
  TextEditingController _nroCuentaController = TextEditingController();

  //--------------------- Variables del 3° TabBar --------------------

  bool _coincideDireccion = false;

  String _addressCon = '';
  String _addressConError = '';
  bool _addressConShowError = false;
  TextEditingController _addressConController = TextEditingController();

  String _localityCon = 'Elija una Localidad...';
  String _localityConError = '';
  bool _localityConShowError = false;

  String _cpCon = '';
  String _cpConError = '';
  bool _cpConShowError = false;
  TextEditingController _cpConController = TextEditingController();

  String _telefonoCon = '';
  String _telefonoConError = '';
  bool _telefonoConShowError = false;
  TextEditingController _telefonoConController = TextEditingController();

  String _mailCon = '';
  String _mailConError = '';
  bool _mailConShowError = false;
  TextEditingController _mailConController = TextEditingController();

  //--------------------- Variables del 4° TabBar --------------------

  bool _erroresEnFacturacion = false;
  bool _resarcimientoPorDanios = false;
  bool _suspensionDeSuministro = false;
  bool _malaAtencionComercial = false;
  bool _negativaDeConexion = false;
  bool _inconvenienteDeTension = false;
  bool _facturaFueraDeTerminoNoRecibidas = false;

  //--------------------- Variables del 5° TabBar --------------------

  String _reclamo = '';
  String _reclamoError = '';
  bool _reclamoShowError = false;
  TextEditingController _reclamoController = TextEditingController();

  //--------------------- Variables del 6° TabBar --------------------

  bool _photoChanged1 = false;
  late XFile _image1;
  bool _photoChanged2 = false;
  late XFile _image2;
  bool _photoChanged3 = false;
  late XFile _image3;

  String base64imagePdf1 = '';
  String base64imagePdf2 = '';
  String base64imagePdf3 = '';

  String ruta1 = '';
  String ruta2 = '';
  String ruta3 = '';

//--------------------------------------------------------
//--------------------- initState ------------------------
//--------------------------------------------------------

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _loadData();
  }

//--------------------------------------------------------
//--------------------- Pantalla -------------------------
//--------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    return Container(
      color: AppTheme.secondary,
      child: Column(
        children: [
          Expanded(
            child: Scaffold(
              backgroundColor: AppTheme.secondary,
              body: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white,
                                Colors.white,
                              ],
                            ),
                          ),
                          child: TabBarView(
                            controller: _tabController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            dragStartBehavior: DragStartBehavior.start,
                            children: <Widget>[
                              //-------------------------------------------------------------------------
                              //-------------------------- 1° TABBAR ------------------------------------
                              //-------------------------------------------------------------------------

                              SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    AppBar(
                                      title: (const Text("Datos Reclamante")),
                                      centerTitle: true,
                                      backgroundColor: AppTheme.primary,
                                    ),
                                    Column(
                                      children: [
                                        _showFirstName(),
                                        _showLastName(),
                                        _showDocument(),
                                        _showNombrePropio(),
                                        _nombrePropio
                                            ? _showFirstNameRep()
                                            : Container(),
                                        _nombrePropio
                                            ? _showLastNameRep()
                                            : Container(),
                                        _nombrePropio
                                            ? _showDocumentRep()
                                            : Container(),
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              //-------------------------------------------------------------------------
                              //-------------------------- 2° TABBAR ------------------------------------
                              //-------------------------------------------------------------------------

                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    AppBar(
                                      title: (const Text("Datos Suministro")),
                                      centerTitle: true,
                                      backgroundColor: AppTheme.primary,
                                    ),
                                    Column(
                                      children: [
                                        _showAddress(),
                                        _showLocalities(),
                                        _showCp(),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            "(*) Debe rellenar alguno de estos 2 campos de abajo",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        _showNis(),
                                        _showNroCuenta(),
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              //-------------------------------------------------------------------------
                              //-------------------------- 3° TABBAR ------------------------------------
                              //-------------------------------------------------------------------------

                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    AppBar(
                                      title: (const Text(
                                          "Información de Contacto")),
                                      centerTitle: true,
                                      backgroundColor: AppTheme.primary,
                                    ),
                                    Column(
                                      children: [
                                        _showCoincideDireccion(),
                                        _showAddressCon(),
                                        _showLocalityCon(),
                                        _showCpCon(),
                                        _showTelefonoCon(),
                                        _showMailCon(),
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              //-------------------------------------------------------------------------
                              //-------------------------- 4° TABBAR ------------------------------------
                              //-------------------------------------------------------------------------

                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    AppBar(
                                      title: (const Text("Tipo de Reclamo")),
                                      centerTitle: true,
                                      backgroundColor: AppTheme.primary,
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text(
                                          "(*) Debe marcar al menos una opción",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        _showErroresEnFacturacion(),
                                        _showResarcimientoPorDanios(),
                                        _showSuspensionDeSuministro(),
                                        _showMalaAtencionComercial(),
                                        _showNegativaDeConexion(),
                                        _showInconvenienteDeTension(),
                                        _showFacturaFueraDeTerminoNoRecibidas(),
                                        !_tabBar4Ok
                                            ? const Text(
                                                "No ha seleccionado ninguna opción",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              //-------------------------------------------------------------------------
                              //-------------------------- 5° TABBAR ------------------------------------
                              //-------------------------------------------------------------------------

                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    AppBar(
                                      title: (const Text("RECLAMO")),
                                      centerTitle: true,
                                      backgroundColor: AppTheme.primary,
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text(
                                          "Describa detalladamente su Reclamo:",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        _showReclamo(),
                                        !_tabBar5Ok
                                            ? const Text(
                                                "No ha escrito nada todavía",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              //-------------------------------------------------------------------------
                              //-------------------------- 6° TABBAR ------------------------------------
                              //-------------------------------------------------------------------------

                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    AppBar(
                                      title: (const Text("Subir Adjuntos")),
                                      centerTitle: true,
                                      backgroundColor: AppTheme.primary,
                                    ),
                                    Column(
                                      children: [
                                        _showFotos(ancho),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Center(
                    child: _showLoader
                        ? const LoaderComponent(text: 'Guardando...')
                        : Container(),
                  ),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                elevation: 0,
                color: AppTheme.primary,
                child: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.amber,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 5,
                    labelColor: Colors.amber,
                    unselectedLabelColor: Colors.grey,
                    labelPadding: const EdgeInsets.all(10),
                    tabs: <Widget>[
                      Tab(
                        child: Column(
                          children: [
                            _tabBar1Ok
                                ? const Icon(Icons.done_outline)
                                : const Icon(Icons.looks_one),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          children: [
                            _tabBar2Ok
                                ? const Icon(Icons.done_outline)
                                : const Icon(Icons.looks_two),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          children: [
                            _tabBar3Ok
                                ? const Icon(Icons.done_outline)
                                : const Icon(Icons.looks_3),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          children: [
                            _tabBar4Ok
                                ? const Icon(Icons.done_outline)
                                : const Icon(Icons.looks_4),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          children: [
                            _tabBar5Ok
                                ? const Icon(Icons.done_outline)
                                : const Icon(Icons.looks_5),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          children: [
                            _tabBar6Ok
                                ? const Icon(Icons.done_outline)
                                : const Icon(Icons.looks_6),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _showButtons(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

//-----------------------------------------------------------------
//--------------------- _showButtons -------------------------------
//-----------------------------------------------------------------

  Widget _showButtons() {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                _validarTabBars();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.done_outline),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Validar Form.'),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: (_tabBar1Ok &&
                      _tabBar2Ok &&
                      _tabBar3Ok &&
                      _tabBar4Ok &&
                      _tabBar5Ok &&
                      _tabBar6Ok)
                  ? () => _enviarReclamo()
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.send),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Enviar Reclamo'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//-----------------------------------------------------------------
//--------------------- _enviarReclamo ----------------------------
//-----------------------------------------------------------------

  void _enviarReclamo() async {
    setState(() {
      _showLoader = true;
    });

    String base64image1 = '';
    String base64image2 = '';
    String base64image3 = '';

    if (_photoChanged1) {
      List<int> imageBytes1 = await _image1.readAsBytes();
      base64image1 = base64Encode(imageBytes1);
    }

    if (_photoChanged2) {
      List<int> imageBytes2 = await _image2.readAsBytes();
      base64image2 = base64Encode(imageBytes2);
    }
    if (_photoChanged3) {
      List<int> imageBytes3 = await _image3.readAsBytes();
      base64image3 = base64Encode(imageBytes3);
    }

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _showLoader = false;
      });
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: 'Verifica que estés conectado a Internet',
          actions: <AlertDialogAction>[
            const AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    Map<String, dynamic> request = {
      'Nombre': _firstname,
      'Apellido': _lastname,
      'DNI': _document,
      'NombrePropio': _nombrePropio ? 1 : 0,
      'NombreRepresentante': _firstnameRep,
      'ApellidoRepresentante': _lastnameRep,
      'DNIRepresentante': _documentRep,
      'Direccion': _address,
      'Localidad': _locality,
      'CodPostal': _cp,
      'Nis': _nis,
      'NroCuenta': _nroCuenta,
      'CoincideDireccion': _coincideDireccion ? 1 : 0,
      'DireccionContacto': _addressCon,
      'LocalidadContacto': _localityCon,
      'CodPostalContacto': _cpCon,
      'Telefono': _telefonoCon,
      'Correo': _mailCon,
      'ErroresEnFacturacion': _erroresEnFacturacion ? 1 : 0,
      'ResarcimientoPorDanios': _resarcimientoPorDanios ? 1 : 0,
      'SuspensionDeSuministro': _suspensionDeSuministro ? 1 : 0,
      'MalaAtencionComercial': _malaAtencionComercial ? 1 : 0,
      'NegativaDeConexion': _negativaDeConexion ? 1 : 0,
      'InconvenienteDeTension': _inconvenienteDeTension ? 1 : 0,
      'FacturaFueraDeTerminoNoRecibidas':
          _facturaFueraDeTerminoNoRecibidas ? 1 : 0,
      'Reclamo': _reclamo,
      'ArrayFoto1': base64image1,
      'ArrayFoto2': base64image2,
      'ArrayFoto3': base64image3,
      'ArrayPdf1': base64imagePdf1,
      'ArrayPdf2': base64imagePdf2,
      'ArrayPdf3': base64imagePdf3,
    };

    Response response = await ApiHelper.postNoToken(
        '/api/AppReclamos/PostAppReclamos', request);
    if (!response.isSuccess) {
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: response.message,
          actions: <AlertDialogAction>[
            const AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    setState(() {
      _showLoader = false;
    });
    await showAlertDialog(
        context: context,
        title: 'Aviso',
        message: 'Reclamo enviado con éxito!',
        actions: <AlertDialogAction>[
          const AlertDialogAction(key: null, label: 'Aceptar'),
        ]);
    Navigator.pop(context, 'yes');
  }

//--------------------------------------------------------------
//-------------------------- _showFirstName --------------------
//--------------------------------------------------------------

  Widget _showFirstName() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _firstnameController,
        decoration: InputDecoration(
            fillColor: _firstname == "" ? Colors.yellow[200] : Colors.white,
            filled: true,
            hintText: 'Ingrese su Nombre/s...',
            labelText: 'Nombre',
            errorText: _firstnameShowError ? _firstnameError : null,
            suffixIcon: const Icon(Icons.person),
            icon: const Icon(Icons.emergency),
            iconColor: Colors.red,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _firstname = value;
        },
      ),
    );
  }

//--------------------------------------------------------------
//-------------------------- _showLastName ---------------------
//--------------------------------------------------------------

  Widget _showLastName() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _lastnameController,
        decoration: InputDecoration(
            fillColor: _firstname == "" ? Colors.yellow[200] : Colors.white,
            filled: true,
            hintText: 'Ingrese su Apellido...',
            labelText: 'Apellido',
            errorText: _lastnameShowError ? _lastnameError : null,
            suffixIcon: const Icon(Icons.person),
            icon: const Icon(Icons.emergency),
            iconColor: Colors.red,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _lastname = value;
        },
      ),
    );
  }

//--------------------------------------------------------------
//-------------------------- _showDocument ---------------------
//--------------------------------------------------------------

  Widget _showDocument() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _documentController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            fillColor: _document == "" ? Colors.yellow[200] : Colors.white,
            filled: true,
            hintText: 'Ingrese su DNI...',
            labelText: 'DNI',
            errorText: _documentShowError ? _documentError : null,
            suffixIcon: const Icon(Icons.assignment_ind),
            icon: const Icon(Icons.emergency),
            iconColor: Colors.red,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _document = value;
        },
      ),
    );
  }

//--------------------------------------------------------------
//-------------------------- _showNombrePropio -----------------
//--------------------------------------------------------------
  _showNombrePropio() {
    return CheckboxListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('De NO actuar en nombre propio'),
          Text('marque aquí: '),
        ],
      ),
      value: _nombrePropio,
      activeColor: AppTheme.primary,
      onChanged: (value) {
        setState(() {
          _nombrePropio = value!;
        });
      },
    );
  }

//--------------------------------------------------------------
//-------------------------- _showFirstNameRep -----------------
//--------------------------------------------------------------

  Widget _showFirstNameRep() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _firstnameRepController,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Ingrese Nombre del Representante...',
            labelText: 'Nombre del Representante',
            errorText: _firstnameRepShowError ? _firstnameRepError : null,
            suffixIcon: const Icon(Icons.person),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _firstnameRep = value;
        },
      ),
    );
  }

//--------------------------------------------------------------
//-------------------------- _showLastNameRep-------------------
//--------------------------------------------------------------

  Widget _showLastNameRep() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _lastnameRepController,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Ingrese Apellido del Representante...',
            labelText: 'Apellido del Representante',
            errorText: _lastnameRepShowError ? _lastnameRepError : null,
            suffixIcon: const Icon(Icons.person),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _lastnameRep = value;
        },
      ),
    );
  }

//--------------------------------------------------------------
//-------------------------- _showDocumentRep ------------------
//--------------------------------------------------------------

  Widget _showDocumentRep() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _documentRepController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Ingrese DNI del Representante...',
            labelText: 'DNI del Representante',
            errorText: _documentRepShowError ? _documentRepError : null,
            suffixIcon: const Icon(Icons.assignment_ind),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _documentRep = value;
        },
      ),
    );
  }

//--------------------------------------------------------------
//-------------------------- _showAddress ----------------------
//--------------------------------------------------------------

  Widget _showAddress() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _addressController,
        decoration: InputDecoration(
            fillColor: _address == "" ? Colors.yellow[200] : Colors.white,
            filled: true,
            hintText: 'Ingrese su Dirección...',
            labelText: 'Dirección',
            errorText: _addressShowError ? _addressError : null,
            suffixIcon: const Icon(Icons.home),
            icon: const Icon(Icons.emergency),
            iconColor: Colors.red,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _address = value;
        },
      ),
    );
  }

//-----------------------------------------------------------------
//--------------------- _showLocalities ---------------------------
//-----------------------------------------------------------------

  Widget _showLocalities() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: _localities.isEmpty
          ? const Text('Cargando localidades...')
          : DropdownButtonFormField(
              value: _locality,
              decoration: InputDecoration(
                fillColor: _locality == 'Elija una Localidad...'
                    ? Colors.yellow[200]
                    : Colors.white,
                filled: true,
                hintText: 'Elija una Localidad...',
                labelText: 'Localidad...',
                icon: const Icon(Icons.emergency),
                iconColor: Colors.red,
                errorText: _localityShowError ? _localityError : null,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              items: _getComboLocalities(),
              onChanged: (value) {
                _locality = value.toString();
              },
            ),
    );
  }

//-----------------------------------------------------------------
//--------------------- _getComboLocalities --------------------
//-----------------------------------------------------------------

  List<DropdownMenuItem<String>> _getComboLocalities() {
    List<DropdownMenuItem<String>> list = [];

    list.add(const DropdownMenuItem(
      value: 'Elija una Localidad...',
      child: Text('Elija una Localidad...'),
    ));

    for (var city in Constants.cities) {
      list.add(DropdownMenuItem(
        value: city,
        child: Text(city),
      ));
    }
    setState(() {});

    return list;
  }

//--------------------------------------------------------------
//-------------------------- _showCp ---------------------------
//--------------------------------------------------------------

  Widget _showCp() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _cpController,
        decoration: InputDecoration(
            fillColor: _cp == "" ? Colors.yellow[200] : Colors.white,
            filled: true,
            hintText: 'Código Postal...',
            labelText: 'Código Postal',
            errorText: _cpShowError ? _cpError : null,
            suffixIcon: const Icon(Icons.contact_mail),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _cp = value;
        },
      ),
    );
  }

//--------------------------------------------------------------
//-------------------------- _showNis --------------------------
//--------------------------------------------------------------

  Widget _showNis() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _nisController,
        decoration: InputDecoration(
            fillColor: _nis == "" ? Colors.yellow[200] : Colors.white,
            filled: true,
            hintText: 'N° de NIS (usuarios EdERSA)...',
            labelText: 'N° de NIS',
            errorText: _nisShowError ? _nisError : null,
            suffixIcon: const Icon(Icons.numbers),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _nis = value;
        },
      ),
    );
  }

//--------------------------------------------------------------
//-------------------------- _showNroCuenta --------------------
//--------------------------------------------------------------

  Widget _showNroCuenta() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _nroCuentaController,
        decoration: InputDecoration(
            fillColor: _nroCuenta == "" ? Colors.yellow[200] : Colors.white,
            filled: true,
            hintText: 'N° Cuenta (CEB / CEARC):...',
            labelText: 'N° de Cuenta',
            errorText: _nroCuentaShowError ? _nroCuentaError : null,
            suffixIcon: const Icon(Icons.numbers),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _nroCuenta = value;
        },
      ),
    );
  }

//--------------------------------------------------------------
//-------------------------- _showCoinncideDireccion -----------
//--------------------------------------------------------------
  _showCoincideDireccion() {
    return CheckboxListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Coincide con la Dirección de Suministro'),
        ],
      ),
      value: _coincideDireccion,
      activeColor: AppTheme.primary,
      onChanged: (value) {
        if (value == true) {
          _addressCon = _address;
          _addressConController.text = _addressCon;
          _localityCon = _locality;
          _cpCon = _cp;
          _cpConController.text = _cpCon;
        } else {
          _addressCon = "";
          _addressConController.text = _addressCon;
          _localityCon = "Elija una Localidad...";
          _cpCon = "";
          _cpConController.text = _cpCon;
        }

        setState(() {
          _coincideDireccion = value!;
        });
      },
    );
  }

//--------------------------------------------------------------
//-------------------------- _showAddressCon -------------------
//--------------------------------------------------------------

  Widget _showAddressCon() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _addressConController,
        decoration: InputDecoration(
            fillColor: _addressCon == "" ? Colors.yellow[200] : Colors.white,
            filled: true,
            hintText: 'Ingrese su Dirección...',
            labelText: 'Dirección',
            errorText: _addressConShowError ? _addressConError : null,
            suffixIcon: const Icon(Icons.home),
            icon: const Icon(Icons.emergency),
            iconColor: Colors.red,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _addressCon = value;
        },
      ),
    );
  }

//--------------------------------------------------------------
//-------------------------- _showLocalityCon ------------------
//--------------------------------------------------------------

  Widget _showLocalityCon() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: _localities.isEmpty
          ? const Text('Cargando localidades...')
          : DropdownButtonFormField(
              value: _localityCon,
              decoration: InputDecoration(
                fillColor: _localityCon == 'Elija una Localidad...'
                    ? Colors.yellow[200]
                    : Colors.white,
                filled: true,
                hintText: 'Elija una Localidad...',
                labelText: 'Localidad...',
                icon: const Icon(Icons.emergency),
                iconColor: Colors.red,
                errorText: _localityConShowError ? _localityConError : null,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              items: _getComboLocalities(),
              onChanged: (value) {
                _localityCon = value.toString();
              },
            ),
    );
  }

//--------------------------------------------------------------
//-------------------------- _showCpCon ------------------------
//--------------------------------------------------------------

  Widget _showCpCon() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _cpConController,
        decoration: InputDecoration(
            fillColor: _cpCon == "" ? Colors.yellow[200] : Colors.white,
            filled: true,
            hintText: 'Código Postal...',
            labelText: 'Código Postal',
            errorText: _cpConShowError ? _cpConError : null,
            suffixIcon: const Icon(Icons.contact_mail),
            icon: const Icon(Icons.emergency),
            iconColor: Colors.red,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _cpCon = value;
        },
      ),
    );
  }

//--------------------------------------------------------------
//-------------------------- _showTelefonoCon ------------------
//--------------------------------------------------------------

  Widget _showTelefonoCon() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _telefonoConController,
        decoration: InputDecoration(
            fillColor: _telefonoCon == "" ? Colors.yellow[200] : Colors.white,
            filled: true,
            hintText: 'Ingrese su Teléfono...',
            labelText: 'Teléfono',
            errorText: _telefonoConShowError ? _telefonoConError : null,
            suffixIcon: const Icon(Icons.phone),
            icon: const Icon(Icons.emergency),
            iconColor: Colors.red,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _telefonoCon = value;
        },
      ),
    );
  }

//--------------------------------------------------------------
//-------------------------- _showMailCon ----------------------
//--------------------------------------------------------------

  Widget _showMailCon() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _mailConController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            fillColor: _mailCon == "" ? Colors.yellow[200] : Colors.white,
            filled: true,
            hintText: 'Ingrese su Correo Electrónico...',
            labelText: 'Correo Electrónico',
            errorText: _mailConShowError ? _mailConError : null,
            suffixIcon: const Icon(Icons.alternate_email),
            icon: const Icon(Icons.emergency),
            iconColor: Colors.red,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _mailCon = value;
        },
      ),
    );
  }

//--------------------------------------------------------------
//------------------ _showErroresEnFacturacion -----------------
//--------------------------------------------------------------
  _showErroresEnFacturacion() {
    return CheckboxListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Errores en Facturación:'),
        ],
      ),
      value: _erroresEnFacturacion,
      activeColor: AppTheme.primary,
      onChanged: (value) {
        setState(() {
          _erroresEnFacturacion = value!;
        });
      },
    );
  }

//--------------------------------------------------------------
//------------------ _showResarcimientoPorDanios ---------------
//--------------------------------------------------------------
  _showResarcimientoPorDanios() {
    return CheckboxListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Resarcimiento por Daños:'),
        ],
      ),
      value: _resarcimientoPorDanios,
      activeColor: AppTheme.primary,
      onChanged: (value) {
        setState(() {
          _resarcimientoPorDanios = value!;
        });
      },
    );
  }

//--------------------------------------------------------------
//------------------ _showSuspensionDeSuministro ---------------
//--------------------------------------------------------------
  _showSuspensionDeSuministro() {
    return CheckboxListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Suspensión de Suministro:'),
        ],
      ),
      value: _suspensionDeSuministro,
      activeColor: AppTheme.primary,
      onChanged: (value) {
        setState(() {
          _suspensionDeSuministro = value!;
        });
      },
    );
  }

//--------------------------------------------------------------
//------------------ _showMalaAtencionComercial ----------------
//--------------------------------------------------------------
  _showMalaAtencionComercial() {
    return CheckboxListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Mala atención comercial:'),
        ],
      ),
      value: _malaAtencionComercial,
      activeColor: AppTheme.primary,
      onChanged: (value) {
        setState(() {
          _malaAtencionComercial = value!;
        });
      },
    );
  }

//--------------------------------------------------------------
//------------------ _showNegativaDeConexion -------------------
//--------------------------------------------------------------
  _showNegativaDeConexion() {
    return CheckboxListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Negativa de Conexión:'),
        ],
      ),
      value: _negativaDeConexion,
      activeColor: AppTheme.primary,
      onChanged: (value) {
        setState(() {
          _negativaDeConexion = value!;
        });
      },
    );
  }

//--------------------------------------------------------------
//------------------ _showInconvenienteDeTension ---------------
//--------------------------------------------------------------
  _showInconvenienteDeTension() {
    return CheckboxListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Inconveniente de Tensión:'),
        ],
      ),
      value: _inconvenienteDeTension,
      activeColor: AppTheme.primary,
      onChanged: (value) {
        setState(() {
          _inconvenienteDeTension = value!;
        });
      },
    );
  }

//--------------------------------------------------------------
//------------------ _showFacturaFueraDeTerminoNoRecibidas -----
//--------------------------------------------------------------
  _showFacturaFueraDeTerminoNoRecibidas() {
    return CheckboxListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Factura Fuera de Término / no recibidas:'),
        ],
      ),
      value: _facturaFueraDeTerminoNoRecibidas,
      activeColor: AppTheme.primary,
      onChanged: (value) {
        setState(() {
          _facturaFueraDeTerminoNoRecibidas = value!;
        });
      },
    );
  }

//-----------------------------------------------------------------
//--------------------- _showReclamo ------------------------------
//-----------------------------------------------------------------

  Widget _showReclamo() {
    double alto = MediaQuery.of(context).size.height;
    return Container(
      height: alto * .6,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _reclamoController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        expands: true,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Describa su Reclamo...',
            labelText: 'Reclamo:',
            errorText: _reclamoShowError ? _reclamoError : null,
            prefixIcon: const Icon(Icons.chat),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _reclamo = value;
        },
      ),
    );
  }

//-----------------------------------------------------------------
//--------------------- _loadData ---------------------------------
//-----------------------------------------------------------------

  void _loadData() async {
    await _getLocalities();
    await _showMessage();
  }

//-----------------------------------------------------------------
//--------------------- _getLocalities ----------------------------
//-----------------------------------------------------------------

  Future<void> _getLocalities() async {
    _localities.add(
      Locality(locality: 'Elija una Localidad...'),
    );

    for (var city in Constants.cities) {
      _localities.add(
        Locality(locality: city),
      );
    }
    setState(() {});
  }

//---------------------------------------------------------------
//----------------------- _showMessage -----------------------------
//---------------------------------------------------------------

  Future<void> _showMessage() async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(''),
            content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    "assets/logoverde.png",
                    height: 120,
                    width: 500,
                  ),
                  const Text('¡Bienvenido!'),
                  const Text('Por favor lea atentamente'),
                  const Text('los campos antes de completar'),
                  const Text('el Formulario.'),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Los campos con (*) son',
                      style: TextStyle(color: Colors.red)),
                  const Text('OBLIGATORIOS',
                      style: TextStyle(color: Colors.red)),
                  const SizedBox(
                    height: 10,
                  ),
                ]),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      color: Colors.purple,
                      child: const Text('Entendido',
                          style: TextStyle(color: Colors.white)))),
            ],
          );
        });
  }

//-----------------------------------------------------------------
//--------------------- _validarTabBars ---------------------------
//-----------------------------------------------------------------

  void _validarTabBars() {
    bool isValid = true;

    //------------------ 1° TabBar ---------------------------

    if (_firstname == "") {
      isValid = false;
      _firstnameShowError = true;
      _firstnameError = 'Ingrese un Nombre';
    } else {
      _firstnameShowError = false;
    }

    if (_firstname.length > 30) {
      isValid = false;
      _firstnameShowError = true;
      _firstnameError = 'Máximo 30 caracteres. Ha escrito ${_firstname.length}';
    } else {
      _firstnameShowError = false;
    }

    if (_lastname == "") {
      isValid = false;
      _lastnameShowError = true;
      _lastnameError = 'Ingrese un Apellido';
    } else {
      _lastnameShowError = false;
    }

    if (_lastname.length > 30) {
      isValid = false;
      _lastnameShowError = true;
      _lastnameError = 'Máximo 30 caracteres. Ha escrito ${_lastname.length}';
    } else {
      _lastnameShowError = false;
    }

    if (_document == "") {
      isValid = false;
      _documentShowError = true;
      _documentError = 'Ingrese un Documento';
    } else {
      _documentShowError = false;
    }

    if (_document.length > 10) {
      isValid = false;
      _documentShowError = true;
      _documentError = 'Máximo 10 caracteres. Ha escrito ${_document.length}';
    } else {
      _documentShowError = false;
    }

    if (_firstnameRep.length > 30) {
      isValid = false;
      _firstnameRepShowError = true;
      _firstnameRepError =
          'Máximo 30 caracteres. Ha escrito ${_firstnameRep.length}';
    } else {
      _firstnameRepShowError = false;
    }

    if (_lastnameRep.length > 30) {
      isValid = false;
      _lastnameRepShowError = true;
      _lastnameRepError =
          'Máximo 30 caracteres. Ha escrito ${_lastnameRep.length}';
    } else {
      _lastnameRepShowError = false;
    }

    if (_documentRep.length > 10) {
      isValid = false;
      _documentRepShowError = true;
      _documentRepError =
          'Máximo 10 caracteres. Ha escrito ${_documentRep.length}';
    } else {
      _documentRepShowError = false;
    }

    _tabBar1Ok =
        _firstname.isNotEmpty && _lastname.isNotEmpty && _document.isNotEmpty;

//------------------ 2° TabBar ---------------------------

    if (_address == "") {
      isValid = false;
      _addressShowError = true;
      _addressError = 'Ingrese una Dirección';
    } else {
      _addressShowError = false;
    }

    if (_address.length > 50) {
      isValid = false;
      _addressShowError = true;
      _addressError = 'Máximo 50 caracteres. Ha escrito ${_address.length}';
    } else {
      _addressShowError = false;
    }

    if (_locality == 'Elija una Localidad...') {
      isValid = false;
      _localityShowError = true;
      _localityError = 'Debe elegir una Localidad';
    } else {
      _localityShowError = false;
    }

    if (_cp == "") {
      isValid = false;
      _cpShowError = true;
      _cpError = 'Ingrese un Código Postal';
    } else {
      _cpShowError = false;
    }

    if (_cp.length > 6) {
      isValid = false;
      _cpShowError = true;
      _cpError = 'Máximo 6 caracteres. Ha escrito ${_cp.length}';
    } else {
      _cpShowError = false;
    }

    if ((_nis == "") && (_nroCuenta == "")) {
      isValid = false;
      _nisShowError = true;
      _nisError = 'Ingrese un N° de NIS o un N° de Cuenta';
      _nroCuentaShowError = true;
      _nroCuentaError = 'Ingrese un N° de NIS o un N° de Cuenta';
    } else {
      _nisShowError = false;
      _nroCuentaShowError = false;
    }

    if (_nis.length > 12) {
      isValid = false;
      _nisShowError = true;
      _nisError = 'Máximo 12 caracteres. Ha escrito ${_nis.length}';
    } else {
      _nisShowError = false;
    }

    if (_nroCuenta.length > 12) {
      isValid = false;
      _nroCuentaShowError = true;
      _nroCuentaError = 'Máximo 12 caracteres. Ha escrito ${_nroCuenta.length}';
    } else {
      _nroCuentaShowError = false;
    }

    _tabBar2Ok = _address.isNotEmpty &&
        _locality != 'Elija una Localidad...' &&
        _cp.isNotEmpty &&
        (_nis.isNotEmpty || _nroCuenta.isNotEmpty);

//------------------ 3° TabBar ---------------------------

    if (_addressCon == "") {
      isValid = false;
      _addressConShowError = true;
      _addressConError = 'Ingrese una Dirección';
    } else {
      _addressConShowError = false;
    }

    if (_addressCon.length > 50) {
      isValid = false;
      _addressConShowError = true;
      _addressConError =
          'Máximo 50 caracteres. Ha escrito ${_addressCon.length}';
    } else {
      _addressConShowError = false;
    }

    if (_localityCon == 'Elija una Localidad...') {
      isValid = false;
      _localityConShowError = true;
      _localityConError = 'Debe elegir una Localidad';
    } else {
      _localityConShowError = false;
    }

    if (_cpCon == "") {
      isValid = false;
      _cpConShowError = true;
      _cpConError = 'Ingrese un Código Postal';
    } else {
      _cpConShowError = false;
    }

    if (_cpCon.length > 6) {
      isValid = false;
      _cpConShowError = true;
      _cpConError = 'Máximo 6 caracteres. Ha escrito ${_cpCon.length}';
    } else {
      _cpConShowError = false;
    }

    if (_telefonoCon == "") {
      isValid = false;
      _telefonoConShowError = true;
      _telefonoConError = 'Ingrese un Teléfono';
    } else {
      _telefonoConShowError = false;
    }

    if (_telefonoCon.length > 20) {
      isValid = false;
      _telefonoConShowError = true;
      _telefonoConError =
          'Máximo 20 caracteres. Ha escrito ${_telefonoCon.length}';
    } else {
      _telefonoConShowError = false;
    }

    if (_mailCon == "") {
      isValid = false;
      _mailConShowError = true;
      _mailConError = 'Ingrese un Correo Electrónico';
    } else {
      _mailConShowError = false;
    }

    if (_mailCon != "") {
      if (_mailCon.length > 30) {
        isValid = false;
        _mailConShowError = true;
        _mailConError = 'Máximo 30 caracteres. Ha escrito ${_mailCon.length}';
      } else {
        if (!EmailValidator.validate(_mailCon)) {
          isValid = false;
          _mailConShowError = true;
          _mailConError = 'Formato de Correo Electrónico no válido';
        } else {
          _mailConShowError = false;
        }
      }
    }

    _tabBar3Ok = _addressCon.isNotEmpty &&
        _localityCon != 'Elija una Localidad...' &&
        _cpCon.isNotEmpty &&
        _telefonoCon.isNotEmpty &&
        _mailCon.isNotEmpty;

//------------------ 4° TabBar ---------------------------

    _tabBar4Ok = _erroresEnFacturacion ||
        _resarcimientoPorDanios ||
        _suspensionDeSuministro ||
        _malaAtencionComercial ||
        _negativaDeConexion ||
        _inconvenienteDeTension ||
        _facturaFueraDeTerminoNoRecibidas;

//------------------ 5° TabBar ---------------------------

    _tabBar5Ok = _reclamo.isNotEmpty;

    if (_reclamo.length > 300) {
      isValid = false;
      _reclamoShowError = true;
      _reclamoError = 'Máximo 300 caracteres. Ha escrito ${_reclamo.length}';
    } else {
      _reclamoShowError = false;
    }

//------------------ 6° TabBar ---------------------------
    _tabBar6Ok = true;

    setState(() {});
  }

//--------------------------------------------------------------
//-------------------------- _showFotos ------------------------
//--------------------------------------------------------------

  Widget _showFotos(double ancho) {
    double factor = 0.2;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Puede subir hasta 3 Fotos y 3 archivos PDF",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const Divider(
          height: 10,
          color: AppTheme.primary,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Foto1",
                  style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Stack(children: <Widget>[
                Container(
                  child: !_photoChanged1
                      ? Center(
                          child: Image(
                              image: const AssetImage('assets/noimage.png'),
                              width: ancho * factor,
                              height: ancho * factor,
                              fit: BoxFit.contain),
                        )
                      : Center(
                          child: Image.file(
                            File(_image1.path),
                            width: ancho * factor,
                            height: ancho * factor,
                            fit: BoxFit.contain,
                          ),
                        ),
                ),
                Positioned(
                    bottom: 0,
                    left: ancho * 0.8,
                    child: InkWell(
                      onTap: () => _takePicture(1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          color: AppTheme.primary,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.photo_camera,
                            size: 30,
                            color: Color(0xFFf6faf8),
                          ),
                        ),
                      ),
                    )),
                Positioned(
                    bottom: 0,
                    left: ancho * 0.1,
                    child: InkWell(
                      onTap: () => _selectPicture(1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          color: AppTheme.primary,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.image,
                            size: 30,
                            color: Color(0xFFf6faf8),
                          ),
                        ),
                      ),
                    )),
              ]),
            ),
          ],
        ),
        const Divider(
          height: 10,
          color: AppTheme.primary,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Foto 2",
                  style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Stack(children: <Widget>[
                Container(
                  child: !_photoChanged2
                      ? Center(
                          child: Image(
                              image: const AssetImage('assets/noimage.png'),
                              width: ancho * factor,
                              height: ancho * factor,
                              fit: BoxFit.contain),
                        )
                      : Center(
                          child: Image.file(
                            File(_image2.path),
                            width: ancho * 0.6,
                            height: ancho * 0.6,
                            fit: BoxFit.contain,
                          ),
                        ),
                ),
                Positioned(
                    bottom: 0,
                    left: ancho * 0.8,
                    child: InkWell(
                      onTap: () => _takePicture(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          color: AppTheme.primary,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.photo_camera,
                            size: 30,
                            color: Color(0xFFf6faf8),
                          ),
                        ),
                      ),
                    )),
                Positioned(
                    bottom: 0,
                    left: ancho * 0.1,
                    child: InkWell(
                      onTap: () => _selectPicture(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          color: AppTheme.primary,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.image,
                            size: 30,
                            color: Color(0xFFf6faf8),
                          ),
                        ),
                      ),
                    )),
              ]),
            ),
          ],
        ),
        const Divider(
          height: 10,
          color: AppTheme.primary,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Foto 3",
                  style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Stack(children: <Widget>[
                Container(
                  child: !_photoChanged3
                      ? Center(
                          child: Image(
                              image: const AssetImage('assets/noimage.png'),
                              width: ancho * factor,
                              height: ancho * factor,
                              fit: BoxFit.contain),
                        )
                      : Center(
                          child: Image.file(
                            File(_image3.path),
                            width: ancho * 0.6,
                            height: ancho * 0.6,
                            fit: BoxFit.contain,
                          ),
                        ),
                ),
                Positioned(
                    bottom: 0,
                    left: ancho * 0.8,
                    child: InkWell(
                      onTap: () => _takePicture(3),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          color: AppTheme.primary,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.photo_camera,
                            size: 30,
                            color: Color(0xFFf6faf8),
                          ),
                        ),
                      ),
                    )),
                Positioned(
                    bottom: 0,
                    left: ancho * 0.1,
                    child: InkWell(
                      onTap: () => _selectPicture(3),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          color: AppTheme.primary,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.image,
                            size: 30,
                            color: Color(0xFFf6faf8),
                          ),
                        ),
                      ),
                    )),
              ]),
            ),
          ],
        ),
        const Divider(
          height: 10,
          color: AppTheme.primary,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("PDF 1",
                  style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    child: base64imagePdf1 != ""
                        ? Center(
                            child: SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primary,
                                  minimumSize: const Size(150, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PdfScreen(
                                        ruta: ruta1,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Icon(Icons.picture_as_pdf),
                                    Text('Ver PDF1'),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 40,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: ancho * 0.1,
                    child: InkWell(
                      onTap: () => _loadPdf(1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          color: AppTheme.primary,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.picture_as_pdf,
                            size: 30,
                            color: Color(0xFFf6faf8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          height: 10,
          color: AppTheme.primary,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("PDF 2",
                  style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    child: base64imagePdf2 != ""
                        ? Center(
                            child: SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primary,
                                  minimumSize: const Size(150, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PdfScreen(
                                        ruta: ruta2,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Icon(Icons.picture_as_pdf),
                                    Text('Ver PDF2'),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 40,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: ancho * 0.1,
                    child: InkWell(
                      onTap: () => _loadPdf(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          color: AppTheme.primary,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.picture_as_pdf,
                            size: 30,
                            color: Color(0xFFf6faf8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          height: 10,
          color: AppTheme.primary,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("PDF 3",
                  style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    child: base64imagePdf3 != ""
                        ? Center(
                            child: SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primary,
                                  minimumSize: const Size(150, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PdfScreen(
                                        ruta: ruta3,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Icon(Icons.picture_as_pdf),
                                    Text('Ver PDF3'),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 40,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: ancho * 0.1,
                    child: InkWell(
                      onTap: () => _loadPdf(3),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          color: AppTheme.primary,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.picture_as_pdf,
                            size: 30,
                            color: Color(0xFFf6faf8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          height: 10,
          color: AppTheme.primary,
        ),
      ],
    );
  }

//--------------------------------------------------------------
//-------------------------- _selectPicture --------------------
//--------------------------------------------------------------

  void _selectPicture(int opcion) async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (opcion == 1) {
        _photoChanged1 = true;
        _image1 = image;
      }
      if (opcion == 2) {
        _photoChanged2 = true;
        _image2 = image;
      }
      if (opcion == 3) {
        _photoChanged3 = true;
        _image3 = image;
      }
      setState(() {});
    }
  }

//--------------------------------------------------------------
//-------------------------- _takePicture ----------------------
//--------------------------------------------------------------

  void _takePicture(int opcion) async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    var firstCamera = cameras.first;
    var response1 = await showAlertDialog(
        context: context,
        title: 'Seleccionar cámara',
        message: '¿Qué cámara desea utilizar?',
        actions: <AlertDialogAction>[
          const AlertDialogAction(key: 'no', label: 'Trasera'),
          const AlertDialogAction(key: 'yes', label: 'Delantera'),
          const AlertDialogAction(key: 'cancel', label: 'Cancelar'),
        ]);
    if (response1 == 'yes') {
      firstCamera = cameras.first;
    }
    if (response1 == 'no') {
      firstCamera = cameras.last;
    }

    if (response1 != 'cancel') {
      Response? response = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SacarFotoScreen(
                    camera: firstCamera,
                  )));
      if (response != null) {
        if (opcion == 1) {
          _photoChanged1 = true;
          _image1 = response.result;
        }
        if (opcion == 2) {
          _photoChanged2 = true;
          _image2 = response.result;
        }
        if (opcion == 3) {
          _photoChanged3 = true;
          _image3 = response.result;
        }
        setState(() {});
      }
    }
  }

  //-----------------------------------------------------------------
//-------------------------- _loadPdf -----------------------------
//-----------------------------------------------------------------

  Future<void> _loadPdf(int option) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      withData: true,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;
      List<int> imageBytesPdf = fileBytes!.buffer.asUint8List();
      String ruta = result.files.first.path!;

      if (option == 1) {
        base64imagePdf1 = base64Encode(imageBytesPdf);
        ruta1 = ruta;
      }

      if (option == 2) {
        base64imagePdf2 = base64Encode(imageBytesPdf);
        ruta2 = ruta;
      }

      if (option == 3) {
        base64imagePdf3 = base64Encode(imageBytesPdf);
        ruta3 = ruta;
      }
    }
    setState(() {});
  }
}
