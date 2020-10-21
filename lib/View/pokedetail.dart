import 'package:flutter/material.dart';
import 'package:pokemon_detector/Model/mypoke_list.dart';
import 'package:pokemon_detector/Model/pokemon_store.dart';
import 'package:pokemon_detector/View/pokelist.dart';

class PokeDetails extends StatefulWidget {
  Pokemon selectedPokemon;

  PokeDetails({this.selectedPokemon});

  @override
  _PokeDetailsState createState() => _PokeDetailsState();
}

class _PokeDetailsState extends State<PokeDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime[100],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.selectedPokemon.name,
          style: TextStyle(fontSize: 18, color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.9,
              right: (MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width * 0.9) /
                  2,
              bottom: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height * 0.8) /
                  2,
              child: SingleChildScrollView(
                child: Card(
                  color: Colors.red.shade900,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(50))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch ,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 100),

                      Card(
                        color: Colors.pink.shade200,
                        elevation: 2,
                        child: Column(
                          children: [
                            Text(
                              widget.selectedPokemon.name,
                              style: myStyle.title(),
                            ),
                            Text("Height : " + widget.selectedPokemon.height,
                                style: myStyle.subTitle()),
                            Text("Weight : " + widget.selectedPokemon.weight,
                                style: myStyle.subTitle()),
                          ],
                        ),
                      ),

                      Card(
                        color: Colors.orange.shade500,
                        elevation: 2,
                        child: Column(
                          children: [
                            Text("Types", style: myStyle.title()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: widget.selectedPokemon.type
                                  .map((e) => Chip(
                                label: Text(e,style: myStyle.ChipText()),
                              ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),

                      Card(
                        color: Colors.yellow.shade600,
                        elevation: 2,
                        child: Column(
                          children: [
                            Text("Pre Evolution", style: myStyle.title()),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: widget.selectedPokemon.prevEvolution != null
                                    ? widget.selectedPokemon.prevEvolution
                                    .map((e) => InkWell(
                                    onTap: () => goToNextPokee(e),
                                    child: Chip(
                                      label: Text(e.name,style: myStyle.ChipText()),
                                    )))
                                    .toList()
                                    : [
                                  Text("No Pre Evolution",
                                      style: myStyle.errorTitle())
                                ]),
                          ],
                        ),
                      ),

                      Card(
                        color: Colors.green,
                        elevation: 2,
                        child: Column(
                          children: [
                            Text("Next Evolution", style: myStyle.title()),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: widget.selectedPokemon.nextEvolution != null
                                    ? widget.selectedPokemon.nextEvolution
                                    .map((e) => InkWell(
                                    onTap: () => goToNextPokee(e),
                                    child: Chip(
                                      label: Text(e.name,style: myStyle.ChipText(),),
                                    )))
                                    .toList()
                                    : [Text("No Next Evolution",style: myStyle.errorTitle())]),
                          ],
                        ),
                      ),

                      Card(
                        color: Colors.blueAccent,
                        elevation: 2,
                        child: Column(
                          children: [
                            Text("Weakness", style: myStyle.title()),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: widget.selectedPokemon.weaknesses != null
                                    ? widget.selectedPokemon.weaknesses
                                    .map((e) => Chip(
                                  label: Text(e,style: myStyle.ChipText()),
                                ))
                                    .toList()
                                    : [Text("No Next Evolution",style: myStyle.errorTitle(),)]),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              )),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
                tag: widget.selectedPokemon.img,
                child: Container(
                  width: 140,
                  height: 140,
                  child: Image.network(
                    widget.selectedPokemon.img,
                    fit: BoxFit.cover,
                  ),
                )),
          )
        ],
      ),
    );
  }

  void goToNextPokee(Evolution e) {
    for (int i = 0; i < MyPokeList.myPokeList.length; i++) {
      if (MyPokeList.myPokeList[i].name == e.name) {
        setState(() {
          widget.selectedPokemon = MyPokeList.myPokeList[i];
        });
      }
    }
  }
}

class myStyle {
  static title() {
    return TextStyle(
        fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w600);
  }

  static subTitle() {
    return TextStyle(
        fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w300);
  }

  static ChipText() {
    return TextStyle(
        fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold);
  }

  static errorTitle() {
    return TextStyle(
        fontSize: 16, color: Colors.redAccent[700], fontWeight: FontWeight.bold);
  }
}
