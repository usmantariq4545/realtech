import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../reuseable widget/text_constraint.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class CalculationScreen extends StatefulWidget {
  const CalculationScreen({Key? key}) : super(key: key);

  @override
  State<CalculationScreen> createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  bool showPredictedPrice =
      false; // Initially, the predicted price is not shown

  late Interpreter? interpreter;
  // declaration for later initialization
  late List<String> locations;
  late List<String> propertyTypes;
  late String selectedLocation;
  late String selectedPropertyType;
  late TextEditingController areaSqftController;
  late TextEditingController bedroomsController;
  late TextEditingController bathsController;
  late double predictedPrice;

  @override
  void initState() {
    super.initState();
    loadModel();
    // Initialization
    areaSqftController = TextEditingController();
    bedroomsController = TextEditingController();
    bathsController = TextEditingController();
    locations = [
      'Clifton',
      'DHA Defence',
      'Federal B Area',
      'Gadap Town',
      'Gulistan-e-Jauhar',
      'Gulshan-e-Iqbal Town',
      'KDA Scheme 1',
      'Korangi',
      'Naya Nazimabad',
      'North Karachi',
      'North Nazimabad',
      'Scheme 33'
    ];
    propertyTypes = ['Flat', 'House'];
    // initial selected values
    selectedLocation = locations[2];
    selectedPropertyType = propertyTypes.first;
    predictedPrice = 0.0;
  }

  Future<void> loadModel() async {
    try {
      final interpreterOptions = InterpreterOptions();
      interpreter = await Interpreter.fromAsset(
          'asset/model/trainer_model.tflite',
          options: interpreterOptions);
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  Future<List<double>> runInference(double sqft, int bedrooms, int baths,
      String location, String propertyType) async {
    if (interpreter == null) {
      print('Model not loaded!');
      return [];
    }
    // One-hot encode location and property type
    List<double> encodedLocation = List.filled(locations.length, 0.0);
    encodedLocation[locations.indexOf(location)] = 1.0;
    List<double> encodedPropertyType = List.filled(propertyTypes.length, 0.0);
    encodedPropertyType[propertyTypes.indexOf(propertyType)] = 1.0;

    // Prepare input data
    List<double> inputData = [
      sqft.toDouble(),
      bedrooms.toDouble(),
      baths.toDouble()
    ];
    inputData.addAll(encodedLocation);
    inputData.addAll(encodedPropertyType);
    // Perform inference
    try {
      final output = List.filled(1, [0.0]); // Placeholder for output
      interpreter!.run([Float64List.fromList(inputData)], output);
      return output[0];
    } catch (e) {
      print('Failed to run inference: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScope is used to handle keyboard-related interactions
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_sharp,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PText(
                        'Price Calculation',
                        fontSize: 28.0,
                        weight: FontWeight.w500,
                      ),
                      PText('Fill the details below',
                          fontSize: 20.0, color: Colors.grey),
                      SizedBox(
                        height: 50,
                      ),
                      PText(
                        'Type',
                        fontSize: 18.0,
                        weight: FontWeight.w500,
                      ),
                      DropdownButtonFormField<String>(
                        value: selectedPropertyType,
                        onChanged: (String? value) {
                          setState(() {
                            selectedPropertyType = value!;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Border radius set to zero
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        items: propertyTypes.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      PText(
                        'No. of Bedroom',
                        fontSize: 18.0,
                        weight: FontWeight.w500,
                      ),
                      TextField(
                        controller: bedroomsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFEAEAEA),
                          hintText: '1,2',
                          hintStyle:
                              TextStyle(fontSize: 16.0, letterSpacing: 2),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      PText(
                        'No. of Bathroom',
                        fontSize: 18.0,
                        weight: FontWeight.w500,
                      ),
                      TextField(
                        controller: bathsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFEAEAEA),
                          hintText: '1,2',
                          hintStyle:
                              TextStyle(fontSize: 16.0, letterSpacing: 2),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      PText(
                        'Area in Sq/ft',
                        fontSize: 18.0,
                        weight: FontWeight.w500,
                      ),
                      TextField(
                        controller: areaSqftController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFEAEAEA),
                          hintText: '100',
                          hintStyle:
                              TextStyle(fontSize: 16.0, letterSpacing: 2),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      PText(
                        'Location',
                        fontSize: 18.0,
                        weight: FontWeight.w500,
                      ),
                      DropdownButtonFormField<String>(
                        value: selectedLocation,
                        onChanged: (String? value) {
                          setState(() {
                            selectedLocation = value!;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Border radius set to zero
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        items: locations.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Visibility(
                        visible:
                            showPredictedPrice, // Control visibility based on the boolean variable

                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.67),
                              borderRadius: BorderRadius.circular(30)),
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: PText(
                                  '${predictedPrice.toStringAsFixed(2)} PKR', // Display predicted price here
                                  weight: FontWeight.w400,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color(0xff2e7b5b), // Button background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8.0), // Set the border radius
                            ),
                          ),
                          onPressed: () async {
                            try {
                              final sqft = areaSqftController.text.isEmpty
                                  ? 1900.0
                                  : double.parse(areaSqftController.text);
                              final bedrooms = bedroomsController.text.isEmpty
                                  ? 4
                                  : int.parse(bedroomsController.text);
                              final baths = bathsController.text.isEmpty
                                  ? 3
                                  : int.parse(bathsController.text);
                              print(
                                  'Input data: $baths, $sqft, $bedrooms, $selectedLocation, $selectedPropertyType');

                              // Call runInference with validated input
                              List<double> output = await runInference(
                                  sqft,
                                  bedrooms,
                                  baths,
                                  selectedLocation,
                                  selectedPropertyType);
                              // Store the predicted price in the state
                              setState(() {
                                showPredictedPrice =
                                    true; // Set the boolean variable to true to show the predicted price
                                predictedPrice = output[
                                    0]; // Assuming the predicted price is stored in the first element of the output list
                              });
                              print(
                                  'Input data: $baths, $sqft, $bedrooms, $selectedLocation, $selectedPropertyType');

                              print('Predicted price: $output');
                            } catch (e) {
                              print('Error parsing input: $e');
                              // Handle error, such as displaying an error message to the user
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                            child: PText('Calculate',
                                fontSize: 22, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}