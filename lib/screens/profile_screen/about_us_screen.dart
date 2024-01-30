import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "About Us",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Shop App!',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'At Shop App, we are passionate about providing an exceptional online shopping experience. Our mission is to offer a diverse range of high-quality products while ensuring a seamless and secure shopping journey for our customers.',
                style: TextStyle(fontSize: 16.sp),
              ),
              const SizedBox(height: 16),
              Text(
                'Key Highlights:',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildHighlight(
                '1. Extensive Product Selection:',
                'Discover a wide array of products ranging from electronics to fashion, curated to meet your diverse needs.',
              ),
              _buildHighlight(
                '2. User-Friendly Interface:',
                'Our app features an intuitive and user-friendly design, making your shopping experience enjoyable and hassle-free.',
              ),
              _buildHighlight(
                '3. Secure Shopping Environment:',
                'We prioritize the security of your data and transactions, implementing robust measures to protect your privacy.',
              ),
              _buildHighlight(
                '4. Exceptional Customer Support:',
                'Our dedicated support team is ready to assist you with any inquiries or concerns, ensuring a positive and satisfying customer experience.',
              ),
              const SizedBox(height: 16),
              Text(
                'Thank you for choosing Shop App. We appreciate your trust and look forward to serving you with the best in online shopping!',
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHighlight(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(description),
        ],
      ),
    );
  }
}
