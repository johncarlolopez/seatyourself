# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Restaurant.create(name: "The Keg", address: "515 Jarvis St", city: "Toronto", price_range: "4", summary: "Classic steak & seafood dishes are the mainstays at this stylish yet casual chain restaurant.", menu: "SIRLOIN OSCAR, STEAK & CRAB, STEAK & CAJUN SHRIMP, STEAK & LOBSTER")
Restaurant.create(name: "State and Main", address: "396 The East Mall", city: "Etobicoke", price_range: "3", summary: "We're at the crossroads of your neighborhood, a place to gather, eat and drink. Where friends and family can catch up, unwind and celebrate while enjoying a food and bar offering that delivers classic hand-crafted favourites with an emphasis on quality, taste and choice.", menu: "LONG BEACH FISH TACOS, FRIED CHICKEN TENDERS, CHICKEN ENCHILADAS, FISH & CHIPS, THE EMPIRE STATE")
Restaurant.create(name: "Frankie Tomatto's", address: "7225 Woodbine Ave", city: "Markham", price_range: "2", summary: "Italian buffet, what more could you want? Another meatball?", menu: "SPEGGHETTI AND MEATBALLS, GARLIC BREAD, LASAUGNA, PIZZA, SEAFOOD, SALADS")
Restaurant.create(name: "Applebee's", address: "5700 Mavis Rd", city: "Mississauga", price_range: "3", summary: "Full-service chain bar & grill providing hearty American eats in an informal setting", menu: "BBQ PORK BACK RIBS, MAPLE GLAZED SALMON, CHICKEN TENDER PLATTER, DOUBLE CRUNCH SHRIMP")
