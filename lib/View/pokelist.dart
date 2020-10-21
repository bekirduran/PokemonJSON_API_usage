import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'  as http;
import 'package:pokemon_detector/Model/mypoke_list.dart';
import 'file:///C:/flutter_calismalarim/flutter_tasarim/pokemon_detector/lib/constants.dart';
import 'package:pokemon_detector/Model/pokemon_store.dart';
import 'package:pokemon_detector/View/pokedetail.dart';

class PokeList extends StatefulWidget {
  @override
  _PokeListState createState() => _PokeListState();
}

class _PokeListState extends State<PokeList> {
 PokemonStore pokemonStore;
 Future<PokemonStore> futurePokeStore;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePokeStore = gettAllPokemons();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.lime[100],

      body: FutureBuilder(future: futurePokeStore, builder: (BuildContext context, AsyncSnapshot<PokemonStore> snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        else if (snapshot.connectionState == ConnectionState.done) {
          return OrientationBuilder(builder: (context, orientation){
            if (orientation == Orientation.portrait)
              return buildPortraitBodyGrid(snapshot);
            else
              return buildLandscapeBodyGrid(snapshot);
          });
        }
        else {
          return null;
        }
      },),
    );
  }

  Widget buildPortraitBodyGrid(AsyncSnapshot<PokemonStore> snapshot) {
    return GridView.count(crossAxisCount: 2, children:
      snapshot.data.pokemon.map((e) {
        MyPokeList.myPokeList = snapshot.data.pokemon;

        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PokeDetails(selectedPokemon: e,))),

            child: Hero(tag: e.img, child: Card(
              elevation: 8,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blueGrey.shade500, Colors.blueGrey.shade50]
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: 110,
                        height: 110,
                        child: FadeInImage.assetNetwork(placeholder: "assets/placeholder.jpg" , image: e.img),
                      ),
                    ),

                    Text(e.name, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.black54),)
                  ],
                ),
              ),
            )),
          ),
        );


      }).toList()
    ,);
  }

  Widget buildLandscapeBodyGrid(AsyncSnapshot<PokemonStore> snapshot) {
   return GridView.extent(maxCrossAxisExtent: MediaQuery.of(context).size.width / 3, children:
   snapshot.data.pokemon.map((e) {
     snapshot.data.pokemon = MyPokeList.myPokeList;
     return Padding(
       padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
       child: InkWell(
         onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PokeDetails(selectedPokemon: e,))),

         child: Hero(tag: e.img, child: Card(
           elevation: 8,
           child: Container(
             decoration: BoxDecoration(
                 gradient: LinearGradient(
                     begin: Alignment.topCenter,
                     end: Alignment.bottomCenter,
                     colors: [Colors.blueGrey.shade500, Colors.blueGrey.shade50]
                 )
             ),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Container(
                   margin: EdgeInsets.all(10),
                   width: 110,
                   height: 110,
                   child: FadeInImage.assetNetwork(placeholder: "assets/placeholder.jpg" , image: e.img),
                 ),

                 Text(e.name, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.black54),)
               ],
             ),
           ),
         )),
       ),
     );


   }).toList()
     ,);
 }



 Future <PokemonStore> gettAllPokemons() async{
    var url = Constants.url;
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    pokemonStore = PokemonStore.fromJson(data);
    return pokemonStore;
  }
}
