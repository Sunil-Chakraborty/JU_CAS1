from flask import Flask, render_template
import os, re

app = Flask(__name__)

@app.route('/')
def index():
    rack_capacity = 20  # Assuming the rack has a capacity of 10 slots
    directory = 'static/product_images'
    filled_filenames = os.listdir(directory)
    filled_slots = [int(re.search(r'\d+', filename).group()) for filename in filled_filenames]
    
    # Dynamically generate product_images list
    product_images = [str(index) if index not in filled_slots else 'p{}.PNG'.format(index) for index in range(0, rack_capacity + 1)]
    
    quantities = [0, 5, 10, 9, 0, 8, 2, 11, 13, 4]  # Example: Quantities for each slot
    
    #return render_template('rack.html', rack_capacity=rack_capacity, filled_slots=filled_slots, product_images=product_images)
    return render_template('rack.html', rack_capacity=rack_capacity, filled_slots=filled_slots, product_images=product_images, quantities=quantities)

if __name__ == '__main__':
    app.run(debug=True)
   