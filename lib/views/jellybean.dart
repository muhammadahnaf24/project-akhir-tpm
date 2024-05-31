import 'package:flutter/material.dart';
import 'package:project_akhir_tpm/models/jellybean_model.dart';
import 'package:project_akhir_tpm/services/api_service.dart';
import 'package:project_akhir_tpm/views/detail.dart';

class JellyBeanListScreen extends StatefulWidget {
  @override
  _JellyBeanListScreenState createState() => _JellyBeanListScreenState();
}

class _JellyBeanListScreenState extends State<JellyBeanListScreen> {
  late Future<List<JellyBean>> _jellyBeansFuture;
  final TextEditingController _searchController = TextEditingController();
  late List<JellyBean> _filteredJellyBeans = [];
  List<JellyBean> _jellyBeans = [];

  @override
  void initState() {
    super.initState();
    _jellyBeansFuture = fetchJellyBeans().then((beans) {
      _jellyBeans = beans;
      return beans;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JellyBean',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal[800],
        elevation: 0, // remove shadow
        centerTitle: true,
        actions: [
          Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _searchController.clear();
                    _filteredJellyBeans.clear();
                  });
                },
              ) : null,
              filled: true,
              fillColor: Colors.blueGrey[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: _filterJellyBeans,
          ),
          SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<List<JellyBean>>(
              future: _jellyBeansFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No jelly beans available'));
                } else {
                  final List<JellyBean> beansToDisplay = _filteredJellyBeans.isNotEmpty ? _filteredJellyBeans : _jellyBeans;
                  return ListView.builder(
                    itemCount: beansToDisplay.length,
                    itemBuilder: (context, index) {
                      final bean = beansToDisplay[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          title: Text(
                            bean.flavorName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${bean.description}'),
                              Text('Color Group: ${bean.colorGroup}'),
                              SizedBox(height: 4),
                            ],
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(bean.imageUrl),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JellyBeanDetailScreen(bean: bean),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _filterJellyBeans(String query) {
    setState(() {
      _filteredJellyBeans = [];
      if (query.isNotEmpty) {
        final List<JellyBean> beans = _jellyBeans.where((bean) => bean.flavorName.toLowerCase().contains(query.toLowerCase())).toList();
        _filteredJellyBeans.addAll(beans);
      }
    });
  }
}
