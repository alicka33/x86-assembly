#include <stdio.h>
#include <math.h>
#include <GL/gl.h>
#include <GL/glut.h>

#define WIDTH 800
#define HEIGHT 600
#define SIZE HEIGHT * WIDTH * 3 // wielkość bitmapy (* 3 bo rgb)
uint8_t pixelData[SIZE];
float v0 = 80.0;  // initial velocity
float theta = 45.0;  // launch angle in degrees
float K = 0.001;    // initial K

extern void projectile_motion(uint8_t* pixelData, float v0, float theta, float K);

void clear() {
    int numPixels = WIDTH * HEIGHT;

    for (int i = 0; i < numPixels; i++) {
        pixelData[i * 3 + 0] = 0x00; // Blue
        pixelData[i * 3 + 1] = 0x00; // Green
        pixelData[i * 3 + 2] = 0x00; // Red
    }
}

// OpenGL display function
void display() {
  clear();
  glClear(GL_COLOR_BUFFER_BIT);
  
  projectile_motion(pixelData, v0, theta, K);
  // Draw the bitmap image
  glDrawPixels(WIDTH, HEIGHT, GL_RGB, GL_UNSIGNED_BYTE, pixelData);
  
  glFlush();
  //glutSwapBuffers();
}

// Function to handle keyboard input
void setV(unsigned char key) {
    
    printf("Enter velocity (v0): ");
    scanf("%f", &v0);
    glutPostRedisplay(); // Trigger a redisplay to update the animation
}

void setTheta(unsigned char key) {
    
    printf("Enter angle (theta): ");
    scanf("%f", &theta);
    glutPostRedisplay(); // Trigger a redisplay to update the animation
}

void setK(unsigned char key) {
    
    printf("Enter K parameter (K): ");
    scanf("%f", &v0);
    glutPostRedisplay(); // Trigger a redisplay to update the animation
}


int main(int argc, char** argv) {
    // Initialize GLUT
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
    glutInitWindowSize(WIDTH, HEIGHT);
    glutCreateWindow("Projectile Motion");
    
    glutDisplayFunc(display);
    //glutKeyboardFunc(setV);
    //glutKeyboardFunc(setTheta);
    //glutKeyboardFunc(setK);

    glutMainLoop();
    return 0;
}

// TO COMPILE
// gcc -o myprogram myfile.c -lGL -lGLU -lglut -lm
// ./myprogram