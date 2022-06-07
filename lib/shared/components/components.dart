import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController Controlar,
  required TextInputType keyboardType,
  Function? onfiled,
  Function? onchanged,
  GestureTapCallback? ontab,
  FormFieldValidator<String>? validator,
  required String Label,
  IconData? prefix,
  IconData? sufix,
  bool? obscureText = false,
  InputDecoration? InputDecorationn,
}) =>
    TextFormField(
      onTap: ontab,
      obscureText: obscureText!,
      controller: Controlar,
      keyboardType: keyboardType,
      onFieldSubmitted: (s) {
        onfiled!(s);
      },
      onChanged: (s) {
        onchanged!(s);
      },
      validator: validator,
      decoration: InputDecorationn,
    );

Widget buildArticleItem(article, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120.0,
            width: 120.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );

// Widget articleBuilder(list , {isSearch = false }) => ConditionalBuilder(
//     condition: list.length > 0,
//     builder: (context) => ListView.separated(
//         // remove the color from top screen that appears when scroll screen
//         physics: BouncingScrollPhysics(),
//         itemBuilder: (context, index) => buildArticleItem(list[index], context),
//         separatorBuilder: (context, index) => myDivider(),
//         itemCount: 10),
//     fallback: (context) => Center(child: CircularProgressIndicator()));

Widget articleBuilder(list , {isSearch = false }) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index], context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: list.length),
  fallback: (context) => isSearch ? Center(
    child: Container(
      child: Text(
        'Search Screen ',
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.grey ,
        ),
      ),
    ),
  ) : Center(child: CircularProgressIndicator()),
);
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Future Navegato(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);