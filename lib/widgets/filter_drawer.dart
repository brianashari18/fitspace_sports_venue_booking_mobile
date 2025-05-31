import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:flutter/material.dart';
import '../models/filter_drawer_model.dart';

class FilterDrawer extends StatefulWidget {
  final Function(FilterOptions) onFilterApplied;

  const FilterDrawer({super.key, required this.onFilterApplied});

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();

  String? ratingSort = 'Ascending';
  String? nameSort = 'Ascending';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const DrawerHeader(
              child: Center(
                child: Image(
                  image: AssetImage('assets/icons/fitspace.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Range Price
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Range Price (Rp)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: minPriceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Min',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '-',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: maxPriceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Max',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Rating Sort
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rating',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            ratingSort = 'Ascending';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white54,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                            'Ascending',
                            style: TextStyle(
                                color: AppColors.darkGrey
                            )
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            ratingSort = 'Descending';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white54,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                            'Descending',
                            style: TextStyle(
                                color: AppColors.darkGrey
                            )
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Name Sort
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sort by Name',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            nameSort = 'Ascending';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white54,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                            'Ascending',
                            style: TextStyle(
                                color: AppColors.darkGrey
                            )
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            nameSort = 'Descending';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white54,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                            'Descending',
                            style: TextStyle(
                                color: AppColors.darkGrey
                            )
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        minPriceController.clear();
                        maxPriceController.clear();
                        setState(() {
                          ratingSort = 'Ascending';
                          nameSort = 'Ascending';
                        });
                        widget.onFilterApplied(FilterOptions());
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                            color: AppColors.darkerPrimaryColor
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _applyFilter,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkerPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                          'Filter',
                          style: TextStyle(
                              color: AppColors.base
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyFilter() {
    double? minPrice = minPriceController.text.isNotEmpty
        ? double.tryParse(minPriceController.text)
        : null;
    double? maxPrice = maxPriceController.text.isNotEmpty
        ? double.tryParse(maxPriceController.text)
        : null;

    widget.onFilterApplied(FilterOptions(
      minPrice: minPrice,
      maxPrice: maxPrice,
      ratingSort: ratingSort,
      nameSort: nameSort,
    ));
  }
}
