from typing import Tuple
import json
from urllib import response
from webbrowser import get
from geopy.geocoders import Nominatim
from geopy.distance import distance
import requests

API_KEY = "26596f637c884370a827fbce54d9ddbc"
API_URL = "https://api.geoapify.com/v1/geocode/autocomplete?"
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

def get_address(text:str):
    response = requests.get("{0}text={1}&format=json&api_key={2}".format(API_URL, text, API_KEY))


    
    return response.json()  

def from_coordinates(lat:float, lon:float):
    response = requests.get("https://geocode.xyz/{0},{1}?geoit=json&auth=133263249068629e15842358x107825".format(lat, lon))

    return response.json()