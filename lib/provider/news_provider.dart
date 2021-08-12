import 'package:flutter/material.dart';
import 'package:pagination_with_provider/controler/news_api_controllre.dart';
import 'package:pagination_with_provider/model/news_model.dart';

enum LoadMoreStatues { LOADING, STABLE }

class DataProvider with ChangeNotifier {
  late news _newsModel;
  late NewsApi _newsApi;

  int totalPages = 0;
  List<Articles> get allData => _newsModel.articles;
  int get totalNews => _newsModel.totalResults;

  LoadMoreStatues _loadMoreStatues = LoadMoreStatues.STABLE;
  getLoadMoreStatues() => LoadMoreStatues;

  DataProvider() {
    initStreams();
  }
  initStreams(){
    _newsApi = new NewsApi();
    _newsModel = new news() ;
  }

  fetchAllData (PageNumber) async{
    if (totalPages == 0 || PageNumber <= totalPages ){
      news itemModel = await _newsApi.getNews(PageNumber) ;
      if(_newsModel.articles == null){
        totalPages == ((itemModel.totalResults - 1) / 8) .ceil() ;
        _newsModel = itemModel  ;


      }else{
        _newsModel.articles.addAll(itemModel.articles) ;
        _newsModel = _newsModel ;
        setLoadingState(LoadMoreStatues.STABLE) ;
      }


    }
    if(PageNumber > totalPages){
      setLoadingState(LoadMoreStatues.STABLE) ;

    }
  }

  void setLoadingState(LoadMoreStatues loadMoreStatues) {
    _loadMoreStatues = loadMoreStatues ;
    notifyListeners() ;

  }

}
