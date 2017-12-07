#include "SDL2_gfxPrimitives.h"
#include "SDL2_imageFilter.h"
#include "SDL2_framerate.h"
#include "SDL2_rotozoom.h"

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <math.h>

typedef struct game
{
	bool Running;
	SDL_Window* window;
	SDL_Renderer* renderer;
	SDL_Event Event;
}GAME;

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

bool drawPointUtil(int *point, int *rgb, int opacity);
bool drawPoint(int *point, int *rgb);

bool drawCurveUtil(int **points, int num, int steps, int *rgb, int opacity);
bool drawCurve(int **points, int *rgb);


/* 
 * print on SDL window
 * returns 0 on success, -1 on failure
 */
int print(int *pt, const char *text, int *color);