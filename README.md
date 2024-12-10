# 📦 **3D Platformer Game (Godot)**
Este proyecto es un **juego de plataformas 3D** desarrollado en Godot. En este README se explicará el propósito y el funcionamiento de los principales scripts y mecánicas incluidas en el juego.

---

## 🕹️ **Controles del Jugador**
- **Movimiento**: Usa las teclas de flechas **← ↑ ↓ →** para moverte.
- **Salto**: Usa la tecla **Enter** para saltar.
- **Rotación de Cámara**: 
  - **A**: Gira la cámara a la izquierda.
  - **D**: Gira la cámara a la derecha.

---

## 📄 **Estructura de los Scripts**
El juego cuenta con varios scripts que controlan distintos aspectos de la jugabilidad. Aquí se explica cada uno de ellos.

---

## 🕵️‍♂️ **1. Control del Jugador (`extends CharacterBody3D`)**

### **Variables principales**

const SPEED = 8.0  # Velocidad de movimiento del jugador
const JUMP_VELOCITY = 12  # Velocidad del saltoFuncionalidad principal

El script de control del jugador maneja el movimiento, la rotación de la cámara y la detección de colisiones con el suelo. A continuación, se explican sus partes más importantes:

### **Rotación de la cámara**
La cámara se rota con las teclas **A** y **D**, moviéndola 23.55° a la izquierda o derecha.

### **Gravedad**
Se aplica gravedad si el jugador no está tocando el suelo (`is_on_floor()`).

### **Salto**
Cuando el jugador presiona la tecla **Enter** y está en el suelo, se aplica una velocidad vertical de salto.

### **Movimiento**
El movimiento se controla con las flechas **← ↑ ↓ →**, usando `Input.get_vector()` para calcular la dirección.  
La velocidad del jugador se ajusta mediante `move_and_slide()`.

### **gdscript:**

func _physics_process(delta: float) -> void:
    if Input.is_action_just_pressed("cam_left"):
        $control_camara.rotate_y(rad_to_deg(-23.55))
    if Input.is_action_just_pressed("cam_right"):
        $control_camara.rotate_y(rad_to_deg(23.55))
    
    if not is_on_floor():
        velocity += get_gravity() * delta

    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        velocity.y = JUMP_VELOCITY

    var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
    var direction: Vector3 = ($control_camara.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    
    if direction != Vector3.ZERO:
        velocity.x = direction.x * SPEED
        velocity.z = direction.z * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
        velocity.z = move_toward(velocity.z, 0, SPEED)

    move_and_slide()
    $control_camara.position = lerp($control_camara.position, position, 0.15)
### **2.Control de las Monedas (extends Area3D)**
Variables principales:

const win_condition = 3: Número de monedas necesarias para ganar.
const R_SPEED = 2: Velocidad de rotación de las monedas.
Funcionalidad principal: Este script controla la rotación de las monedas y la recolección de las mismas por parte del jugador.

Rotación de la moneda: La función rotar_moneda hace que la moneda gire constantemente a la velocidad de 2 grados por frame.

Detección de colisión: La función _on_body_entered detecta cuando el jugador entra en contacto con la moneda.
Se incrementa la variable global Global.coins.
Cuando el jugador recoge 3 monedas (win_condition), el nivel se reinicia.

### **🔊 3. Reproductor de Sonido (extends AudioStreamPlayer)**
Funcionalidad principal
Este script reproduce automáticamente un archivo de audio cuando la escena se carga.

Reproducción automática:
La función _ready reproduce la música o los efectos de sonido al inicio de la escena.
### **gdscript:**

func _ready():
    play()
### **🌐 4. Control Global (extends Node)**
Variables globales
### **gdscript:**

var coins := 0  # Contador global de monedas
Funcionalidad principal
Reinicio de monedas:
La función _ready asegura que el conteo de monedas se reinicie a cero cuando se inicia la escena.
gdscript
Copy code
func _ready() -> void:
    Global.coins = 0
### **⚠️ 5. Zona de Muerte (_on_death_zone_body_entered)**
Este script se encarga de reiniciar la escena si el jugador entra en la "zona de muerte".

Reinicio de nivel:
Cuando el cuerpo del jugador entra en la "zona de muerte", se carga la escena nivel_1.tscn.
gdscript:

func _on_death_zone_body_entered(body: Node3D) -> void:
    get_tree().change_scene_to_file("res://nivel_1.tscn")
    print('¡Moriste! Vuelve a empezar.')
    
### **📂 Estructura de Archivos**


📦 Proyecto Godot
 ┣ 📂 escenas
 ┃ ┣ 📜 nivel_1.tscn (escena principal del juego)
 ┃ ┗ 📜 monedas.tscn (escena de la moneda)
 ┣ 📂 scripts
 ┃ ┣ 📜 jugador.gd (control del jugador)
 ┃ ┣ 📜 monedas.gd (control de monedas)
 ┃ ┣ 📜 global.gd (variables globales)
 ┃ ┣ 📜 muerte.gd (control de la zona de muerte)
 ┃ ┗ 📜 musica.gd (control de la música de fondo)
 ┗ 📜 project.godot (archivo de configuración de Godot)
### **🔧 Configuraciones Clave**
Acciones de entrada personalizadas:
ui_left, ui_right, ui_up, ui_down: Movimiento del jugador.
ui_accept: Acción de salto.
cam_left: Rotar cámara a la izquierda.
cam_right: Rotar cámara a la derecha.

### **📚 Conceptos Clave**
Gravedad: Aplicada al jugador cuando no está en el suelo.
Input.get_vector: Sistema simple para obtener la dirección del movimiento.
move_and_slide: Método para mover al jugador de forma suave.
Global: Se usa para almacenar datos persistentes, como la cantidad de monedas recolectadas.
### **🏆 Objetivos del Juego**
Recolectar monedas: Recoge al menos 3 monedas para ganar.
Evitar la muerte: Evita caer en la zona de muerte.
Superar niveles: Cada vez que ganas, se reinicia la escena.
