/*
 * @author: Kunal Baweja
 */
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <math.h>

#include "SDL2_gfxPrimitives.h"
#include "SDL2_imageFilter.h"
#include "SDL2_framerate.h"
#include "SDL2_rotozoom.h"

typedef struct {
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

/* Framerate functions */
int setFramerate(int rate);
int getFramerate();

/* Internal Draw functions of SOL */

bool drawPointUtil(const int point[2], const int rgb[3], const int opacity);
bool drawPoint(const int point[2], const int rgb[3]);

bool drawCurveUtil(const Sint16 *vx, const Sint16 *vy, const int num,
    const int steps, const int rgb[2], const int opacity);

bool drawCurve(int* start, int* mid, int* end,
    int steps, int* rgb);

/* 
 * print on SDL window
 * returns 0 on success, -1 on failure
 */
int print(const int pt[2], const char *text, const int color[3]);
