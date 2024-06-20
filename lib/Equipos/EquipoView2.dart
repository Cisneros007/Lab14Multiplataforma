import 'package:flutter/material.dart';
import 'package:lab14/Equipos/Equipo.dart';
import 'package:lab14/Equipos/EquipoDB.dart';

class EquipoView2 extends StatefulWidget {
  @override
  _EquipoView2State createState() => _EquipoView2State();
}

class _EquipoView2State extends State<EquipoView2> {
  TextEditingController nameController = TextEditingController();
  TextEditingController foundingYearController = TextEditingController();
  TextEditingController lastChampionshipDateController = TextEditingController();

  EquipoDatabase equipoDatabase = EquipoDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Equipo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: foundingYearController,
              decoration: InputDecoration(labelText: 'Año de Fundación'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: lastChampionshipDateController,
              decoration: InputDecoration(labelText: 'Última Fecha de Campeonato (YYYY-MM-DD)'),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
               
                if (nameController.text.isNotEmpty &&
                    foundingYearController.text.isNotEmpty &&
                    lastChampionshipDateController.text.isNotEmpty) {
            
                  String fecha = lastChampionshipDateController.text;
                  List<String> partes = fecha.split('/');
                  if (partes.length == 3) {
                    String fechaFormateada = '${partes[2]}-${partes[1]}-${partes[0]}';

          
                    Equipo newEquipo = Equipo(
                      name: nameController.text,
                      foundingYear: int.tryParse(foundingYearController.text) ?? 0,
                      lastChampionshipDate: DateTime.tryParse(fechaFormateada) ?? DateTime.now(),
                    );

                    equipoDatabase.create(newEquipo);
                    Navigator.pop(context); 
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Formato de fecha incorrecto')),
                    );
                  }
                } else {
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor complete todos los campos')),
                  );
                }
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
