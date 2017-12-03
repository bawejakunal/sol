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

GAME theGame;

int startSDL();
int runSDL();
bool onInitSDL();
bool LoadContent();
void onEventSDL(SDL_Event* Event);
void onLoopSDL();
void onRenderSDL();
void cleanupSDL();


/* Internal Draw functions of SOL */

bool drawPointUtil(int *point, int *rgb, int opacity);
bool drawPoint(int *point, int *rgb);

bool drawCurveUtil(int **points, int num, int steps, int *rgb, int opacity);
bool drawCurve(int **points, int *rgb);