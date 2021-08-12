// @dart=2.9
import 'package:flutter/material.dart';
import 'package:pagination_with_provider/provider/news_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController() ;
  int _page = 1 ;
  bool isloading = false ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var dataProvider = Provider.of<DataProvider>(context , listen: false) ;
    dataProvider.initStreams() ;
    dataProvider.fetchAllData(_page) ;
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        dataProvider.setLoadingState(LoadMoreStatues.LOADING) ;
        dataProvider.fetchAllData(_page++) ;

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagination"),
        centerTitle: true,


      ),
      body: Consumer<DataProvider>(builder: (context , dataModel , chiled ){
          if(dataModel.allData != null && dataModel.allData.length > 0){
            return _listView(dataModel);
          }else{
            return Center(child: CircularProgressIndicator(),) ;
          }
      }),
    );
  }

  Widget _listView(DataProvider dataProvider) {
    return ListView.separated(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context , index) {
      return ListTile(
        title: Text("${dataProvider.allData[index].title}"),
        subtitle: Text("${dataProvider.allData[index].content}"),
      );
    },
        separatorBuilder: (context  , index){
      return Divider() ;
    },
        itemCount: dataProvider.allData.length);
  }
}
