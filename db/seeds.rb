
Category.delete_all
Category.create([
  {name: "Hard Items"},
  {name: "Soft Plastic"},
  {name: "Paper"},
  {name: "Cardboard"},
  {name: "Cloth"},
  {name: "PET"},
  {name: "Sanitary"},
  {name: "Hair and Dust"},
  {name: "Burning"}
])

Location.delete_all
Location.create([
  {name: "Waste Station"},
  {name: "Compost"},
  {name: "Indian Kitchen"},
  {name: "Beach"},
  {name: "Unknown"},
  {name: "Pre-sort"},
  {name: "Paper Table"},
  {name: "Hard Items Table"},
  {name: "Soft Plastic Processing"},
  {name: "Burnables Processing"},
  {name: "Cardboard Processing"},
  {name: "Menses Processing"},
  {name: "PET Crushing"},
  {name: "Storage"},
  {name: "Downstream"}
])

Container.delete_all
Container.create([
  {name: Container::NO_CONTAINER_NAME, capacity: 0, empty_weight: 0},
  {name: '120L Red Bin', capacity: 120, empty_weight: 3.5},
  {name: '120L Blue Bin', capacity: 120, empty_weight: 3.5},
  {name: '120L Orange Bin', capacity: 120, empty_weight: 3.5},
  {name: '100L Pink Bin', capacity: 100, empty_weight: 3.5},
  {name: '60L Beige Bin', capacity: 60, empty_weight: 2}
])

Task.delete_all
Task.create([
  {name: 'Pick-Up'},
  {name: 'Pre-Sorting'},
  {name: 'Paper Sorting'},
  {name: 'Hard Items Sorting'},
  {name: 'Facilities Management'}
])