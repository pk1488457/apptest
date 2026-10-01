import 'package:apptest/models/user_model.dart';
import 'package:apptest/screens/registration_screen.dart';
import 'package:apptest/screens/user_detail_screen.dart';
import 'package:apptest/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ApiService apiService = ApiService();

  List<UserModel> users = [];

  bool isLoading = true;
  String errorMessage = '';

  String savedName = '';
  String savedEmail = '';

  @override
  void initState() {
    super.initState();

    getSavedUser();
    getUsers();

  }

  Future<void> getSavedUser() async {
    SharedPreferences preferences =
        await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      savedName = preferences.getString('name') ?? '';
      savedEmail = preferences.getString('email') ?? '';
    });
  }

  Future<void> getUsers() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      List<UserModel> result = await apiService.fetchUsers();

      if (!mounted) return;

      setState(() {
        users = result;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        errorMessage = 'Failed to load users';
      });
    } finally {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> logout() async {
    SharedPreferences preferences =
        await SharedPreferences.getInstance();

    await preferences.clear();

    if (!mounted) return;

    Get.offAll(() => const RegistrationScreen());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth =
        MediaQuery.sizeOf(context).width;

    double horizontalPadding =
        screenWidth >= 600 ? 40 : 12;

    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white,
          title: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
               Text(
                'Users Dashboard',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight(800),color: Colors.blue
                ),
              ),
             SingleChildScrollView(
              scrollDirection: Axis.horizontal,
               child: Row(
                children: [
                   Text(
                  ' $savedName ',
                  style:  GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight(600),
                  ),
                ),
                Text(
                  '  $savedEmail',
                  style:  GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight(400),
                  ),
                ),
                ],
               ),
             ) 
            ],
          ),
          actions: [
            IconButton(
              onPressed: logout,
              tooltip: 'Logout',
              icon:  Icon(Icons.logout),color: Colors.blue,
          
            ),
          ],
        ),
        body:  isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : errorMessage.isNotEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(errorMessage),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: getUsers,
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  )
                : users.isEmpty
                    ? const Center(
                        child: Text('No users found'),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              horizontalPadding,
                          vertical: 15,
                        ),
                        
                        itemCount: users.length,
                        
                        
                        itemBuilder:
                            (context, index) {
                          UserModel user =
                              users[index];


                          return Card(
                            color: const Color.fromARGB(255, 195, 217, 235),
                            margin:
                                const EdgeInsets.only(
                              bottom: 15,
                            ),
                            elevation: 5,
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(
                                8,
                              ),
                              child: ListTile(
  onTap: () {
     if (user.id != null) {
      Get.to(()=>UserDetailsScreen( userId: user.id!));
      print('see ${user.name} detail');
            
    }
  },
  leading: CircleAvatar(
    backgroundColor: Colors.blue,
    child: Text(
      user.name?.isNotEmpty == true
          ? user.name![0].toUpperCase()
          : '?',style: GoogleFonts.poppins(fontWeight: FontWeight(700),fontSize: 20,color: Colors.white),
    ),
  ),
  title: Text(
    user.name ?? 'No name',
    style: GoogleFonts.poppins(
      fontWeight: FontWeight(600),fontSize: 18
    ),
  ),
  subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Username: ${user.username ?? ''}',style:  GoogleFonts.poppins(
      fontWeight: FontWeight(500),fontSize: 15
    ),),
      Text('Email: ${user.email ?? ''}', style:  GoogleFonts.poppins(
      fontWeight: FontWeight(500),fontSize: 12
    ),),
    ],
  ),
  trailing: const Icon(Icons.arrow_forward_ios, size: 18,color: Colors.blue,),
),
                            ),
                          );
                        },
                      ),
      );
    
  }
}