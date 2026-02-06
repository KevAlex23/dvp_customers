import 'package:flutter/material.dart';


  PreferredSizeWidget customAppBar({required BuildContext context, required String title, required List<Widget> actions}) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).colorScheme.secondary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: AppBar(
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
          backgroundColor: Colors.transparent, // Transparent to show gradient
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).colorScheme.surface,),
          ),
          actions: actions
        ),
      ),
    );
  }