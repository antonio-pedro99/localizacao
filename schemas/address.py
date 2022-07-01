from pydantic import BaseModel

class DistanceAddress(BaseModel):
    firstAddress:str
    secondAddress:str