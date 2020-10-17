import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import '../providers/news_provider.dart';

class NewsGridItem extends StatelessWidget {
  
  final String title;

  NewsGridItem({
    @required this.title,
  });

  void _launchArticle(String articleUrl) async{
     if(await canLaunch(articleUrl)){
          await launch(articleUrl);
     }
  }


  @override
  Widget build(BuildContext context) {

    final articleData = Provider.of<NewsProvider>(context, listen: false).getModelDataByTitle(title);

    return InkWell(
      splashColor: Colors.purpleAccent,
      onTap: () => _launchArticle(articleData.articleUrl),
      child: GridTile(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width > 500 ? 190 : 230,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                    color: Colors.blueGrey,
                  ),
                  child: ClipRRect(
                    child: (articleData.imageUrl == null ) ? Image.asset(
                      'assets/images/news.png',
                      fit: BoxFit.cover,
                    ) : Image.network(
                      articleData.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (articleData.author != null)
                              Text(
                                MediaQuery.of(context).size.width > 500
                                    ? articleData.author.length > 40
                                        ? articleData.author.substring(0, 40) + '...'
                                        : articleData.author
                                    : articleData.author.length > 60
                                        ? articleData.author.substring(0, 60) + '...'
                                        : articleData.author,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width > 500
                                          ? 13
                                          : 15,
                                ),
                              ),
                            if (articleData.publishedBy != null)
                              Text(
                                DateFormat.yMMMd()
                                    .format(DateTime.parse(articleData.publishedBy)),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width > 500
                                          ? 13
                                          : 15,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (articleData.source != null)
                        Expanded(
                          child: Text(
                            articleData.source,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width > 500
                                  ? 13
                                  : 15,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      MediaQuery.of(context).size.width > 500
                          ? title.length > 110
                              ? title.substring(0, 110) + '...'
                              : title
                          : title.length > 140
                              ? title.substring(0, 140) + '...'
                              : title,
                      style: MediaQuery.of(context).size.width > 500
                          ? Theme.of(context).textTheme.headline6
                          : Theme.of(context).textTheme.headline5,
                    ),
                  ),
                SizedBox(
                  height: 6,
                ),
                if (articleData.description != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      MediaQuery.of(context).size.width > 500
                          ? articleData.description.length > 100
                              ? articleData.description.substring(0, 100) + '...'
                              : articleData.description
                          : articleData.description.length > 120
                              ? articleData.description.substring(0, 120) + '...'
                              : articleData.description,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
