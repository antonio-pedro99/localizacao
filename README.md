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
   if we have `28.5487558`, `77.2714498`, as the latitude and longitude consequently
   
   Response Body:
   
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
   #### Get Cost per Distance
   
  - `https://geolocalizacao-api.herokuapp.com/distance/cost/coordinates` - 
    
    It is a Get method and you need to pass both initial address coordinates(latitude and longitude) and final address coordinates(latitude, longitude) as query parameters.
    
    Response body:
   ```json
       {
        "total_tax": 30,
        "distance": 0
    }
   ```
  - `https://geolocalizacao-api.herokuapp.com/distance/cost` - 
  
  Similar to the first one, but it a Post method and you need to pass a request body as
  
 ```json
    {
      "firstAddress": "string",
      "secondAddress": "string"
    }
  ```
  and `fixed_tax`- the normal fee for develivery under 10 km of distance along with `tax_rate` - if the distance is over 10 km increase the fees by tax_rate per km.
  Both `fixed_tax` and `tax_rate` must be passed as query parameter only.
  
  Response body:
    Same as the previous one.
    
  For more details and interative documentation head over at: https://geolocalizacao-api.herokuapp.com/docs or https://geolocalizacao-api.herokuapp.com/redoc
 
