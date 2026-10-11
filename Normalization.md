# How the database design achieves Third normal form for the core tables

## Normal form definitions 1-3
1.	First normal form (1 NF): every attribute type of a relation must be atomic and single-valued.
2.	Second normal form (2 NF): satisfies 1NF and every non-prime attribute type A in R is fully functionally dependent on any key of R.
3.	Third normal form (3 NF): satisfies 2NF and no non-prime attribute type of R is transitively dependent on the primary key.

## Explanation for (1-3 NF) for the core tables
All six tables use atomic and single-valued attribute types, which satisfies (1 NF), and all the primary keys for the tables are single columned, meaning every non-prime attribute is fully functionally dependent on the primary key, which satisfies (2 NF).

### Four core tables
* **Markets Table:** All four of the non-key attributes (name, location, operating_hours, and contact_email) depend only on the primary key (market_id), meaning there’s no transitive dependance.
  
* **Vendors Table:** All four of the non-key attributes (business_name, owner_name, phone, and email) depend only on the primary key (vendor_id), meaning there’s no transitive dependance.
  
* **Products Table:** All five of the non-key attributes (name, description, price, stock_quantity, and catagory) depend only on the primary key (product_id, and vendor_id links the data to the Vendors table, but none of the attributes in the Products table reference data related to the Vendors table, so there’s no transitive dependance.

* **Orders Table:** All five of the non-key attributes (order_date, customer_name, customer_email, status, total_amount) depend only on the primary key (order_id), meaning there’s no transitive dependance.

