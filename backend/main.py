from fastapi import FastAPI
from pydantic import BaseModel
from typing import Optional

app = FastAPI(title="Charlie & Brown API", version="1.0.0")

class DogProfile(BaseModel):
    name: str
    breed: str
    age: int
    energy_level: str

@app.get("/")
def read_root():
    return {"message": "Bienvenido al Backend de Charlie & Brown 🐾 - Operativo"}

@app.post("/dogs/register")
def register_dog(dog: DogProfile):
    return {"status": "success", "message": f"Perro {dog.name} registrado en la manada"}
