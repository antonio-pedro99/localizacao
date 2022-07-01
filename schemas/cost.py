from re import I
from pydantic import BaseModel

class Cost(BaseModel):
    total_tax:float
    distance:float
