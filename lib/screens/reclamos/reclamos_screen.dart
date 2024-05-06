import 'package:epreapp/models/models.dart';
import 'package:epreapp/themes/app_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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

  String _localityCon = '';
  String _localityConError = '';
  bool _localityConShowError = false;
  TextEditingController _localityConController = TextEditingController();

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

  //--------------------- Variables del 5° TabBar --------------------

  String _reclamo = '';
  String _reclamoError = '';
  bool _reclamoShowError = false;
  TextEditingController _reclamoController = TextEditingController();

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
    return Column(
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
                                      const Text(
                                        "Debe rellenar alguno de estos 2 campos de abajo",
                                        style: TextStyle(color: Colors.red),
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
                                    title:
                                        (const Text("Información de Contacto")),
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
                                      SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        "Debe marcar al menos una opción",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      _showCoincideDireccion(),
                                      _showCoincideDireccion(),
                                      _showCoincideDireccion(),
                                      _showCoincideDireccion(),
                                      _showCoincideDireccion(),
                                      _showCoincideDireccion(),
                                      _showCoincideDireccion(),
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
                                      const Text(
                                        "Describa detalladamente su Reclamo:",
                                      ),
                                      _showReclamo(),
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
                                    children: const [],
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
                  Icon(Icons.login),
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
              onPressed: () => _eviarReclamo(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.login),
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
//--------------------- _eviarReclamo -----------------------------
//-----------------------------------------------------------------

  void _eviarReclamo() async {}

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
        controller: _firstnameController,
        decoration: InputDecoration(
            fillColor: _document == "" ? Colors.yellow[200] : Colors.white,
            filled: true,
            hintText: 'Ingrese su DNI...',
            labelText: 'DNI',
            errorText: _documentShowError ? _documentError : null,
            suffixIcon: const Icon(Icons.assignment_ind),
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
        controller: _firstnameRepController,
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

    list.add(const DropdownMenuItem(
      value: 'Aguada Guzman',
      child: Text('Aguada Guzman'),
    ));

    list.add(const DropdownMenuItem(
      value: 'Arroyo de la Ventana',
      child: Text('Arroyo de la Ventana'),
    ));

    list.add(const DropdownMenuItem(
      value: 'Arroyo los Berros',
      child: Text('Arroyo los Berros'),
    ));

    list.add(const DropdownMenuItem(
      value: 'Balneario El Condor',
      child: Text('Balneario El Condor'),
    ));

    list.add(const DropdownMenuItem(
      value: 'Balneario Los Salados',
      child: Text('Balneario Los Salados'),
    ));

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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _localityConController,
        decoration: InputDecoration(
            fillColor: _localityCon == "" ? Colors.yellow[200] : Colors.white,
            filled: true,
            hintText: 'Seleccione una Localidad...',
            labelText: 'Localidad',
            errorText: _localityConShowError ? _localityConError : null,
            suffixIcon: const Icon(Icons.person_pin_circle),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _localityCon = value;
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
            fillColor: _cp == "" ? Colors.yellow[200] : Colors.white,
            filled: true,
            hintText: 'Código Postal...',
            labelText: 'Código Postal',
            errorText: _cpConShowError ? _cpConError : null,
            suffixIcon: const Icon(Icons.contact_mail),
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
            fillColor: _cp == "" ? Colors.yellow[200] : Colors.white,
            filled: true,
            hintText: 'Ingrese su Teléfono...',
            labelText: 'Teléfono',
            errorText: _telefonoConShowError ? _telefonoConError : null,
            suffixIcon: const Icon(Icons.phone),
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
        decoration: InputDecoration(
            fillColor: _cp == "" ? Colors.yellow[200] : Colors.white,
            filled: true,
            hintText: 'Ingrese su Correo Electrónico...',
            labelText: 'Correo Electrónico',
            errorText: _mailConShowError ? _mailConError : null,
            suffixIcon: const Icon(Icons.alternate_email),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _mailCon = value;
        },
      ),
    );
  }

//-----------------------------------------------------------------
//--------------------- _showReclamo ------------------------------
//-----------------------------------------------------------------

  Widget _showReclamo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _reclamoController,
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
  }

//-----------------------------------------------------------------
//--------------------- _getLocalities ----------------------------
//-----------------------------------------------------------------

  Future<void> _getLocalities() async {
    _localities = [
      Locality(locality: 'Elija una Localidad...'),
      Locality(locality: 'Aguada Guzman'),
      Locality(locality: 'Arroyo de la Ventana'),
      Locality(locality: 'Arroyo los Berros'),
      Locality(locality: 'Balneario El Condor'),
      Locality(locality: 'Balneario Los Salados'),
    ];

    setState(() {});
  }

  //-----------------------------------------------------------------
//--------------------- _loadData ---------------------------------
//-----------------------------------------------------------------

  void _validarTabBars() {
    _tabBar1Ok =
        _firstname.isNotEmpty && _lastname.isEmpty && _document.isNotEmpty;

    _tabBar2Ok = _address.isNotEmpty &&
        _locality != 'Elija una Localidad...' &&
        _cp.isNotEmpty &&
        (_nis.isNotEmpty || _nroCuenta.isNotEmpty);

    _tabBar3Ok = _addressCon.isNotEmpty &&
        _localityCon != 'Elija una Localidad...' &&
        _cpCon.isNotEmpty &&
        _telefonoCon.isNotEmpty &&
        _mailCon.isNotEmpty;

    _tabBar4Ok = true;

    _tabBar5Ok = _reclamo.isNotEmpty;

    _tabBar6Ok = true;

    setState(() {});
  }
}
