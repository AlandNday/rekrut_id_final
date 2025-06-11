import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rekrut_id_final/Models/jobdetail.dart'; // Path to your JobDetail model

class JobDetailController extends GetxController {
  // 1. We now require the jobId when creating the controller
  final _box = GetStorage();
  final RxString _currentJobId = ''.obs; // Use a private variable
  static const String _jobIdKey = 'lastViewedJobId'; // Key for storage
  @override
  void onInit() {
    super.onInit();
    // 1. Try to get the jobId from Get.arguments
    final String? idFromArguments = Get.arguments as String?;

    if (idFromArguments != null && idFromArguments.isNotEmpty) {
      // If ID is passed via arguments, use it and save it
      _currentJobId.value = idFromArguments;
      _box.write(_jobIdKey, idFromArguments); // Store in GetStorage
      print('Job ID from arguments and stored: $idFromArguments');
    } else {
      // If no ID from arguments (e.g., on refresh), try to load from storage
      final String? storedId = _box.read<String>(_jobIdKey);
      if (storedId != null && storedId.isNotEmpty) {
        _currentJobId.value = storedId;
        print('Job ID loaded from storage: $storedId');
      } else {
        // Handle case where ID is neither in arguments nor in storage
        errorMessage.value = 'No job ID found for detail screen.';
        print('Error: No job ID found.');
      }
    }

    // Only fetch if a valid ID was found
    if (_currentJobId.value.isNotEmpty) {
      fetchJobDetail(_currentJobId.value);
    }
  }

  final Rx<JobDetail?> jobDetail = Rx<JobDetail?>(
    null,
  ); // Observable for the fetched detail
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // API base URL - IMPORTANT: Use your Laravel development server IP or URL
  final String _baseUrl =
      'https://backend-rekruit-id-production.up.railway.app/api/jobs'; // Adjust as needed

  /// Fetches job details for a given job ID.
  Future<void> fetchJobDetail(String jobId) async {
    isLoading.value = true;
    errorMessage.value = '';
    jobDetail.value = null; // Clear previous detail

    try {
      final response = await http.get(Uri.parse('$_baseUrl/$jobId/detail'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Ensure the 'data' key exists and is not null
        if (responseData['data'] != null) {
          jobDetail.value = JobDetail.fromJson(responseData['data']);
        } else {
          errorMessage.value = 'API returned no data for job detail.';
          print('API returned no data for job detail: ${responseData}');
        }
      } else {
        errorMessage.value =
            'Failed to load job detail. Status code: ${response.statusCode}';
        print(
          'Failed to load job detail: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      errorMessage.value = 'An error occurred while fetching job detail: $e';
      print('Error fetching job detail: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Example of how you might use this:
  // You would call Get.put(JobDetailController()) in your binding
  // Then in your UI:
  // JobDetailController detailController = Get.find();
  // detailController.fetchJobDetail(someJobId);
  // Obx(() => detailController.isLoading.value ? CircularProgressIndicator() :
  //      detailController.jobDetail.value != null ? Text(detailController.jobDetail.value!.description) : Text(detailController.errorMessage.value))
}
