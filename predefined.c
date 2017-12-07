/*
 *  A function illustrating how to link C code to code generated from LLVM 
 */

#include "predefined.h"

bool onInitSDL() {
    if(SDL_Init(SDL_INIT_EVERYTHING) < 0) {
        return false;
    }

    //win = SDL_CreateWindow("Image Loading", 100, 100, WIDTH, HEIGHT, SDL_WINDOW_RESIZABLE);
     if((theGame.window = SDL_CreateWindow("SDL Render Clear",100,100,640, 480, SDL_WINDOW_SHOWN)) == NULL) {
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
bool drawPointUtil(int *point, int *rgb, int opacity) {
    pixelRGBA(theGame.renderer, (Sint16)point[0], (Sint16)point[1],
        (Uint8)rgb[0], (Uint8)rgb[1], (Uint8)rgb[2], 255);
    return true;
}

bool drawPoint(int *point, int *rgb) {
    return drawPointUtil(point, rgb, 255);
}

/* draw a bezier curve in SOL */
bool drawCurveUtil(int **points, int num, int steps, int *rgb, int opacity) {
    
    int i;
    Sint16 *vx = NULL;
    Sint16 *vy = NULL;
    
    // accumulate x and y coordinates
    if ((vx = (Sint16*)malloc(num * sizeof(Sint16))) == NULL)
        return false;

    if ((vy = (Sint16*)malloc(num * sizeof(Sint16))) == NULL) {
        free(vx);
        return false;
    }

    for (i = 0; i < num; i++) {
        vx[i] = points[i][0];   // x coordinate
        vy[i] = points[i][1];   // y coordinate
    }

    // pass arguments to SDL gfx
    bezierRGBA(theGame.renderer, vx, vy, num, steps, (Uint8)rgb[0],
        (Uint8)rgb[1], (Uint8)rgb[2], (Uint8)opacity);

    // memory cleanup
    free(vx);
    free(vy);

    return true;
}

bool drawCurve(int **points, int *rgb) {
    return drawCurveUtil(points, 3, 100, rgb, 255);
}


/* Framerate functions */
int setFramerate(int rate) {
    /* 
     * rate - frames per second (positive integer)
     * returns 0 for sucess and -1 for error
     */
    return SDL_setFramerate(&fpsmanager, (Uint32)rate);
}

int getFramerate() {
    /* get current frame ratre per second */
    return (int)SDL_getFramerate(&fpsmanager);
}
