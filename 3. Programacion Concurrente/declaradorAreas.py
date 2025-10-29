def perimetro_rectangulo_sin_solape(x1, y1, x2, y2, nombre="A"):
    # Aseguramos orden correcto
    x_min, x_max = sorted([x1, x2])
    y_min, y_max = sorted([y1, y2])
    
    # Lados del perímetro (ajustados para no repetir esquinas)
    lados = [
        (x_min, y_min, x_min, y_max - 1),  # Izquierdo
        (x_min, y_max, x_max - 1, y_max),  # Superior
        (x_max, y_min + 1, x_max, y_max),  # Derecho
        (x_min + 1, y_min, x_max, y_min)   # Inferior
    ]
    
    # Formatear salida
    resultado = []
    for i, (x1, y1, x2, y2) in enumerate(lados, start=1):
        resultado.append(f"  {nombre}{i}: AreaC({x1},{y1},{x2},{y2})")
    return resultado


# --- Ejemplo de uso ---
if __name__ == "__main__":
    entrada = input("Ingresa las dos esquinas (ejemplo: 15,15-30,35): ")
    p1, p2 = entrada.split("-")
    x1, y1 = map(int, p1.split(","))
    x2, y2 = map(int, p2.split(","))

    nombre = input("Prefijo del área (ejemplo: A): ") or "A"
    lados = perimetro_rectangulo_sin_solape(x1, y1, x2, y2, nombre.upper())

    print("\nÁreas del perímetro:")
    for linea in lados:
        print(linea)
