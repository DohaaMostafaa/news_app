import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../modules/web_news/web_view.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String? value) validate,
  required String label,
  required IconData? prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
  Function(String)? onSubmit,
  bool isPassword = false,
  VoidCallback? onTap,
  String? Function(String? value)? onChanged,
  Color borderColor = Colors.blue,
  Color textColor = Colors.black,
}) =>
    TextFormField(
      style: TextStyle(color: textColor),
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      onChanged: onChanged,
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: suffixPressed,
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 1.0,
        color: Colors.deepOrange,
      ),
    );
Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(
          context,
          WebViewScreen(article['url']),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: article['urlToImage'] != null
                      ? NetworkImage('${article['urlToImage']}')
                      : const AssetImage('assets/image/News.png')
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: list.length),
      fallback: (context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
