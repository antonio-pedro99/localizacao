from lib2to3.pytree import Base
from pydantic import BaseModel


class Location(BaseModel):
    latitude:float
    longitude:float
