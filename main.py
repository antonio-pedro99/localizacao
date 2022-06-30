from typing import Tuple
from fastapi import FastAPI
from schemas.location import Location
from dependencies.depends import distance, get_location_details, locator

app = FastAPI()

@app.get("/details/")
def get_details(lat:float, lon:float):
    return get_location_details(l=(lat, lon))


@app.get("/distance/cost")
def get_cost_per_distance(loc_lact:float,loc_lon:float, des_lat:float, des_lon:float,  fixed_tax:float, tax:float):
    dis = distance((loc_lact, loc_lon), (des_lat, des_lon)).km
    total_tax = 0
    if dis <= 10:
        total_tax = fixed_tax
    elif dis > 10 and dis < 5.5:
        total_tax = dis * tax
    else:
        return {
            "detail": "Can not delivery for distances over 5.5Km"
        }
    return {
        "total_tax": round(total_tax, 2),
        "total_distance": round(dis, 1)
    }
