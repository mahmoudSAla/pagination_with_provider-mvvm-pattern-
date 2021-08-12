import 'dart:convert';

import 'package:pagination_with_provider/model/news_model.dart';
import 'package:http/http.dart' as http;
class NewsApi {
  Future<news> getNews (pageNumber) async {
    String Url = "https://newsapi.org/v2/everything?q=bitcoin&pageSize=8&page=$pageNumber&apiKey=36213335d79d4114b9cce146e24cc99c";
    print("URL:$Url") ;
    final response = await http.get(Uri.parse(Url)) ;
    if(response.statusCode == 200){
      return news.fromJson(json.decode(response.body)) ;
      
    }else{
     throw Exception("Failed to load Data !!!!!!!") ;

    }

  }
}