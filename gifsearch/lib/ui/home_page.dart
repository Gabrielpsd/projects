import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gifsearch/ui/gei_page.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  String? _search;
  int _offset = 0;

  Future<Map> getGif() async {
    http.Response response;

    if (_search == null || _search!.isEmpty)
      response = await http.get(Uri.parse(
          "https://api.giphy.com/v1/gifs/trending?api_key=HRHmXr5IWl7jeNKXXkvXj5bFq3FGYmRS&limit=25&offset=0&rating=g&bundle=messaging_non_clips"));
    else
      response = await http.get(Uri.parse(
          "https://api.giphy.com/v1/gifs/search?api_key=HRHmXr5IWl7jeNKXXkvXj5bFq3FGYmRS&q=$_search&limit=24&offset=$_offset&rating=g&lang=en&bundle=messaging_non_clips"));

    print(_search);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                });
              },
              decoration: InputDecoration(
                labelText: "Search",
                hintStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(decorationColor: Colors.white),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getGif(),
              builder: (contex, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      height: 200,
                      width: 200,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
                  default:
                    if (snapshot.hasError)
                      return (Container());
                    else
                      return _creatGifTable(contex, snapshot);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  int _getCount(List data) {
    if (_search == null) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  _creatGifTable(BuildContext contex, AsyncSnapshot<Map> snapshot) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemBuilder: (contex, index) {
        if (_search == null || index < snapshot.data!["data"].length) {
          return GestureDetector(
            onLongPress: () {
              Share.share(snapshot.data!["data"][index]["images"]
                  ["fixed_height"]["url"]);
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      GifPage(gifData: snapshot.data!["data"][index]),
                ),
              );
            },
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: snapshot.data!["data"][index]["images"]["fixed_height"]
                  ["url"],
              height: 300.0,
              fit: BoxFit.cover,
              width: 350,
            ),
          );
        } else {
          return Container(
            child: GestureDetector(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    Text(
                      "Carregando ...",
                      style: TextStyle(color: Colors.white, fontSize: 22.00),
                    )
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  _offset += 19;
                  print(_offset);
                });
              },
            ),
          );
        }
      },
      padding: EdgeInsets.all(8),
      itemCount: _getCount(snapshot.data!["data"]),
    );
  }
}
