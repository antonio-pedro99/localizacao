# Webservice[Documentation]

License: IIG 
Made  by: Antonio Pedro

## Introduction
  This Microservice was built to handle all the geolocalization needs of the system being built by IIG. Follow up those steps to know how to use and how it works.
  
## How does it works?

  This Microservice works under geopy python library and FastAPI.
  This might be used and implemented as third Party API. It uses only two HTTP request Method: Get and Post.

## EndPoints
  
   It has only (3) endPoints availables.
   
   #### Get Address Details by GPS Coordinates
   
   - `https://geolocalizacao-api.herokuapp.com/details?address=` -
     It is a Get method and you need to pass the address details in form of `latitude` and `longitude`.
   
   Follow up this example:
   if we have `28.5487558`, `77.2714498`, as the latitude and longitude consequently, the response of this request is going to be
   
   ```json
       {
        "place_id": 30791887,
        "licence": "Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
        "osm_type": "node",
        "osm_id": 2812608848,
        "boundingbox": [
        "28.5487058",
        "28.5488058",
        "77.2713998",
        "77.2714998"],
        "lat": "28.5487558",
        "lon": "77.2714498",
        "display_name": "Okhla Industrial Estate, Phase 3 Branch, RP Singh Chhota road, Okhla Ph III, Kalkaji Tehsil, South East Delhi, Delhi, 110076, India",
        "class": "amenity",
        "type": "bank",
        "importance": 0.41009999999999996,
        "icon": "https://nominatim.openstreetmap.org/ui/mapicons/money_bank2.p.20.png"
    }
    ```
