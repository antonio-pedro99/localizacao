from typing import Tuple
from geopy.geocoders import Nominatim
from geopy.distance import distance
from schemas.location import Location


locator = Nominatim(
    user_agent = "http")

def calculate_distance(location:Tuple, destination:Tuple):
    return distance(location, destination).km

def get_location_details(l:Tuple):
    location = locator.reverse(l) 
    if location:
        return location.raw
    return {"error": "No data was found for this point."}

def get_location_details_by_address(address:str):
    location = locator.geocode(address)
    if location:
        return location.raw
    return {"error": "No data was found for this point."}

