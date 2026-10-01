import 'package:apptest/models/user_model.dart';
import 'package:apptest/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDetailsScreen extends StatefulWidget {
  final int userId;

  const UserDetailsScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserDetailsScreen> createState() =>
      _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final ApiService apiService = ApiService();

  late Future<UserModel> userFuture;

  @override
  void initState() {
    super.initState();

    userFuture = apiService.fetchUserById(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title:  Text('User Details',style: GoogleFonts.poppins(fontWeight: FontWeight(800),color: Colors.blue),),
        centerTitle: true,
      ),
      body: FutureBuilder<UserModel>(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Failed to load user details'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('User not found'),
            );
          }

          UserModel user = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth < 600 ? 20 : 60,
              vertical: 25,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 650,
                ),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,backgroundColor: Colors.blue,
                          child: Text(
                            user.name?.isNotEmpty == true
                                ? user.name![0].toUpperCase()
                                : '?',
                            style:  GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight(700),color: Colors.white
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        detailRow(
                          'Name',
                          user.name ?? 'Not available',
                        ),

                        detailRow(
                          'Username',
                          user.username ?? 'Not available',
                        ),

                        detailRow(
                          'Email',
                          user.email ?? 'Not available',
                        ),

                        detailRow(
                          'Phone',
                          user.phone ?? 'Not available',
                        ),

                        detailRow(
                          'Website',
                          user.website ?? 'Not available',
                        ),

                        detailRow(
                          'Company',
                          user.company?.name ?? 'Not available',
                        ),

                        detailRow(
                          'City',
                          user.address?.city ?? 'Not available',
                        ),

                        detailRow(
                          'Street',
                          user.address?.street ?? 'Not available',
                        ),

                        detailRow(
                          'Zipcode',
                          user.address?.zipcode ?? 'Not available',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$title:',
              style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight(700))
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}