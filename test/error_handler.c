#define PI 3.14159265
#define g 9.8  // Przyspieszenie ziemskie

int running = 1; 

bool checkIfCorrect(uint8_t* pixelData, float v0, float theta, float u, int width, int height) {
    float t, vx, vy, x, y;
    float dt = 0.01;  // Krok czasowy

    // Przeliczenie kąta na radiany
    theta = theta * PI / 180.0;

    // Obliczenie składowych poziomej i pionowej prędkości początkowej
    vx = v0 * cos(theta);
    vy = v0 * sin(theta);

    // Inicjalizacja położeń początkowych
    x = 0.0;
    y = 0.0;

    // Symulacja ruchu rzutu ukośnego z uwzględnieniem tarcia
    while (y >= 0.0) {
        // Obliczenie przyspieszenia wzdłuż osi poziomej z uwzględnieniem tarcia
        float ax = -u * vx * vx;
        // Obliczenie przyspieszenia wzdłuż osi pionowej z uwzględnieniem tarcia
        float ay = -g - u * vy * vy;

        // Obliczenie nowych prędkości
        vx += ax * dt;
        vy += ay * dt;

        // Obliczenie nowych położeń
        x += vx * dt;
        y += vy * dt;

        // Dodawanie do pixel data
        int intX = (int)x;
        int intY = (int)y;
        if(intX < 0 || intX >= width || intY < 0 || intY >= height)
            return false;
    }
    return true;
}