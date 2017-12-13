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
	bool Running;
	SDL_Window* window;
	SDL_Renderer* renderer;
	SDL_Event Event;
} GAME;

/* Global variables for graphics management */
GAME theGame;
FPSmanager fpsmanager;

int startSDL();
int runSDL();
bool onInitSDL();
bool LoadContent();
void onEventSDL(SDL_Event* Event);
void onLoopSDL();
void onRenderSDL();
void cleanupSDL();

/* Framerate functions */
int setFramerate(int rate);
int getFramerate();

/* Internal Draw functions of SOL */

bool drawPointUtil(const int point[2], const int rgb[3], const int opacity);
bool drawPoint(const int point[2], const int rgb[3]);

bool drawCurveUtil(const int points[3][2], const int num, const int steps,
    const int rgb[2], const int opacity);

bool drawCurve(const int points[3][2], const int steps, const int rgb[3]);

/* 
 * print on SDL window
 * returns 0 on success, -1 on failure
 */
int print(const int pt[2], const char *text, const int color[3]);
