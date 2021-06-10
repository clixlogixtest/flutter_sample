import 'dart:async';

import 'package:slider_widget/blocs/user/bloc.dart';
import 'package:slider_widget/blocs/user/event.dart';
import 'package:slider_widget/blocs/user/state.dart';
import 'package:slider_widget/models/models.dart';
import 'package:slider_widget/screens/screens.dart';
import 'package:slider_widget/utils/app_colors.dart';
import 'package:slider_widget/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:slider_widget/utils/storage_helper.dart';
import 'package:slider_widget/utils/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class Home extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Home> {

  UserBloc _userBloc;

  @override
  void initState() {
    _userBloc =  BlocProvider.of<UserBloc>(context);
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child:Center(
            child:  Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('User is Authenticated Successfully .',style: TextStyle(fontSize: 20),),
                SizedBox(height: 30,),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {

                    if(state.user != null) {
                      return Column(
                        children: [
                          Text('ID :${state.user.id}'),
                          Text('Name :${state.user.name}'),
                          Text('Email :${state.user.email}'),
                          Text('Token :${state.user.token}'),

                        ],
                      );
                    }
                    else return Container();
                  },
                ),

                ElevatedButton(
                    child: Text('Logout'),
                    onPressed: (){
                      MySharedPreferences.instance.removeAll();
                      _userBloc.add(UserLoggedOut());
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                     // Navigator.pushNamed(context,'/login');

                    }
                ),


              ],
            ),
          ),
        ));
    ;
  }
}

/**
 *  List.generate(6, (index) {
    return Center(
    child: RaisedButton(
    onPressed: (){},
    color: Colors.greenAccent,
    child: Text(
    '$index AM',
    ),
    ),
    );
    })
 */
