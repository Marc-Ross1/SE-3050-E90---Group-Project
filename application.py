# Written by Marcus Rossing

import os
import tkinter as tk
from tkinter import messagebox, ttk
from dotenv import load_dotenv
import pymysql
import time
from datetime import datetime

# Loads all the variables from the .env file into the environment variables so that the database login credentials can be accessed securely without hardcoding them into the code
load_dotenv()

DB_HOST= os.getenv('DB_HOST')
DB_PORT= os.getenv('DB_PORT')
DB_USERNAME= os.getenv('DB_USERNAME')
DB_PASSWORD= os.getenv('DB_PASSWORD')
DB_DATABASE= os.getenv('DB_DATABASE')



# Reusable function to run a query that returns results of the query
def run_query(query, params=None):
    try: 
        
        connection = pymysql.connect(
            host=DB_HOST,
            port=int(DB_PORT),
            user=DB_USERNAME,
            password=DB_PASSWORD,
            database=DB_DATABASE
        )

        with connection.cursor() as cursor:
            cursor.execute(query, params)
            result = cursor.fetchall()


        connection.close()
        return result

    except Exception as e:
        print(f"Error connecting to the database: {e} \n Please check your database connection settings in the .env file, and reload the application.")
        return None


# --- Market Display Functions ---
## Clears the treeview and disables the clear button
selected_item = None  # Global variable to store the selected item
selected_table = None  # Global variable to store the selected table
results_frame = None  # Global variable to store the selected frame
selected_tree = None  # Global variable to store the selected treeview

def clear_results():
    global selected_item, selected_table, results_frame, selected_tree

    if results_frame:
        results_frame.destroy()
        results_frame = None


    button_selected.config(state=tk.DISABLED) 
    button_selected.pack_forget()  # Hide the button when clearing results
    button_selected_product.config(state=tk.DISABLED) 
    button_selected_product.pack_forget()  # Hide the button when clearing results

    button_clear_results.config(state=tk.DISABLED)
    selected_item = None  # Reset the selected item when clearing results
    selected_table = None  # Reset the selected table when clearing results



## Returns and displays the markets from the database
display_cache = None  # Cache to store the markets data
select_vendor_cache = {}  
search_products_cache = {}

last_cached_markets = 0  # Timestamp of the last time the function was called
def display_markets():
    clear_results()  # Clear previous results before displaying new ones
    global results_frame, display_cache, selected_table, selected_tree, last_cached_markets

    if time.time() - last_cached_markets > 60 * 5:  # If more than 5 minutes have passed since the last call, clear the cache
        last_cached_markets = time.time()  # Update the timestamp of the last call
        display_cache = None  # Clear the display cache
   
    button_clear_results.pack_forget()
    button_selected.pack(side=tk.LEFT, padx=(0, 20))
    button_clear_results.pack(side=tk.LEFT, padx=(0, 20))

    button_selected.config(state=tk.NORMAL)  
    button_clear_results.config(state=tk.NORMAL)   

    results_frame = tk.Frame(root)
    results_frame.pack(anchor=tk.E, fill=tk.X)

    columns = ("Market Name", "Location", "Operating Hours", "Contact Email")
    tree = ttk.Treeview(results_frame, columns=columns, show="headings")

    for col in columns:
        tree.heading(col, text=col)
        tree.column(col, width=150)
     
    
    if display_cache is None:
        query = """ 
                SELECT market_id, name, location, operating_hours, contact_email 
                FROM Markets 
                ORDER BY name
            """
        markets = run_query(query)
        if markets is None:
            messagebox.showerror("Database Error", "Could not retrieve markets from the database.")
            return
        display_cache = markets  # Store the markets data in the cache
        last_cached_markets = time.time() 
    markets = display_cache  # Use the cached data
    
    selected_table = "markets"  # Set the selected table to "markets"
    selected_tree = tree  # Store the selected treeview

    


    for market in markets:
        
        tree.insert("", "end", values=market[1:], iid=str(market[0]))

    tree.pack(pady=20, padx=20, fill=tk.BOTH, expand=True)    

## 
def get_selected_market():
    global results_frame, selected_item, selected_table, selected_tree

    if selected_table is None:
        messagebox.showwarning("No Table Selected", "Please display a table before selecting an item.")
        return None
    
    selected_item = selected_tree.selection()
    if not selected_item:
        messagebox.showwarning("No Selection", "Please select a market from the list.")
        return None

    market_id = selected_item[0]
    market_values = selected_tree.item(selected_item, "values")

    if results_frame:
        results_frame.destroy()
        results_frame = None

    if selected_table == "markets":
        select_market(market_id, market_values)


def max_height(height):
    if height > 5:
        return 5 
    return height

last_cached_vendors = 0
def select_market(market_id, market_values):
    button_selected.config(state=tk.DISABLED)  

    global selected_table, results_frame, last_cached_vendors, select_vendor_cache

    if time.time() - last_cached_vendors > 60 * 5:
        last_cached_vendors = time.time()
        select_vendor_cache = {}

    results_frame = tk.Frame(root)
    results_frame.pack(anchor=tk.E, fill=tk.X)

    market_frame = tk.Frame(results_frame)
    market_frame.pack(anchor=tk.W, fill=tk.X, pady=(10, 0))

    markets_table_lable = tk.Label(market_frame, text="Selected Market", font=("Helvetica", 10))
    markets_table_lable.pack(padx=20, anchor=tk.W)

    columns = ("Market Name", "Location", "Operating Hours", "Contact Email")
    market_tree = ttk.Treeview(market_frame, columns=columns, show="headings", height=1, selectmode="none")
    
    market_tree.insert("", "end", values=market_values, iid=str(market_id))

    market_tree.pack(pady=(0, 10), padx=20, fill=tk.X)

    for col in columns:
        market_tree.heading(col, text=col)
        market_tree.column(col, width=150)

    if market_id not in select_vendor_cache:
        query = """
                SELECT v.vendor_id, business_name, owner_name, phone, email, stall_number
                FROM Vendors v
                JOIN Market_Stalls ms ON ms.vendor_id = v.vendor_id
                WHERE market_id = %s;
            """

        vendors_table = run_query(query, (market_id,))
        if vendors_table is None:
            messagebox.showerror("Database Error", "Could not retrieve vendors from the database.")
            return
        select_vendor_cache[market_id] = vendors_table
        last_cached_vendors = time.time() 
    else:
        vendors_table = select_vendor_cache[market_id]
   

    vendors_frame = tk.Frame(results_frame)
    vendors_frame.pack(anchor=tk.W, fill=tk.X, pady=(10, 0))

    vendors_table_label = tk.Label(vendors_frame, text="Vendors in Selected Market", font=("Helvetica", 10))
    vendors_table_label.pack(padx=20, anchor=tk.W)

    columns = ("Business Name", "Owner Name", "Phone Number", "Email", "Stall Number")
    vendors_tree = ttk.Treeview(vendors_frame, columns=columns, show="headings", height=max_height(len(vendors_table)), selectmode="none")

    for vendor in vendors_table:
        vendors_tree.insert("", "end", values=vendor[1:], iid=str(vendor[0]))

    vendors_tree.pack(pady=(0, 10), padx=20, fill=tk.X)
    
    for col in columns:
        vendors_tree.heading(col, text=col)
        vendors_tree.column(col, width=150)


def search_entry_placeholder(search_entry, text):
    search_entry.insert(0, text)
    search_entry.config(fg="grey")

    def focused(event):
        if search_entry.get() == text:
            search_entry.delete(0, tk.END)
            search_entry.config(fg="black")

    def un_focused(event):
        if not search_entry.get():
            search_entry.insert(0, text)
            search_entry.config(fg="grey")

    search_entry.bind("<FocusIn>", focused)
    search_entry.bind("<FocusOut>", un_focused)



def place_pre_order(product_id, pre_order_date, pre_order_quantity, customer_name, customer_email, price):
    connection = None
    query = ""
    params = None

    order_result = False
    try: 
        connection = pymysql.connect(
            host=DB_HOST,
            port=int(DB_PORT),
            user=DB_USERNAME,
            password=DB_PASSWORD,
            database=DB_DATABASE
        )

        # Start transaction
        connection.begin()

        product_name = None
        
        with connection.cursor() as cursor:
            query = """
                SELECT stock_quantity, price, name
                FROM products
                WHERE product_id = %s;
            """
            params = (product_id,)

            cursor.execute(query, params)
            result = cursor.fetchall()

            if not result:
                raise Exception("No product was found.")

            product = result[0]
            if not product:
                raise Exception("No product was found.")
            
            current_quantity = product[0]
            price = product[1]
            product_name = product[2]

            if current_quantity < int(pre_order_quantity):
                raise Exception(f"Current quantity ({current_quantity}) of ({product_name}) is less than pre order quantity requested ({pre_order_quantity}).")

            total_amount = int(pre_order_quantity) * price
            

            query = """
                INSERT INTO Orders (order_date, customer_name, customer_email, status, total_amount)
                VALUES (%s, %s, %s, 'Pending', %s)
            """
            date_time = datetime.strptime(pre_order_date, "%Y-%m-%d")

            params = (date_time, customer_name, customer_email, total_amount)

            cursor.execute(query, params)


            order_id = cursor.lastrowid
            query = """
                INSERT INTO Order_Items (order_id, product_id, quantity, price_at_purchase)
                VALUES (%s, %s, %s, %s)
            """
            params = (order_id, product_id, int(pre_order_quantity), price)
            cursor.execute(query, params)


            query = """
                UPDATE Products
                SET stock_quantity = stock_quantity - %s
                WHERE product_id = %s;
            """
            params = (int(pre_order_quantity), product_id)
    
            cursor.execute(query, params)
        connection.commit()
        
        order_result = [True, f"Pre order for {product_name} was successfully placed."]
        

    except Exception as e:
        if connection:
            connection.rollback()
        order_result = [False, str(e)]
    finally:
        if connection:
            connection.close()
        
        clear_results()
        button_clear_results.config(state=tk.NORMAL)
        global results_frame
        results_frame = tk.Frame(root)
        results_frame.pack(anchor=tk.W, fill=tk.X, pady=(10, 0)) 
        lable_pre_order_result = tk.Label(results_frame, text=f"{order_result[1]}", font=("Helvetica", 12))
        lable_pre_order_result.pack(pady=10, padx=(20,0))
    

last_cached_products = 0

def select_product():
    global selected_item, selected_tree, results_frame, selected_table
    selected_item = selected_tree.selection()

    if selected_table is None:
        messagebox.showwarning("No Table Selected", "Please display a table before selecting an item.")
        return None
    
    if not selected_item:
        messagebox.showwarning("No Selection", "Please select a market from the list.")
        return None
    
    product_id = selected_item[0]
    product_values = selected_tree.item(selected_item, "values")

    tags = selected_tree.item(selected_item, "tags")
    description = tags[0] if tags else "No description available."

    if results_frame:
            results_frame.destroy()
            results_frame = None

    button_selected_product.pack_forget()
    button_selected_product.config(state=tk.DISABLED)
    

    results_frame = tk.Frame(root)
    results_frame.pack(anchor=tk.W, fill=tk.X, pady=(10, 0)) 

    columns = ("Product Name", "Price", "Stock Quantity", "Category", "Vendor Name", "Market Name")
    products_tree = ttk.Treeview(results_frame, columns=columns, show="headings", height=1)

    products_tree.pack(padx=20, fill=tk.X)

    for col in columns:
        products_tree.heading(col, text=col)
        products_tree.column(col, width=150)


    products_tree.insert("", "end", values=product_values[0:6], iid=str(product_id))
        
    description_columns = ("Description",)
    products_description_tree = ttk.Treeview(results_frame, columns=description_columns, show="headings", height=1, selectmode="none")

    products_description_tree.heading(description_columns, text=description_columns, anchor=tk.W)
    products_description_tree.column(description_columns, width=150, anchor=tk.W)
        
    products_description_tree.insert("", "end", values=(description,), iid=str(product_id))

    products_description_tree.pack(pady=(0, 10), padx=20, fill=tk.X)

    place_pre_order_frame = tk.Frame(results_frame)
    place_pre_order_frame.pack(anchor=tk.W, fill=tk.X, pady=(10, 0))
    
    root.focus()

    pre_order_date = tk.Entry(place_pre_order_frame, width=30, font=("Helvetica", 11))
    pre_order_date.pack(padx=(20, 0), side=tk.LEFT)

    pre_order_quantity = tk.Entry(place_pre_order_frame, width=20, font=("Helvetica", 11))
    pre_order_quantity.pack(padx=(20, 0), side=tk.LEFT)

    pre_order_customer_name = tk.Entry(place_pre_order_frame, width=30, font=("Helvetica", 11))
    pre_order_customer_name.pack(padx=(20, 0), side=tk.LEFT)

    pre_order_customer_email = tk.Entry(place_pre_order_frame, width=40, font=("Helvetica", 11))
    pre_order_customer_email.pack(padx=(20, 0), side=tk.LEFT)

    

    # customer_name, customer_email, price
    button_pre_order = tk.Button(place_pre_order_frame, text="Place Pre Order", command=lambda: place_pre_order(
        product_id, 
        pre_order_date.get(), 
        pre_order_quantity.get(), 
        pre_order_customer_name.get(), 
        pre_order_customer_email.get(), 
        product_values[1]
        ))
    button_pre_order.pack(padx=(0, 20), side=tk.RIGHT)

    

    unfocus(root, {pre_order_date, pre_order_quantity, pre_order_customer_name, pre_order_customer_email})

    search_entry_placeholder(pre_order_date, "Date: (yyyy-mm-dd)")
    search_entry_placeholder(pre_order_quantity, "Quantity: (number)")
    search_entry_placeholder(pre_order_customer_name, "Name: (First Last)")
    search_entry_placeholder(pre_order_customer_email, "Email: (example@gmail.com)")
    

def perform_search(search_term):
    clear_results()  # Clear previous results before displaying new ones
    
    button_clear_results.pack_forget()
    button_selected_product.pack(side=tk.LEFT, padx=(0, 20))
    button_clear_results.pack(side=tk.LEFT, padx=(0, 20))

    button_selected_product.config(state=tk.NORMAL)  
    button_clear_results.config(state=tk.NORMAL)   
    
    global results_frame, search_products_cache, last_cached_products, selected_table, selected_tree

    if time.time() - last_cached_products > 60 * 5:
        last_cached_products = time.time()
        search_products_cache = {}

    results_frame = tk.Frame(root)
    results_frame.pack(anchor=tk.W, fill=tk.X, pady=(10, 0)) 


    if search_term not in search_products_cache:
        query = """
                SELECT product_id, p.name, price, stock_quantity, category, business_name, m.name, description
                FROM Products p
                JOIN Vendors v ON v.vendor_id = p.vendor_id
                JOIN Market_Stalls ms ON ms.vendor_id = v.vendor_id
                JOIN Markets m ON m.market_id = ms.market_id
                WHERE p.name LIKE %s OR description LIKE %s
                ORDER BY p.name;
            """
        products_table = run_query(query, (f"%{search_term}%", f"%{search_term}%"))
        if products_table is None:
            messagebox.showerror("Database Error", "Could not retrieve products from the database.")
            
            return search_products()
        search_products_cache[search_term] = products_table
        last_cached_products = time.time() 
    products_table = search_products_cache[search_term]

   
    columns = ("Product Name", "Price", "Stock Quantity", "Category", "Vendor Name", "Market Name")
    products_tree = ttk.Treeview(results_frame, columns=columns, show="headings", height=max_height(len(products_table)))

    products_tree.pack(padx=20, fill=tk.X)

    for col in columns:
        products_tree.heading(col, text=col)
        products_tree.column(col, width=150)


    for product in products_table:
        products_tree.insert("", "end", values=product[1:7], iid=str(product[0]), tags=(product[7],))
    
    
    selected_table = "products"
    selected_tree = products_tree


def unfocus(root, buttons):
    focused = False

    def on_click(event):
        for button in buttons:
            if event.widget == button:
                return
        root.focus_set()


    root.bind("<Button-1>", on_click)

def search_products():
    clear_results()  # Clear previous results before displaying new ones
    root.focus()
    
    global selected_table, results_frame, last_cached_vendors, select_vendor_cache
    button_clear_results.config(state=tk.NORMAL)

    results_frame = tk.Frame(root)
    results_frame.pack(anchor=tk.E, fill=tk.X)

    search_frame = tk.Frame(results_frame)
    search_frame.pack()

    search_entry = tk.Entry(search_frame, width=30, font=("Helvetica", 11))
    search_entry.pack(side=tk.LEFT)

    button_search = tk.Button(search_frame, text="Search", command=lambda: perform_search(search_entry.get()))
    button_search.pack(side=tk.LEFT)

    unfocus(root, {search_entry})

    search_entry_placeholder(search_entry, "Search Products...")


# Tkinter GUI
WIDTH = 1200
HEIGHT = 800

root = tk.Tk()
root.title("Farmers Market Database")
root.geometry(f"{WIDTH}x{HEIGHT}")



title_label = tk.Label(root, text="Farmers Market Database", font=("Helvetica", 16))
title_label.pack(pady=10)

main_button_frame = tk.Frame(root)
main_button_frame.pack(side=tk.TOP)


button_display_markets = tk.Button(main_button_frame, text="Browse Farmers Markets", command=display_markets)
button_display_markets.pack(side=tk.LEFT, padx = (0,10))

button_search_products = tk.Button(main_button_frame, text="Search Products", command=search_products)
button_search_products.pack(side=tk.LEFT)



button_frame = tk.Frame(root)
button_frame.pack(anchor=tk.E, pady=0)

button_selected_product = tk.Button(button_frame, text="Select Product", command=select_product)
button_selected_product.pack_forget()  # Hide the button initially
button_selected_product.config(state=tk.DISABLED)

button_selected = tk.Button(button_frame, text="Select Market", command=get_selected_market)
button_selected.pack_forget()  # Hide the button initially
button_selected.config(state=tk.DISABLED)

button_clear_results = tk.Button(button_frame, text="Clear Results", command=clear_results)
button_clear_results.pack(side=tk.LEFT, padx=(0, 20))
button_clear_results.config(state=tk.DISABLED)  





root.mainloop()