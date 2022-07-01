from fastapi import FastAPI
from typing import Optional

from pymysql import NULL
from schemas.address import DistanceAddress
from dependencies.depends import calculate_distance, get_coordinates_by_address, get_location_details, get_location_details_by_address, get_tax
from schemas.cost import Cost

app = FastAPI()


@app.get("/details", tags=["Coordinates Details"])
def get_details(address:Optional[str] = "", lat:Optional[float]=0, lon:Optional[float] = 0):

    if address == "" or address == NULL:
        return get_location_details(l=(lat, lon))
    elif lon == 0 or lon == NULL and lat == 0 or lat == NULL:
        return get_location_details_by_address(address=address)
    return {
        "details": "If you are using address string set longitude and lactitude either to 0 or null, and vice-versa"
    }
    

@app.get("/distance/cost/coordinates", tags=["Coordinates Distances"],  response_model=Cost)
def get_cost_per_distance_by_coordinates(loc_lact:float,loc_lon:float, des_lat:float, des_lon:float,  fixed_tax:float, tax_rate:float):
    
    distance = calculate_distance((loc_lact, loc_lon), (des_lat, des_lon))
    total_cost = get_tax(fixed_tax=fixed_tax, tax_rate=tax_rate, distance=distance)
    return {
        "total_tax": round(total_cost, 2),
        "distance": round(distance, 1)
    }


@app.post("/distance/cost", tags=["Coordinates Distances"], response_model=Cost)
def get_cost_per_distance_by_address(address:DistanceAddress, fixed_tax:float, tax_rate:float):
    addr1 = get_coordinates_by_address(address.firstAddress)
    addr2 = get_coordinates_by_address(address.secondAddress)
    distance = calculate_distance((addr1["lat"], addr1["lon"]), (addr2["lat"], addr2["lon"]))

    total_cost = get_tax(fixed_tax=fixed_tax, tax_rate=tax_rate, distance=distance)
    return {
        "total_tax": round(total_cost, 2),
        "distance": round(distance, 1)
    }