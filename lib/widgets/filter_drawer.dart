import 'package:fitspace_sports_venue_booking_mobile/utils/colors.dart';
import 'package:flutter/material.dart';
import '../models/filter_drawer_model.dart';

class FilterDrawer extends StatefulWidget {
  final Function(FilterOptions) onFilterApplied;
  final Function() onReset;

  const FilterDrawer({super.key, required this.onFilterApplied, required this.onReset});

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();

  String? ratingSort;
  String? nameSort;

  bool? _onChoosedRatingAsc;
  bool? _onChoosedNameAsc;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.base,
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
                            decoration: const InputDecoration(
                              labelText: 'Min',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          '-',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: maxPriceController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
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
                              _onChoosedRatingAsc = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _onChoosedRatingAsc == null ? Colors.white60 : (_onChoosedRatingAsc! ? Colors.white10 : Colors.white60),
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
                              _onChoosedRatingAsc = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _onChoosedRatingAsc == null ? Colors.white60 : (_onChoosedRatingAsc! ? Colors.white60 : Colors.white10),
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
                              _onChoosedNameAsc = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _onChoosedNameAsc == null ? Colors.white60 : (_onChoosedNameAsc! ? Colors.white10 : Colors.white60),
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
                              _onChoosedNameAsc = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _onChoosedNameAsc == null ? Colors.white60 : (_onChoosedNameAsc! ? Colors.white60 : Colors.white10),
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
                          widget.onReset();
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

    print('min: $minPrice, max: $maxPrice, rat: $ratingSort, nam: $nameSort');

    widget.onFilterApplied(FilterOptions(
      minPrice: minPrice,
      maxPrice: maxPrice,
      ratingSort: ratingSort,
      nameSort: nameSort,
    ));
  }
}
