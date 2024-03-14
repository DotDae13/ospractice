import 'package:flutter/material.dart';

import '../util/job_card.dart';
import '../util/recent_job_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List jobsForYou =  [
    ['Uber', 'UI Designer', 'assests/icons/uber.png', 45],
    ['Google', 'Product Dev', 'assests/icons/google.png', 80],
    ['Apple', 'Software Designer', 'assests/icons/apple.png', 95],
  ];

  final List recentJobs =  [
    ['Google', 'Flutter Dev', 'assests/icons/google.png', 100],
    ['Apple', 'Swift Dev', 'assests/icons/apple.png', 110],
    ['Uber', 'HR', 'assests/icons/uber.png', 85],
  ];

  int _selectedIndex = 0;
  String _selectedCompanyFilter = 'All'; // Track the selected company filter

  void _navigateToIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Function to update the selected company filter and trigger UI update
  void _updateCompanyFilter(String filter) {
    setState(() {
      _selectedCompanyFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 75,),

          //app bar
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Container(
              height: 70,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: Image.asset(
                'assests/icons/menu_from_left.png',
                color: Colors.grey[800],
              ),
            ),
          ),

          const SizedBox(height: 5,),

          //discover a new path
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Discover a New Path",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),

          const SizedBox(height: 5,),

          //search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10.0),
                          child: Container(
                            height: 30,
                            child: Icon(
                              Icons.search,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search for a job..'
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10,),
                Container(
                  height: 50,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: const Icon(
                    Icons.filter_list_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15,),

          //for you
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "For You",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),

          const SizedBox(height: 5,),

          Container(
            height: 140,
            child: ListView.builder(
              itemCount: jobsForYou.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return JobCard(
                  companyName: jobsForYou[index][0],
                  jobTitle: jobsForYou[index][1],
                  logoImagePath: jobsForYou[index][2],
                  hourlyRate: jobsForYou[index][3],
                );
              },),
          ),

          //recently added -> job title
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Recently Added",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Wrap(
              spacing: 8.0,
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: _selectedCompanyFilter == 'All',
                  onSelected: (_) => _updateCompanyFilter('All'),
                ),
                FilterChip(
                  label: const Text('Google'),
                  selected: _selectedCompanyFilter == 'Google',
                  onSelected: (_) => _updateCompanyFilter('Google'),
                ),
                FilterChip(
                  label: const Text('Uber'),
                  selected: _selectedCompanyFilter == 'Uber',
                  onSelected: (_) => _updateCompanyFilter('Uber'),
                ),
                FilterChip(
                  label: const Text('Apple'),
                  selected: _selectedCompanyFilter == 'Apple',
                  onSelected: (_) => _updateCompanyFilter('Apple'),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView.builder(
                itemCount: recentJobs.length,
                itemBuilder: (context, index) {
                  // Filter the list based on selected company filter
                  if (_selectedCompanyFilter == 'All' || recentJobs[index][0] == _selectedCompanyFilter) {
                    return RecentJobCard(
                      companyName: recentJobs[index][0],
                      jobTitle: recentJobs[index][1],
                      logoImagePath: recentJobs[index][2],
                      hourlyRate: recentJobs[index][3],
                    );
                  } else {
                    // If the item does not match the selected company filter, return an empty container
                    return Container();
                  }
                },
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _navigateToIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite, color: Colors.redAccent,), label: 'Wishlist'),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]
      ),
    );
  }
}
