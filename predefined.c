/*
 * @author: Kunal Baweja
 * Pre-defined functions for SOL 
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
        _Running = false;
    }
}

void clearSDL()
{
    /* clear screen before drawing again */
    SDL_SetRenderDrawColor(theGame.renderer, 242, 242, 242, 255);
    SDL_RenderClear(theGame.renderer);
}

void onRenderStartSDL() {
    while(SDL_PollEvent(&theGame.Event)) {
        onEventSDL(&theGame.Event);
    }

    clearSDL();
}

void onRenderFinishSDL()
{
    SDL_RenderPresent(theGame.renderer);
}

int stopSDL()
{
    SDL_DestroyRenderer(theGame.renderer);
    SDL_DestroyWindow(theGame.window);
    SDL_Quit();
    return 0;
}

int startSDL() {

	theGame.window = NULL;
	_Running = true;

	if(onInitSDL() == false) {
		return -1;
	}

    /* initialize frame rate manager */
    SDL_initFramerate(&fpsmanager);

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
bool drawCurveUtil(const Sint16 *vx, const Sint16 *vy, const int num,
    const int steps, const int rgb[3], const int opacity) {

    // pass arguments to SDL gfx
    bool res = bezierRGBA(theGame.renderer, vx, vy, num, steps, (Uint8)rgb[0],
        (Uint8)rgb[1], (Uint8)rgb[2], (Uint8)opacity);

    return res;
}

/* draw a bezier curve with 3 control points */
bool drawCurve(const int start[2], const int mid[2], const int end[2],
    int steps, const int rgb[3]) {
    // printf("(%d, %d), (%d, %d), (%d, %d), %d, (%d, %d, %d)\n", 
    //     start[0], start[1], mid[0], mid[1], end[0], end[1], steps, rgb[0], rgb[1], rgb[2]);
    
    const int num = 3;

    Sint16 *vx = NULL;
    Sint16 *vy = NULL;
    
    // accumulate x and y coordinates
    if ((vx = (Sint16*)malloc(num * sizeof(Sint16))) == NULL)
        return false;

    if ((vy = (Sint16*)malloc(num * sizeof(Sint16))) == NULL) {
        free(vx);
        return false;
    }

    // x coordinates
    vx[0] = start[0];
    vx[1] = mid[0];
    vx[2] = end[0];

    // y coordinates
    vy[0] = start[1];
    vy[1] = mid[1];
    vy[2] = end[1];

    bool res = drawCurveUtil(vx, vy, num, steps, rgb, 255);

    // memory cleanup
    free(vx);
    free(vy);

    return res;
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

/* 
 * rotate a coordinate clockwise by degree
 * around the axis point
 */
void rotateCoordinate(int pt[2], const int axis[2], const double degree) {
    // account for actual rotation to perform
    int _d = ((int)(degree * 100)) % 36000;
    double _degree = _d / 100.0;
    _degree *= M_PI / 180.0;

    // translate back to origin
    pt[0] -= axis[0];
    pt[1] -= axis[1];

    // rotate and round off to nearest integers
    pt[0] = (int)nearbyint(pt[0] * cos(_degree) - pt[1] * sin(_degree));
    pt[1] = (int)nearbyint(pt[0] * sin(_degree) + pt[1] * cos(_degree));

    // translate point back
    pt[0] += axis[0];
    pt[1] += axis[1];
}

/* rotate a bezier curve control points */
void rotateCurve(int start[2], int mid[2], int end[2], const int axis[2],
    const double degree) {
    rotateCoordinate(start, axis, degree);
    rotateCoordinate(mid, axis, degree);
    rotateCoordinate(end, axis, degree);
}

/* translate a point by given displacement */
void translatePoint(int pt[2], const int displace[2]) {
    pt[0] += displace[0];
    pt[1] += displace[1];
}

/* translate a bezier curve control points */
void translateCurve(int start[2], int mid[2], int end[2],
    const int displace[2]) {
    translatePoint(start, displace);
    translatePoint(mid, displace);
    translatePoint(end, displace);
}