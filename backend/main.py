from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI()

# PERMITIR TODO (Modo Dios)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # El asterisco es clave
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class DogProfile(BaseModel):
    name: str
    breed: str
    age: int
    energy_level: str

@app.get("/")
def read_root():
    # Este print saldrá en tu terminal negra cuando conectes
    print("🔔 ¡CONEXIÓN EXITOSA DESDE EL FRONTEND!") 
    return {"message": "Bienvenido al Backend de Charlie & Brown 🐾 - Operativo"}

@app.post("/dogs/register")
def register_dog(dog: DogProfile):
    return {"status": "success", "message": f"Perro {dog.name} registrado"}