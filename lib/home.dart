import 'package:flutter/material.dart';
import 'dart:math';
import 'figuras.dart';
import 'modelos.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int modo = -1;
  List<ModeloNodo> nodos = [];
  List<ModeloLinea> lineas = [];
  ModeloNodo? nodoSeleccionado1;
  ModeloNodo? nodoSeleccionado2;
  int contadorClicks = 0;

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: Text('Grafos'), actions: [
        IconButton(
          icon: Icon(Icons.help),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('HELP'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        label: Text(
                            'Agregar nodo, permite agregar nodos en la parte de la pantalla en la que se presiona'),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black)),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.edit),
                        label: Text(
                            'Mover nodo, permite cambiar la posicion de los nodos arrastrandolos'),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black)),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.delete),
                        label: Text(
                            'Eliminar nodo, permite eliminar el nodo que se presiona'),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black)),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.edit_attributes),
                        label: Text(
                            'Insertar pesos, permite cambiar insertar o cambiar el valor de los pesos'),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black)),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.calculate),
                        label: Text(
                            'Calcular ruta entre nodos, permite calcular la ruta de los nodos'),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black)),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.add_circle),
                        label: Text(
                            'Conectar nodos, permite hacer la coneccion entre nodos, presionando sobre el origen y destino'),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black)),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Cerrar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ]),
      body: Stack(
        children: [
          CustomPaint(
            painter: Nodos(nodos),
            child: Container(),
          ),
          CustomPaint(
            painter: Lineas(lineas),
            child: Container(),
          ),
          GestureDetector(
            onPanDown: (ubi) {
              setState(() {
                if (modo == 1) {
                  // generar un color random
                  Random random = Random();
                  nodos.add(ModeloNodo(
                      ubi.globalPosition.dx,
                      ubi.globalPosition.dy,
                      "",
                      40,
                      Color.fromARGB(255, random.nextInt(255),
                          random.nextInt(255), random.nextInt(255))));
                  //Si hay más de un nodo, se crea una linea entre el primer y ultimo
                  // if (nodos.length > 1) {
                  //   lineas.add(ModeloLinea(
                  //     nodos[nodos.length - 2].x,
                  //     nodos[nodos.length - 2].y,
                  //     nodos[nodos.length - 1].x,
                  //     nodos[nodos.length - 1].y,
                  //     //Se le asigna la distancia entre los nodos con 2 decimales
                  //     "${(sqrt(pow(nodos[nodos.length - 2].x - nodos[nodos.length - 1].x, 2) + pow(nodos[nodos.length - 2].y - nodos[nodos.length - 1].y, 2))).toStringAsFixed(2)}",
                  //   )
                  //   );
                  // }

                  // if (nodos.length > 1) {
                  //   nodos.forEach((nodo) {
                  //     if (nodo.nombre != "${nodos.length}") {
                  //       lineas.add(ModeloLinea(
                  //         nodos[nodos.length - 1].x,
                  //         nodos[nodos.length - 1].y,
                  //         nodo.x,
                  //         nodo.y,
                  //         //Se le asigna la distancia entre los nodos con 2 decimales
                  //         "${(sqrt(pow(nodos[nodos.length - 1].x - nodo.x, 2) + pow(nodos[nodos.length - 1].y - nodo.y, 2))).toStringAsFixed(2)}",
                  //       ));
                  //     }
                  //   });
                  // }
                }

                if (modo == 3) {
                  try {
                    nodos.forEach((nodo) {
                      if (sqrt(pow(nodo.x - ubi.globalPosition.dx, 2) +
                              pow(nodo.y - ubi.globalPosition.dy, 2)) <
                          nodo.radio) {
                        nodos.remove(nodo);

                        lineas.removeWhere((linea) =>
                            linea.x1 == nodo.x && linea.y1 == nodo.y ||
                            linea.x2 == nodo.x && linea.y2 == nodo.y);
                        //Se actualizan los nombres de los nodos
                        //for (int i = 0; i < nodos.length; i++) {
                        //  nodos[i].nombre = "${i + 1}";
                        //}
                      }
                    });
                  } catch (e) {}
                }
                if (modo == 4) {
                  try {
                    nodos.forEach((nodo) {
                      if (sqrt(pow(nodo.x - ubi.globalPosition.dx, 2) +
                              pow(nodo.y - ubi.globalPosition.dy, 2)) <
                          nodo.radio) {
                        if (contadorClicks == 0) {
                          nodoSeleccionado1 = nodo;
                          contadorClicks++;
                        } else if (contadorClicks == 1) {
                          nodoSeleccionado2 = nodo;
                          contadorClicks = 0;
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Ingrese el peso"),
                                  content: TextField(
                                    onChanged: (value) {
                                      lineas.forEach((linea) {
                                        if (linea.x1 == nodoSeleccionado1!.x &&
                                                linea.y1 ==
                                                    nodoSeleccionado1!.y &&
                                                linea.x2 ==
                                                    nodoSeleccionado2!.x &&
                                                linea.y2 ==
                                                    nodoSeleccionado2!.y ||
                                            linea.x1 == nodoSeleccionado2!.x &&
                                                linea.y1 ==
                                                    nodoSeleccionado2!.y &&
                                                linea.x2 ==
                                                    nodoSeleccionado1!.x &&
                                                linea.y2 ==
                                                    nodoSeleccionado1!.y) {
                                          linea.peso = double.parse(value);
                                        }
                                      });
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Aceptar"))
                                  ],
                                );
                              });
                        }
                      }
                    });
                  } catch (e) {}
                }
                if (modo == 5) {
                  //Se selecciona el nodo inicial y final y se le asigna un color verde
                  try {
                    nodos.forEach((nodo) {
                      if (sqrt(pow(nodo.x - ubi.globalPosition.dx, 2) +
                              pow(nodo.y - ubi.globalPosition.dy, 2)) <
                          nodo.radio) {
                        contadorClicks++;
                        if (contadorClicks == 1) {
                          nodoSeleccionado1 = nodo;
                          nodo.color = Colors.green;
                        } else if (contadorClicks == 2) {
                          nodoSeleccionado2 = nodo;
                          nodo.color = Colors.green;
                          print(
                              "Nodo 1: ${nodoSeleccionado1!.nombre} Nodo 2: ${nodoSeleccionado2!.nombre}");
                          //se suman los pesos de las lineas que conectan los nodos
                          double peso = 0;
                          lineas.forEach((linea) {
                            if (linea.x1 == nodoSeleccionado1!.x &&
                                    linea.y1 == nodoSeleccionado1!.y &&
                                    linea.x2 == nodoSeleccionado2!.x &&
                                    linea.y2 == nodoSeleccionado2!.y ||
                                linea.x1 == nodoSeleccionado2!.x &&
                                    linea.y1 == nodoSeleccionado2!.y &&
                                    linea.x2 == nodoSeleccionado1!.x &&
                                    linea.y2 == nodoSeleccionado1!.y) {
                              peso += linea.peso;
                              //mostar el peso en un alert dialog
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Peso total entre los nodos ${nodoSeleccionado1!.nombre} y ${nodoSeleccionado2!.nombre}"),
                                      content: Text("$peso"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Aceptar"))
                                      ],
                                    );
                                  });
                            }
                          });

                          contadorClicks = 0;
                        }
                      }
                    });
                  } catch (e) {}
                }
                if (modo == 6) {
                  //Se genera una linea entre los nodos que se toquen
                  try {
                    nodos.forEach((nodo) {
                      if (sqrt(pow(nodo.x - ubi.globalPosition.dx, 2) +
                              pow(nodo.y - ubi.globalPosition.dy, 2)) <
                          nodo.radio) {
                        contadorClicks++;
                        if (contadorClicks == 1) {
                          nodoSeleccionado1 = nodo;
                        } else if (contadorClicks == 2) {
                          nodoSeleccionado2 = nodo;
                          print(
                              "Nodo 1: ${nodoSeleccionado1!.nombre} Nodo 2: ${nodoSeleccionado2!.nombre}");
                          //generar la linea entre los nodos seleccionados y agregarla a la lista de lineas
                          lineas.add(ModeloLinea(
                            nodos[nodos.indexOf(nodoSeleccionado1!)].x,
                            nodos[nodos.indexOf(nodoSeleccionado1!)].y,
                            nodos[nodos.indexOf(nodoSeleccionado2!)].x,
                            nodos[nodos.indexOf(nodoSeleccionado2!)].y,
                            "0",
                          ));
                          contadorClicks = 0;
                        }
                      }
                    });
                  } catch (e) {}
                }
                if (modo == 7) {
                  try {
                    nodos.forEach((nodo) {
                      if (sqrt(pow(nodo.x - ubi.globalPosition.dx, 2) +
                              pow(nodo.y - ubi.globalPosition.dy, 2)) <
                          nodo.radio) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Ingrese el nombre del nodo"),
                                content: TextField(
                                  onChanged: (value) {
                                    nodo.nombre = value;
                                  },
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Aceptar"))
                                ],
                              );
                            });
                      }
                    });
                  } catch (e) {}
                }
              });
            },
          ),
          GestureDetector(
            onPanUpdate: (ubi) {
              setState(() {
                if (modo == 2) {
                  //moviendo nodo
                  nodos.forEach((nodo) {
                    if (sqrt(pow(nodo.x - ubi.globalPosition.dx, 2) +
                            pow(nodo.y - ubi.globalPosition.dy, 2)) <
                        nodo.radio) {
                      // mover las lineas y el nodo
                      for (var i = 0; i < lineas.length; i++) {
                        if (lineas[i].x1 == nodo.x && lineas[i].y1 == nodo.y) {
                          lineas[i].x1 = ubi.globalPosition.dx;
                          lineas[i].y1 = ubi.globalPosition.dy;
                          //se actualiza la distancia
                          lineas[i].distancia =
                              "${(sqrt(pow(lineas[i].x1 - lineas[i].x2, 2) + pow(lineas[i].y1 - lineas[i].y2, 2))).toStringAsFixed(2)}";
                        }
                        if (lineas[i].x2 == nodo.x && lineas[i].y2 == nodo.y) {
                          lineas[i].x2 = ubi.globalPosition.dx;
                          lineas[i].y2 = ubi.globalPosition.dy;
                          //se actualiza la distancia
                          lineas[i].distancia =
                              "${(sqrt(pow(lineas[i].x1 - lineas[i].x2, 2) + pow(lineas[i].y1 - lineas[i].y2, 2))).toStringAsFixed(2)}";
                        }
                      }
                      nodo.x = ubi.globalPosition.dx;
                      nodo.y = ubi.globalPosition.dy;
                    }
                  });
                  //moviendo linea
                }
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 63, 146, 219),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  modo = 1;
                });
              },
              icon: Icon(Icons.add),
              //tamano del icono
              iconSize: 40,
              tooltip: 'Nuevo Nodo',
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  modo = 2;
                });
              },
              icon: Icon(Icons.edit),
              tooltip: 'Mover Nodo',
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  modo = 3;
                });
              },
              iconSize: 40,
              icon: Icon(Icons.delete),
              tooltip: 'Eliminar Nodo',
            ),
            IconButton(
              onPressed: (() {
                setState(() {
                  modo = 4;
                });
              }),
              icon: Icon(Icons.edit_attributes),
              iconSize: 40,
              tooltip: 'Insertar pesos',
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  modo = 5;
                });
              },
              icon: Icon(Icons.calculate),
              iconSize: 40,
              tooltip: 'Calcular ruta entre nodos',
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  modo = 6;
                });
              },
              icon: Icon(Icons.ads_click),
              iconSize: 40,
              tooltip: 'Conectar nodos',
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  modo = 7;
                });
              },
              icon: Icon(Icons.generating_tokens_outlined),
              iconSize: 40,
              tooltip: 'Cambiar nombre de nodos',
            ),
          ],
        ),
      ),
    ));
  }
}
