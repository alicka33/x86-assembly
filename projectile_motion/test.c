#include <GL/gl.h>
#include <GL/glut.h>

#define WIDTH 800
#define HEIGHT 600
// #define SIZE HEIGHT * WIDTH * 3 // wielkość bitmapy (* 3 bo rgb)
uint8_t pixelData[SIZE];
// float v0 = 80.0;  // initial velocity
// float theta = 45.0;  // launch angle in degrees
// float K = 1.0;    // initial K
// //GLubyte* pixelData = NULL;

// extern void projectile_motion(uint8_t* pixelData, float v0, float theta, float K);
void display() {
    glClear(GL_COLOR_BUFFER_BIT);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrtho(0, WIDTH, 0, HEIGHT, -1, 1);

    // Example pixel array, assuming RGBA format
    int pixelArray[WIDTH * HEIGHT];
    
    // Fill pixel array with sample data (red color)
    projectile_motion(pixelData, v0, theta, K);
    
    glRasterPos2i(0, 0);
    glDrawPixels(WIDTH, HEIGHT, GL_RGBA, GL_UNSIGNED_BYTE, pixelArray);

    glFlush();
}

int main(int argc, char** argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
    glutInitWindowSize(WIDTH, HEIGHT);
    glutCreateWindow("Pixel Array");

    glutDisplayFunc(display);

    glutMainLoop();
    return 0;
}