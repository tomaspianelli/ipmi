// Alumno: Tomás Valentino Pianelli
// Numero de legaho: 119110/7
// Artista: Luis Sacilotto
// Video de YouTube: https://youtu.be/QQ81nejjZEo

PImage img;
float rotacion = 0; // Variable para almacenar el ángulo de rotación
boolean rotar = false; // Variable para controlar si debe rotar o no
boolean moverConMouse = false; // Variable para controlar si deben moverse con el mouse
boolean explotar = false; // Variable para controlar si debe explotar la imagen
int cant = 100; // Cantidad de rectángulos en la explosión
int tam; // Tamaño de los rectángulos en la explosión

int posXFlechas = 0; // Posición X para el movimiento con las flechas
int posXAWSD = 0; // Posición X para el movimiento con las teclas AWSD

// Posiciones iniciales
int inicioXFlechas = 400; // Primera X
int inicioXAWSD = 600; // Segunda X

int desplazamiento = 10; // Cantidad de píxeles para mover

int tamanoCuadrado = 20;  // Tamaño del cuadrado más pequeño

color fondoInicial = color(144, 164, 174);  // Color de fondo inicial
color colorCuadradoInicial1 = color(0); // Color del primer tipo de cuadrado
color colorCuadradoInicial2 = color(255); // Color del segundo tipo de cuadrado

color fondoActual = fondoInicial;
color colorCuadradoActual1 = colorCuadradoInicial1;
color colorCuadradoActual2 = colorCuadradoInicial2;

void setup() {
  size(800, 400);
  img = loadImage("obra.jpg");
  tam = width / cant;
}

void draw() {
  background(fondoActual); 
  image(img, 0, 0, 400, 400); 

  int espacio = 0;  // Espacio entre cuadrados más pequeño

  // Posiciones para las "X"
  int posX1 = moverConMouse ? mouseX - 100 : inicioXFlechas + posXFlechas;
  int posX2 = moverConMouse ? mouseX + 100 : inicioXAWSD + posXAWSD;

  // Dibuja la "X" de la izquierda controlada por las flechas o el mouse, o explota si está en modo explosión
  if (!explotar) {
    dibujarX(posX1, posX1 + 200, 0, height, tamanoCuadrado, espacio);
  } else {
    for (int i = 0; i < cant; i++) {
      int x = floor(random(inicioXFlechas, inicioXFlechas + 200 - tam));
      int y = floor(random(0, height - tam));
      rect(x, y, tam, tam);
    }
  }

  // Dibuja la "X" de la derecha controlada por AWSD o el mouse, o explota si está en modo explosión
  if (!explotar) {
    dibujarX(posX2, posX2 + 200, 0, height, tamanoCuadrado, espacio);
  } else {
    for (int i = 0; i < cant; i++) {
      int x = floor(random(inicioXAWSD, inicioXAWSD + 200 - tam));
      int y = floor(random(0, height - tam));
      rect(x, y, tam, tam);
    }
  }

  if (rotar) {
    rotacion += 5; // Incrementa el ángulo de rotación continuamente
  }
}

void dibujarX(int inicioX, int finX, int inicioY, int finY, int tamanoCuadrado, int espacio) {
  // Dibuja la primera diagonal (de la esquina de arriba izquierda hasta a la esquina de abajo de la derecha)
  for (int i = 0; i <= finX - inicioX; i += tamanoCuadrado + espacio) {
    int x = inicioX + i;
    int y = (int)map(i, 0, finX - inicioX, inicioY, finY); // Escala proporcionalmente a la altura
    pushMatrix();
    translate(x + tamanoCuadrado / 2, y + tamanoCuadrado / 2);
    rotate(PI / 4 + radians(rotacion));
    if (mouseOverSquare(x, y, tamanoCuadrado)) {
      fill(random(255), random(255), random(255));
    } else {
      fill((i / (tamanoCuadrado + espacio)) % 2 == 0 ? colorCuadradoActual1 : colorCuadradoActual2);
    }
    rect(-tamanoCuadrado / 2, -tamanoCuadrado / 2, tamanoCuadrado, tamanoCuadrado);
    popMatrix();
  }

  // Dibuja la segunda diagonal (de la esquina de arriba derecha a la esquina de abajo izquierda)
  for (int i = 0; i <= finX - inicioX; i += tamanoCuadrado + espacio) {
    int x = inicioX + i;
    int y = (int)map(i, 0, finX - inicioX, finY, inicioY); // Escala proporcionalmente a la altura inversamente
    pushMatrix();
    translate(x + tamanoCuadrado / 2, y + tamanoCuadrado / 2);
    rotate(PI / 4 + radians(rotacion));
    if (mouseOverSquare(x, y, tamanoCuadrado)) {
      fill(random(255), random(255), random(255));
    } else {
      fill((i / (tamanoCuadrado + espacio)) % 2 == 0 ? colorCuadradoActual1 : colorCuadradoActual2);
    }
    rect(-tamanoCuadrado / 2, -tamanoCuadrado / 2, tamanoCuadrado, tamanoCuadrado);
    popMatrix();
  }
}

boolean mouseOverSquare(int x, int y, int tamano) {
  return mouseX >= x && mouseX <= x + tamano && mouseY >= y && mouseY <= y + tamano;
}

void mousePressed() {
  rotar = !rotar; 
}

void keyPressed() {
  if (key == 'm') {
    moverConMouse = !moverConMouse; 
  } else if (key == 'c') {
    color colores0 = color(216, 191, 216);
    color colores1 = color(173, 216, 230);
    color colores2 = color(0);
    color colores3 = color(255);
    color colores4 = color(128);
    color colores5 = color(255, 255, 0);
    color colores6 = color(144, 238, 144);
    color nuevoFondo, nuevoColorCuadrado1, nuevoColorCuadrado2;
    do {
      int randIndex1 = int(random(7));
      int randIndex2 = int(random(7));
      int randIndex3 = int(random(7));
      nuevoFondo = (randIndex1 == 0) ? colores0 : (randIndex1 == 1) ? colores1 : (randIndex1 == 2) ? colores2 : (randIndex1 == 3) ? colores3 : (randIndex1 == 4) ? colores4 : (randIndex1 == 5) ? colores5 : colores6;
      nuevoColorCuadrado1 = (randIndex2 == 0) ? colores0 : (randIndex2 == 1) ? colores1 : (randIndex2 == 2) ? colores2 : (randIndex2 == 3) ? colores3 : (randIndex2 == 4) ? colores4 : (randIndex2 == 5) ? colores5 : colores6;
      nuevoColorCuadrado2 = (randIndex3 == 0) ? colores0 : (randIndex3 == 1) ? colores1 : (randIndex3 == 2) ? colores2 : (randIndex3 == 3) ? colores3 : (randIndex3 == 4) ? colores4 : (randIndex3 == 5) ? colores5 : colores6;
    } while (nuevoFondo == nuevoColorCuadrado1 || nuevoFondo == nuevoColorCuadrado2 || nuevoColorCuadrado1 == nuevoColorCuadrado2);
    fondoActual = nuevoFondo;
    colorCuadradoActual1 = nuevoColorCuadrado1;
    colorCuadradoActual2 = nuevoColorCuadrado2;
  } else if (key == 'r') {
    reiniciarVariables();
  } else if (key == 'b') {
    explotar = true; 
  } else if (!moverConMouse) {
    if (keyCode == LEFT) {
      posXFlechas -= desplazamiento;
    } else if (keyCode == RIGHT) {
      posXFlechas += desplazamiento;
    } else if (key == 'a') {
      posXAWSD -= desplazamiento;
    } else if (key == 'd') {
      posXAWSD += desplazamiento;
    }
  }
}

void reiniciarVariables() {
  rotacion = 0;
  rotar = false;
  moverConMouse = false;
  explotar = false;
  posXFlechas = 0;
  posXAWSD = 0;
  fondoActual = fondoInicial;
  colorCuadradoActual1 = colorCuadradoInicial1;
  colorCuadradoActual2 = colorCuadradoInicial2;
  cant = 100;
  tam = width / cant;
}
