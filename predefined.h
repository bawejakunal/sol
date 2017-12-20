/*
 * @author: Kunal Baweja
 */
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <math.h>
#include <unistd.h>

#include "SDL2_gfxPrimitives.h"
#include "SDL2_imageFilter.h"
#include "SDL2_framerate.h"
#include "SDL2_rotozoom.h"

typedef struct {
    long int frame_interval; // In microseconds
    int curr_frame;
    SDL_Window* window;
    SDL_Renderer* renderer;
    SDL_Event Event;
} GAME;

/* Global variables for graphics management */
GAME theGame;
/* Boolean to keep track of whether the program is still running */
extern bool _Running;
FPSmanager fpsmanager;

int startSDL();
bool onInitSDL();
bool LoadContent();
void onEventSDL(SDL_Event* Event);
void clearSDL();
void onRenderStartSDL();
void onRenderFinishSDL();
int stopSDL();

/* type conversion statements */
double intToFloat(int num);
int floatToInt(double num);

/* trigonometric functions */
double sine(double angle);
double cosine(double angle);

/* Framerate functions */
int setFramerate(int rate);
int getFramerate();

/* Internal Draw functions of SOL */

bool drawPointUtil(const int point[2], const int rgb[3], const int opacity);
bool drawPoint(const int point[2], const int rgb[3]);

bool drawCurveUtil(const Sint16 *vx, const Sint16 *vy, const int num,
    const int steps, const int rgb[2], const int opacity);

bool drawCurve(const int start[2], const int mid[2], const int end[2],
    const int steps, const int rgb[3]);

/* print on SDL window; returns 0 on success, -1 on failure */
int print(const int pt[2], const char *text, const int color[3]);

/* rotate a coordinate */
void rotateCoordinate(int pt[2], const int axis[2], const double degree);

/* rotate a curve */
void rotateCurve(int start[2], int mid[2], int end[2], const int axis[2],
    const double degree);

/* translate a point */
void translatePoint(int pt[2], int* displaceX, int* displaceY, int maxFrame, int sign);

/* translateCurve */
void translateCurve(int start[2], int mid[2], int end[2],
    int* displaceX, int* displaceY, int maxFrame, int sign);

/* Allocate space based on multiple translates */
int* allocTranslateArrayX(int* indivDispX, int* times, int num, int* numFrames);
int* allocTranslateArrayY(int* indivDispY, int* times, int num, int* numFrames);