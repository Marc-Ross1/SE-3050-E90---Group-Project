# SE-3050-E90-Group-Project

## Project Members
Fatma Abdulahi

Marcus Rossing

Stacy Bruch

Zachary Wright


## [GitHub Projects Board](https://github.com/users/Marc-Ross1/projects/1/views/2)
<img width="1488" height="908" alt="image" src="https://github.com/user-attachments/assets/a69607da-e4f4-489d-8b04-81c7da39808b" />



# Farmers Market & Vendor Management System

## 1. Project Overview
This web platform helps local farmers' markets manage operations and connect with customers. The application serves as a directory for physical markets, allows independent vendors to host digital storefronts with live inventories, and enables customers to place pre-orders for market pickup.

---

## 2. Core Application Features

### Market Directory & Logistics
* **Market Registry:** Tracks physical market locations, seasonal operation dates, and opening/closing hours.
* **Stall Assignments:** Mandates organizers to assign specific booth or stall numbers to verified vendors for each market day.

### Vendor Storefronts
* **Vendor Profiles:** Storefront pages displaying business descriptions, contact info, owner names, and social links.
* **Multi-Market Support:** Allows a vendor to sell products across multiple physical market locations concurrently without duplicating profiles.

### Product & Inventory Catalog
* **Product Categories:** Organizes items by standard types such as Produce, Baked Goods, Dairy, and Crafts.
* **Live Inventory:** Tracks stock quantities in real time to prevent the purchase of out-of-stock items.
* **Pricing Metrics:** Supports various selling metrics such as unit pricing, weight metrics, or bundled package rates.

### Orders & Pre-Ordering
* **Combined Checkout:** Allows customers to bundle items from multiple distinct vendors into a single shopping basket and check out all at once.
* **Order Tracking:** Tracks order workflow status from generation to fulfillment (Pending, Prepared, Ready for Pickup, Completed, Cancelled).
* **Price History Protection:** Logs the precise historical price of an item at the moment of purchase to preserve financial ledger accuracy regardless of future product updates.

---

## 3. Core Users
* **Market Organizers:** Require dashboards to approve vendors, assign layout stall maps, and generate global sales reports.
* **Vendors:** Require interfaces to adjust daily inventory levels, monitor incoming orders, and flag items as ready for pickup.
* **Customers:** Require interfaces to discover nearby markets, verify item availability, and place pre-orders.

---

## 4. Database Rules & Relational Scope
1. Every individual line-item order must map back to a valid, active product listing.
2. Every product listing must belong to an authenticated, verified vendor profile.
3. Vendors are assigned to specific stalls within a market.

---

## 5. Database Schema Blueprint

### Core Entity Tables

#### MARKETS
* `market_id` (int, PK): Unique identifier for the market location.
* `name` (string, NOT NULL): The public name of the market.
* `location` (string, NOT NULL): The physical address of the venue.
* `operating_hours` (string): The active operating schedule window.
* `contact_email` (string): Contact address for the managing organizer.

#### VENDORS
* `vendor_id` (int, PK): Unique identifier for the business entity.
* `business_name` (string, NOT NULL): The commercial or farm name.
* `owner_name` (string): Operator point of contact name.
* `phone` (string): Primary commercial phone number.
* `email` (string): Registered authentication email address.

#### PRODUCTS
* `product_id` (int, PK): Unique identifier for the product.
* `vendor_id` (int, FK referencing VENDORS.vendor_id): Establishes account ownership.
* `name` (string, NOT NULL): Public description name of the item.
* `description` (string): Detailed overview of ingredients, origins, or processes.
* `price` (decimal, NOT NULL): Active storefront price calculation point.
* `stock_quantity` (int): Remaining real-time volume in inventory.
* `category` (string): Data taxonomy category.

#### ORDERS
* `order_id` (int, PK): Unique identifier for the transaction invoice.
* `order_date` (datetime): Timestamp registering when the purchase occurred.
* `customer_name` (string, NOT NULL): Pickup customer identity.
* `customer_email` (string): Contact email for order confirmations.
* `status` (string): Current workflow point.
* `total_amount` (decimal): Combined financial summary of all inner elements.

### Relationship & Intersection Tables

#### MARKET_STALLS
* `stall_id` (int, PK): Unique identifier for the assignment entry.
* `market_id` (int, FK referencing MARKETS.market_id): Target market venue.
* `vendor_id` (int, FK referencing VENDORS.vendor_id): Assigned merchant entity.
* `stall_number` (string, NOT NULL): Designated booth identification tag.

#### ORDER_ITEMS
* `item_id` (int, PK): Distinct line-item record row tracker.
* `order_id` (int, FK referencing ORDERS.order_id): Parent invoice receipt container.
* `product_id` (int, FK referencing PRODUCTS.product_id): Inventory asset purchased.
* `quantity` (int, NOT NULL): Number of units purchased.
* `price_at_purchase` (decimal, NOT NULL): The snapshot price at checkout.


