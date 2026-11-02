USE farmers_market_schema;


-- Source of the Farmers Market names: https://www.zenbusiness.com/start-a-business/agriculture/farmers-market-vendor/names.html
INSERT INTO Markets(
    market_id,  name,                           location,           operating_hours,    contact_email)
VALUES
    (1,         'Sunfield Market',              'St. Peter, MN',    '8:00AM-5:00PM',    'SunfieldMarket@gmail.com'),
    (2,         'The Produce Row',              'Shakopee, MN',     '7:00AM-5:00PM',    'TheProduceRow@gmail.com'),
    (3,         'Irongate Farm Market',         'Olivia, MN',       '8:00AM-5:00PM',    'IrongateFarmMarket@gmail.com'),
    (4,         'Millstone Market',             'Buffalo, MN',      '9:00AM-6:00PM',    'MillstoneMarket@gmail.com'),
    (5,         'The Green Crate Market',       'Mankato, MN',      '8:00AM-6:00PM',    'TheGreenCrateMarket@gmail.com'),
    (6,         'Goodfolk Market',              'Crookston, MN',    '8:00AM-7:00PM',    'GoodfolkMarket@gmail.com'),
    (7,         'Full Pantry Farmers Market',   'Benson, MN',       '8:00AM-5:00PM',    'FullPantryFarmersMarket@gmail.com'),
    (8,         'Sunstone Market Co.',          'Rochester, MN',    '6:00AM-4:00PM',    'SunstoneMarketCo@gmail.com'),
    (9,         'Trellised Market',             'Bloomington, MN',  '8:00AM-3:00PM',    'TrellisedMarket@gmail.com'),
    (10,        'Daybreak Market Co.',          'St. Paul, MN',     '10:00AM-8:00PM',   'DaybreakMarketCo@gmail.com');


INSERT INTO Vendors(
    vendor_id,  business_name,                      owner_name,         phone,          email)
VALUES  
    (1,         'Honey \'N\' Stuff',                'Jack Richards',    '5073458079',   'HoneyStuff@gmail.com'),
    (2,         'Jason\'s Barbeque',                'Jason Booker',     '5073473469',   'JasonBarbeque@gmail.com'),
    (3,         'Handmade Pens for Friends',        'Ford Swanson',     '9521230896',   'PensForFriends@gmail.com'),
    (4,         'Bright Dairy Farm',                'Andy James',       '9522367948',   'BrightDairyFarm@gmail.com'),
    (5,         'Authentic Antiques',               'Beth Hunt',        '3201236495',   'AuthenticAntiques@gmail.com'),
    (6,         'Auntie Anne\'s',                   'Anne Dorsey',      '3201027447',   'Auntie Anne\'s.com'),
    (7,         'Bob\'s Tools',                     'Bob Klein',        '7631467345',   'BobTools@gmail.com'),
    (8,         'Always Fresh',                     'Drew Young',       '7631234097',   'AlwaysFresh@gmail.com'),
    (9,         'Everything Potatoes',              'Mya Zhang',        '5071238904',   'EverythingPotatoes@gmail.com'),
    (10,        'Harold\s Hot Sauces',              'Harold Gaines',    '5071234769',   'HaroldHotSauces@gmail.com'),
    (11,        'Steve\'s Greens',                  'Steve Smith',      '2186534109',   'Steve\'sGreens@gmail.com'),
    (12,        'Chicken Chicken',                  'Nevaeh Trejo',     '2182317805',   'ChickenChicken@gmail.com'),
    (13,        'Arts & Hearts',                    'Jill Ashley',      '3201967089',   'Arts&Hearts@gmail.com'),
    (14,        'Autumn Lake Farm',                 'Lena Xu',          '3201768903',   'AutumnLakeFarm@gmail.com'),
    (15,        'Mankato\'s Freshest',              'Juana Pierre',     '5072168907',   'Mankato\'sFreshest@gmail.com'),
    (16,        'Open Valley Orchard',              'Mohammed Jackson', '5071679811',   'OpenValleyOrchard@gmail.com'),
    (17,        'New Spring Acres',                 'Kelvin Schmitt',   '9521780674',   'NewSpringAcres@gmail.com'),
    (18,        'Jerry\'s Chairs',                  'Jerry Banks',      '9521708957',   'Jerry\'sChairs@gmail.com'),
    (19,        'Fine Wine Time',                   'Arnold Weiss',     '6511272863',   'FineWineTime@gmail.com'),
    (20,        'Judy\'s All American Butchery',    'Judy Washington',  '6512364870',   'Judy\'sAllAmericanButchery@gmail.com');
    

INSERT INTO Products (
    product_id, vendor_id,  name,                                   description,                                                                price,  stock_quantity, category)
VALUE
    (1,         1,          'Raw Wildflower Honey',                 'Locally harvested raw wildflower honey with a natural floral flavor.',     12.00,  35,             'Honey & Bee Products'),
    (2,         1,          'Beeswax Candles',                      'Hand-poured beeswax candles that provide a natural, warm glow.',           10.00,  20,             'Honey & Bee Products'),
    (3,         1,          'Beeswax Lip Balm',                     'Moisturizing lip balm made with natural beeswax.',                         5.00,   40,             'Honey & Bee Products'),

    (4,         2,          'Jason\'s Special Barbeque Rub',        'A signature blend of seasonings for grilling and smoking meats.',          8.00,   30,             'Seasonings & Spices'),
    (5,         2,          'Smoked Pork Ribs',                     'Slow-smoked pork ribs seasoned with a house-made barbecue blend.',         18.00,  12,             'Prepared Foods'),
    (6,         2,          'Pulled Pork Sandwiches',               'Tender slow-cooked pulled pork served on a fresh sandwich bun.',           9.00,   20,             'Prepared Foods'),

    (7,         3,          'Custom Ballpoint Pen',                 'Personalized ballpoint pen available with custom lettering.',              6.00,   25,             'Handcrafted Gifts'),
    (8,         3,          'Custom Engraved Wooden Ballpoint Pen', 'Handcrafted wooden ballpoint pen featuring custom engraving.',             18.00,  15,             'Handcrafted Gifts'),

    (9,         4,          'Fresh Pasteurized Milk',               'Fresh pasteurized milk from a local dairy producer.',                      5.00,   30,             'Dairy Products'),
    (10,        4,          'Assorted Cheese Curds',                'Fresh cheese curds available in a variety of flavors.',                    7.00,   25,             'Dairy Products'),
    (11,        4,          'String Cheese',                        'Individually portioned string cheese made from quality dairy.',            5.00,   30,             'Dairy Products'),
    (12,        4,          'Deep Fried Cheese On A Stick',         'Golden deep-fried cheese served on a stick.',                              7.00,   20,             'Prepared Foods'),

    (13,        5,          'Antique Lamps',                        'Vintage decorative lamps with classic antique styling.',                   45.00,  5,              'Antiques & Collectibles'),
    (14,        5,          'Antique Cutlery',                      'Vintage cutlery pieces suitable for collecting or display.',               25.00,  10,             'Antiques & Collectibles'),

    (15,        6,          'Sea Salted Pretzels',                  'Freshly baked pretzels topped with coarse sea salt.',                      4.00,   35,             'Baked Goods & Snacks'),
    (16,        6,          'Antie\'s Special Corn Dogs',           'Classic corn dogs featuring a crispy golden coating.',                     6.00,   25,             'Prepared Foods'),
    (17,        6,          'Antie\'s Special Pancakes',            'Freshly prepared fluffy pancakes served hot.',                             7.00,   20,             'Prepared Foods'),

    (18,        7,          'Drill Bits',                           'Assorted drill bits designed for common household and workshop projects.', 12.00,  15,             'Tools & Hardware'),
    (19,        7,          'Saws',                                 'Durable hand saws for woodworking and general cutting projects.',          22.00,  10,             'Tools & Hardware'),
    (20,        7,          'Power Drills',                         'Cordless power drills suitable for home improvement and workshop use.',    65.00,  8,              'Tools & Hardware'),

    (21,        8,          'Freshly Squeezed Orange Juice',        'Freshly squeezed orange juice made from ripe oranges.',                    6.00,   25,             'Beverages'),
    (22,        8,          'Freshly Squeezed Lemonade ',           'Refreshing freshly squeezed lemonade with a sweet citrus flavor.',         5.00,   25,             'Beverages'),
    (23,        8,          'Green Juice',                          'Fresh vegetable and fruit juice blended for a refreshing drink.',          7.00,   20,             'Beverages'),

    (24,        9,          'Garlic Hashbrowns',                    'Crispy shredded potatoes seasoned with garlic and herbs.',                 6.00,   20,             'Prepared Foods'),
    (25,        9,          'Potato Pizza',                         'Savory pizza topped with seasoned potatoes and melted cheese.',            12.00,  12,             'Prepared Foods'),
    (26,        9,          'Spicy Mashed Potatoes',                'Creamy mashed potatoes prepared with a spicy seasoning blend.',            6.00,   20,             'Prepared Foods'),

    (27,        10,         'Ghost Pepper Fire Sauce',              'Extra-hot pepper sauce made with ghost peppers for serious heat.',         9.00,   20,             'Sauces & Condiments'),
    (28,        10,         'Mango Habanero Glaze',                 'Sweet mango glaze balanced with the heat of habanero peppers.',            8.00,   25,             'Sauces & Condiments'),
    (29,        10,         'Harold\'s Special Mouth Melter',       'A signature extra-spicy sauce created for adventurous hot sauce lovers.',  10.00,  15,             'Sauces & Condiments'),

    (30,        11,         'Organic Salad Mix',                    'Fresh organic mixed salad greens ready to wash and serve.',                6.00,   30,             'Fresh Produce'),

    (31,        12,         'Spicy Wings',                          'Chicken wings coated in a flavorful spicy seasoning and sauce.',           12.00,  20,             'Prepared Foods'),
    (32,        12,         'Fried Chicken Tenders',                'Tender chicken strips coated in seasoned breading and fried until golden.', 9.00,  25,             'Prepared Foods'),

    (33,        13,         'Handmade Plant Pots',                  'Handcrafted decorative plant pots suitable for indoor and outdoor use.',   15.00,  12,             'Handmade Crafts'),
    (34,        13,         'Handmade Bird Houses',                 'Handcrafted wooden bird houses designed for backyard birds.',              25.00,  10,             'Handmade Crafts'),

    (35,        14,         'Fresh Mayple Syrup',                   'Pure maple syrup collected and prepared from locally harvested maple sap.', 14.00, 20,             'Maple Products'),
    (36,        14,         'Maple Syrup Chocolate',                'Chocolate-flavored maple syrup combining rich cocoa and maple sweetness.', 10.00,  15,             'Maple Products'),

    (37,        15,         'Fresh Free-Range Eggs',                'Fresh eggs from free-range hens, available by the dozen.',                 6.00,   30,             'Farm Fresh Eggs'),
    (38,        15,         'Organic Sweet Corn',                   'Fresh organic sweet corn harvested for seasonal enjoyment.',               1.00,   100,            'Fresh Produce'),

    (39,        16,         'Fresh Honey Crisp Apples',             'Crisp, sweet Honeycrisp apples freshly harvested from the orchard.',       2.00,   50,             'Fresh Produce'),
    (40,        16,         'Apple Sauce',                          'Homemade applesauce prepared with fresh apples.',                          5.00,   20,             'Preserved Foods'),

    (41,        17,         'Flower Fertilizer',                    'Nutrient-rich fertilizer formulated to support healthy flower growth.',    12.00,  15,             'Gardening Supplies'),
    (42,        17,         'Starter Seed Kit',                     'Beginner-friendly seed kit containing supplies to start growing plants.',  15.00,  20,             'Gardening Supplies'),
    (43,        17,         'Flower Pots',                          'Decorative flower pots suitable for planting flowers and small plants.',   8.00,   25,             'Gardening Supplies'),

    (44,        18,         'Oak Dining-Room Chair',                'Solid oak dining chair featuring a traditional wooden design.',            125.00, 4,              'Furniture'),
    (45,        18,         'Cedar Porch Chair',                    'Handcrafted cedar porch chair designed for comfortable outdoor seating.',  95.00,  5,              'Furniture'),

    (46,        19,         'Chardonnay',                           'A crisp white Chardonnay with a smooth finish.',                           18.00,  15,             'Wine & Beverages'),
    (47,        19,         'Apple Wine',                           'Fruit wine made from locally harvested apples.',                           16.00,  12,             'Wine & Beverages'),
    (48,        19,         'Cork Coaster',                         'Decorative coaster made from natural cork to protect tabletops.',          4.00,   30,             'Handcrafted Gifts'),

    (49,        20,         'Prime Ribeye Steaks',                  'Premium ribeye steaks with rich marbling and excellent flavor.',           22.00,  15,             'Meat & Poultry'),
    (50,        20,         'Beef Jerky',                           'Seasoned beef jerky prepared for a savory, protein-rich snack.',           9.00,   25,             'Meat & Poultry');
    

INSERT INTO Market_Stalls (
        stall_id,   market_id,  vendor_id,  stall_number)
VALUES 
        (1,         1,          1,          0001),
        (2,         1,          2,          0002),
        (3,         2,          3,          0001),
        (4,         2,          4,          0002),
        (5,         3,          5,          0001),
        (6,         3,          6,          0002),
        (7,         4,          7,          0001),
        (8,         4,          8,          0002),
        (9,         5,          9,          0001),
        (10,        5,          10,         0002),
        (11,        6,          11,         0001),
        (12,        6,          12,         0002),
        (13,        7,          13,         0001),
        (14,        7,          14,         0002),
        (15,        8,          15,         0001),
        (16,        8,          16,         0002),
        (17,        9,          17,         0001),
        (18,        9,          18,         0002),
        (19,        10,         19,         0001),
        (20,        10,         20,         0002);


INSERT INTO Orders (
    order_id,   order_date,             customer_name,      customer_email,             status,             total_amount)
VALUES 
    (1,         '2026-11-29 22:00:25',  'Alex Smith',       'AlexSmith@gemail.com',     'Prepared',         16.00),
    (2,         '2026-11-30 22:00:25',  'Alex Smith',       'AlexSmith@gemail.com',     'Pending',          18.00),
    (3,         '2026-12-30 15:30:00',  'John Jackson',     'JohnJackson@gemail.com',   'Prepared',         8.00),
    (4,         '2026-12-30 22:00:25',  'Alex Smith',       'AlexSmith@gemail.com',     'Pending',          12.00),
    (5,         '2026-11-05 21:05:50',  'Jacob Renold',     'JacobRenold@gemail.com',   'Cancelled',        95.00),
    (6,         '2026-10-31 01:55:10',  'Kattie Daniel',    'KattieDaniel@gemail.com',  'Completed',        25.00),
    (7,         '2026-11-09 07:25:00',  'Stella Brooks',    'StellaBrooks@gemail.com',  'Ready for Pickup', 6.00),
    (8,         '2026-11-09 08:25:00',  'Stella Brooks',    'StellaBrooks@gemail.com',  'Ready for Pickup', 18.00);


INSERT INTO Order_Items (
    item_id,    order_id,   product_id, quantity,   price_at_purchase)
VALUES
    (1,         1,          4,          2,          8.00),
    (2,         2,          7,          3,          6.00),
    (3,         3,          4,          1,          8.00),
    (4,         4,          1,          1,          12.00),
    (5,         5,          45,         1,          95.00),
    (6,         6,          9,          5,          5.00),
    (7,         7,          26,         1,          6.00),
    (8,         8,          5,          1,          18.00);


