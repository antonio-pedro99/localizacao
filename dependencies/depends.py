from typing import Tuple
from geopy.geocoders import Nominatim
from geopy.distance import distance

NoCoordinateFoundError = {"error": "No data was found for this point. Try to correct the lactitude and longitude values"}

locator = Nominatim(
    user_agent = "localizacao")

def calculate_distance(location:Tuple, destination:Tuple):
    return distance(location, destination).km

def get_location_details(l:Tuple):
    location = locator.reverse(l) 
    if location:
        return location.raw
    return NoCoordinateFoundError

def get_location_details_by_address(address:str):
    location = locator.geocode(address, language="en")
    if location:
        return location.raw
    return {"error": "No data was found for this point."}

def get_coordinates_by_address(address:str):
    location = locator.geocode(address)
    if location:
        return {"lat": location.raw["lat"], "lon": location.raw["lon"]}
    return NoCoordinateFoundError

def get_tax(fixed_tax:float, tax_rate:float, distance:float):
    total_tax = 0
    if distance <= 10:
        total_tax = fixed_tax
    elif distance > 10:
        total_tax = distance * tax_rate
    return total_tax