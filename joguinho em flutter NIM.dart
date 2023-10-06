import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int totalPalitos = 0;
  int maxRetirar = 0;
  int palitosFaltantes = 0;
  int palitosRetirados = 0;
  bool playerTurn = true;
  bool gameOver = false;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUSTAVO CARDOSO SANTOS DA SILVA 1431432312003'),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (!gameOver)
                Column(
                  children: [
                    Text(
                      'Palitos no jogo: $palitosFaltantes',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    Text(
                      'Máximo a retirar: $maxRetirar',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    Text(
                      playerTurn ? 'Sua vez!' : 'Vez do computador!',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    Container(
                      width: 200.0,
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Quantidade de Palitos a Retirar',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final input = controller.text;
                        if (input.isNotEmpty && input.replaceAll(RegExp(r'\d'), '') == '') {
                          final int quantidadeRetirar = int.parse(input);
                          if (quantidadeRetirar >= 1 &&
                              quantidadeRetirar <= maxRetirar &&
                              quantidadeRetirar <= palitosFaltantes) {
                            setState(() {
                              palitosRetirados += quantidadeRetirar;
                              palitosFaltantes -= quantidadeRetirar;
                              playerTurn = !playerTurn;
                              if (palitosFaltantes == 0) {
                                gameOver = true;
                              } else {
                                final int quantidadeComputador = palitosFaltantes % (maxRetirar + 1);
                                palitosRetirados += quantidadeComputador;
                                palitosFaltantes -= quantidadeComputador;
                                playerTurn = true;
                                if (palitosFaltantes == 0) {
                                  gameOver = true;
                                }
                              }
                            });
                          }
                        }
                        controller.clear();
                      },
                      child: Text('Retirar'),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    Text(
                      'Fim do jogo! ${playerTurn ? "Você perdeu!" : "Você ganhou!"}',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    Text(
                      'Palitos retirados: $palitosRetirados',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          startGame();
                        });
                      },
                      child: Text('Reiniciar Jogo'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void startGame() {
    setState(() {
      totalPalitos = Random().nextInt(10) + 2;
      maxRetirar = Random().nextInt(4) + 1;
      palitosFaltantes = totalPalitos;
      palitosRetirados = 0;
      playerTurn = true;
      gameOver = false;
    });
  }
}
