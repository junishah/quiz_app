

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

 class localDb{

   static final uidkey='sjyklopkjjynba';
   static final levelkey='sjyklopkjddhdhjynba';
   static final rankkey='sjyklopjsjskjddhdhjynba';
   static final namekey='sjyklopkmakjdiaynba';
   static final moneykey='sjyklopkjjasedw';
   static final profilekey='sjyklopopmj';
   static Future<bool> saveUserId(String uid)async{
     SharedPreferences preferences= await SharedPreferences.getInstance();
     return await preferences.setString(uidkey, uid);

   }
   static Future<String?> getUserId()async{
     SharedPreferences preferences= await SharedPreferences.getInstance();
     return await preferences.getString(uidkey);

   }

   static Future<bool> saveUserMoney(String money)async{
     SharedPreferences preferences= await SharedPreferences.getInstance();
     return await preferences.setString(moneykey, money);

   }
   static Future<String?> getUserMoney()async{
     SharedPreferences preferences= await SharedPreferences.getInstance();
     return await preferences.getString(moneykey);

   }

   static Future<bool> saveUserLevel(String level)async{
     SharedPreferences preferences= await SharedPreferences.getInstance();
     return await preferences.setString(levelkey, level);

   }
   static Future<String?> getUserLevel()async{
     SharedPreferences preferences= await SharedPreferences.getInstance();
     return await preferences.getString(levelkey);

   }
   static Future<bool> saveUserRank(String rank)async{
     SharedPreferences preferences= await SharedPreferences.getInstance();
     return await preferences.setString(rankkey, rank);

   }
   static Future<String?> getUserRank()async{
     SharedPreferences preferences= await SharedPreferences.getInstance();
     return await preferences.getString(rankkey);

   }


   static Future<bool> saveUserName(String name)async{
     SharedPreferences preferences= await SharedPreferences.getInstance();
     return await preferences.setString(namekey, name);

   }
   static Future<String?> getUserName()async{
     SharedPreferences preferences= await SharedPreferences.getInstance();
     return await preferences.getString(namekey);

   }


   static Future<bool> saveUserPrice(String uid)async{
     SharedPreferences preferences= await SharedPreferences.getInstance();
     return await preferences.setString(uidkey, uid);

   }
   static Future<String?> getUserprice()async{
     SharedPreferences preferences= await SharedPreferences.getInstance();
     return await preferences.getString(uidkey);

   }


   static Future<bool> saveUserImageUrl(String profileurl)async{
     SharedPreferences preferences= await SharedPreferences.getInstance();
     return await preferences.setString(profilekey, profileurl);

   }
   static Future<String?> getUserImageUrl()async{
     SharedPreferences preferences= await SharedPreferences.getInstance();
     return await preferences.getString(profilekey);

   }


}