import 'package:flutter/material.dart';
import 'package:project_akhir_tpm/models/jellybean_model.dart';

class JellyBeanDetailScreen extends StatelessWidget {
  final JellyBean bean;

  JellyBeanDetailScreen({required this.bean});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          bean.flavorName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal[800],
        elevation: 0, // remove shadow
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(bean.imageUrl),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  bean.flavorName,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow("Description", bean.description),
                      SizedBox(height: 16),
                      _buildDetailRow("Color Group", bean.colorGroup),
                      SizedBox(height: 16),
                      _buildDetailRow("Group Names", bean.groupName.join(', ')),
                      SizedBox(height: 16),
                      _buildDetailRow("Ingredients", bean.ingredients.join(', ')),
                      SizedBox(height: 16),
                      _buildBooleanRow("Gluten Free", bean.glutenFree),
                      SizedBox(height: 16),
                      _buildBooleanRow("Sugar Free", bean.sugarFree),
                      SizedBox(height: 16),
                      _buildBooleanRow("Seasonal", bean.seasonal),
                      SizedBox(height: 16),
                      _buildBooleanRow("Kosher", bean.kosher),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal[600],
          ),
        ),
        SizedBox(height: 8),
        Text(
          detail,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildBooleanRow(String title, bool value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal[600],
          ),
        ),
        SizedBox(height: 8),
        Text(
          value ? 'Yes' : 'No',
          style: TextStyle(
            fontSize: 16,
            color: value ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
