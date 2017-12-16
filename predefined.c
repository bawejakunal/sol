/*
 * @author: Kunal Baweja
 * Pre-defined fucntions for SOL 
 */

#include "predefined.h"

bool onInitSDL() {
    if(SDL_Init(SDL_INIT_EVERYTHING) < 0) {
        return false;
    }

    if((theGame.window = SDL_CreateWindow("Shape Oriented Language",100,100,640, 480, SDL_WINDOW_SHOWN)) == NULL) {
        return false;
    }
    //SDL Renderer
    theGame.renderer = SDL_CreateRenderer(theGame.window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if (theGame.renderer == NULL){
        printf("%s \n", SDL_GetError());
        return 1;
    }
    return true;
}

void onEventSDL(SDL_Event* Event) {
    if(Event->type == SDL_QUIT) {
        theGame.Running = false;
    }
}

void onLoopSDL()
{
    /* clear screen before drawing again */
    SDL_SetRenderDrawColor(theGame.renderer, 242, 242, 242, 255);
    SDL_RenderClear(theGame.renderer);
}

void onRenderSDL()
{
    SDL_RenderPresent(theGame.renderer);
}

void cleanupSDL()
{
    SDL_DestroyRenderer(theGame.renderer);
    SDL_DestroyWindow(theGame.window);
    SDL_Quit();
}

int startSDL() {

	theGame.window = NULL;
	theGame.Running = true;

	if(onInitSDL() == false) {
		return -1;
	}

    /* initialize frame rate manager */
    SDL_initFramerate(&fpsmanager);

	return 0;
}

int runSDL() {

	while(theGame.Running) {
		while(SDL_PollEvent(&theGame.Event)) {
			onEventSDL(&theGame.Event);
		}

		onLoopSDL();
		onRenderSDL();
	}

	cleanupSDL();

	return 0;
}

/* draw a point in SOL */
bool drawPointUtil(const int point[2], const int rgb[3], const int opacity) {
    pixelRGBA(theGame.renderer, (Sint16)point[0], (Sint16)point[1],
        (Uint8)rgb[0], (Uint8)rgb[1], (Uint8)rgb[2], opacity);
    return true;
}

bool drawPoint(const int point[2], const int rgb[3]) {
    return drawPointUtil(point, rgb, 255);
}

/* helper function to draw a bezier curve in SOL */
bool drawCurveUtil(const int points[3][2], const int num, const int steps,
    const int rgb[3], const int opacity) {

    Sint16 *vx = NULL;
    Sint16 *vy = NULL;
    
    // accumulate x and y coordinates
    if ((vx = (Sint16*)malloc(num * sizeof(Sint16))) == NULL)
        return false;

    if ((vy = (Sint16*)malloc(num * sizeof(Sint16))) == NULL) {
        free(vx);
        return false;
    }

    for (int i = 0; i < num; i++) {
        vx[i] = points[i][0];   // x coordinate
        vy[i] = points[i][1];   // y coordinate
    }

    // pass arguments to SDL gfx
    bool res = bezierRGBA(theGame.renderer, vx, vy, num, steps, (Uint8)rgb[0],
        (Uint8)rgb[1], (Uint8)rgb[2], (Uint8)opacity);

    // memory cleanup
    free(vx);
    free(vy);

    return res;
}

/* draw a bezier curve with 3 control points */
bool drawCurve(const int points[3][2], const int steps, const int rgb[3]) {
    return drawCurveUtil(points, 3, steps, rgb, 255);
}


/* 
 * set frames per second (positive integer)
 * returns 0 for sucess and -1 for error
 */
int setFramerate(int rate) {
    return SDL_setFramerate(&fpsmanager, (Uint32)rate);
}


/* get current frame ratre per second */
int getFramerate() {
    return SDL_getFramerate(&fpsmanager);
}

/* 
 * print on SDL window
 * returns 0 on success, -1 on failure
 */
int print(const int pt[2], const char *text, const int color[3]) {
    return stringRGBA(theGame.renderer, (Sint16)pt[0], (Sint16)pt[1], text,
        (Uint8)color[0], (Uint8)color[1], (Uint8)color[2], 255);
}
