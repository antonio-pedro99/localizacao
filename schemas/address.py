from pydantic import BaseModel


class Address(BaseModel):
    name:str
    city: str
    state:str
    country:str
    country_code: str
    lon: float
    lat: float
    display_name:str
    address_line1:str
    address_line2: str
    address_type: str


class DistanceAddress(BaseModel):
    firstAddress:str
    secondAddress:str
