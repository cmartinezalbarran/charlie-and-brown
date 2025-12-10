from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI(title="Charlie & Brown API", version="1.0.0")

# --- PASAPORTE VIP (CORS) ---
# Permitimos TODAS las variaciones posibles para que Chrome no moleste
origins = [
    "http://localhost",
    "http://127.0.0.1",
    "http://localhost:8000",
    "http://127.0.0.1:8000",
    "*"  # El comodín maestro (Permite todo)
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # Permitir a todos (Modo Dev agresivo)
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
    print("¡ALGUIEN TOCÓ LA PUERTA! 🔔") # Esto saldrá en tu terminal negra
    return {"message": "Bienvenido al Backend de Charlie & Brown 🐾 - Operativo"}

@app.post("/dogs/register")
def register_dog(dog: DogProfile):
    return {"status": "success", "message": f"Perro {dog.name} registrado en la manada"}