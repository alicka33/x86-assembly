#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <GL/gl.h>
#include <GL/glut.h>
#include <stdio.h>
#include <math.h>

#define WIDTH 800
#define HEIGHT 600
#define SIZE HEIGHT * WIDTH * 3
uint8_t pixelData[SIZE];
float v0 = 40.0;  // initial velocity (max 80)
float theta = 60.0;  // launch angle in degrees (max 90)
float K = 0.0001;

#define PI 3.14159265

void clear() {
    int numPixels = WIDTH * HEIGHT;

    for (int i = 0; i < numPixels; i++) {
        pixelData[i * 3 + 0] = 0x00; // Blue
        pixelData[i * 3 + 1] = 0x00; // Green
        pixelData[i * 3 + 2] = 0x00; // Red
    }
}

extern void motion(uint8_t* pixelData, float v0, float cos, float sin, float K);

void display() {
    clear();
    glClear(GL_COLOR_BUFFER_BIT);

    float radianTheta = theta * PI / 180.0;
    float cosT = cos(radianTheta);
    float sinT = sin(radianTheta);
    motion(pixelData, v0, cosT, sinT, K);

    // Set raster position to the bottom-left corner
    glRasterPos2i(-1, -1);

    // Draw the bitmap image
    glDrawPixels(WIDTH, HEIGHT, GL_RGB, GL_UNSIGNED_BYTE, pixelData);

    glFlush();
    
}

void keyCallback(GLFWwindow* window, int key, int scancode, int action, int mods) {
    if (key == GLFW_KEY_Q && action == GLFW_PRESS) {
        glfwSetWindowShouldClose(window, GLFW_TRUE);
    }
    else if (key == GLFW_KEY_V && action == GLFW_PRESS) {
        printf("Enter new v0 value (0-60): ");
        float newV0;
        scanf("%f", &newV0);
        if (newV0 >= 0 && newV0 <= 60) {
            v0 = newV0;
        } else {
            printf("Invalid v0 value. Value must be between 0 and 80.\n");
        }
        glfwPostEmptyEvent();
    }
    else if (key == GLFW_KEY_T && action == GLFW_PRESS) {
        printf("Enter new theta value (0-90): ");
        float newTheta;
        scanf("%f", &newTheta);
        if (newTheta >= 0 && newTheta <= 90) {
            theta = newTheta;
        } else {
            printf("Invalid theta value. Value must be between 0 and 90.\n");
        }
        glfwPostEmptyEvent();
    }
    else if (key == GLFW_KEY_K && action == GLFW_PRESS) {
        printf("Enter new K value (0-1): ");
        float newK;
        scanf("%f", &newK);
        if (newK >= 0 && newK <= 1) {
            K = newK;
        } else {
            printf("Invalid K value. Value must be between 0 and 1.\n");
        }
        glfwPostEmptyEvent();
    }
}

int main() {
    

    if (!glfwInit()) {
        fprintf(stderr, "Failed to initialize GLFW\n");
        return -1;
    }
    GLFWwindow* window;

    window = glfwCreateWindow(WIDTH, HEIGHT, "Projectile Motion", NULL, NULL);
    if (!window) {
        fprintf(stderr, "Failed to create GLFW window\n");
        glfwTerminate();
        return -1;
    }

    glfwMakeContextCurrent(window);

    glfwSetKeyCallback(window, keyCallback);

    while (!glfwWindowShouldClose(window)) {
        display();
        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    glfwTerminate();
    return 0;
}
