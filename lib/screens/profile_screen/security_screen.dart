import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          "Security",
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
                'Security Measures for QuickBuy Store',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'At QuickBuy Store, we prioritize the security and privacy of your information. We have implemented robust security measures to ensure a safe and secure shopping experience for all our users.',
                style: TextStyle(fontSize: 16.sp),
              ),
              const SizedBox(height: 16),
              Text(
                'Key Security Features:',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildSecurityFeature(
                '1. Secure Connection:',
                'We use industry-standard encryption protocols to secure the communication between your device and our servers, ensuring that your data remains confidential.',
              ),
              _buildSecurityFeature(
                '2. Account Protection:',
                'Your QuickBuy Store account is protected by advanced authentication mechanisms, including password policies and multi-factor authentication, to prevent unauthorized access.',
              ),
              _buildSecurityFeature(
                '3. Payment Security:',
                'Our payment gateway is secure and compliant with industry standards. All financial transactions are encrypted and processed securely, safeguarding your payment information.',
              ),
              _buildSecurityFeature(
                '4. Data Integrity:',
                'We employ measures to ensure the integrity of your data, preventing unauthorized modifications or tampering.',
              ),
              _buildSecurityFeature(
                '5. Regular Audits and Monitoring:',
                'Our security systems undergo regular audits and continuous monitoring to identify and address potential vulnerabilities proactively.',
              ),
              const SizedBox(height: 16),
              Text(
                'Your trust and security are of utmost importance to us. If you have any security-related concerns or questions, please contact our support team.',
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityFeature(
    String title,
    String description,
  ) {
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
