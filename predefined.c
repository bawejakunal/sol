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
    theGame.curr_frame = 0;
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
    // Enforce frame rate by sleeping
    usleep(theGame.frame_interval);
    theGame.curr_frame += 1;
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
    // Set default values for framerate
    setFramerate(30);
    theGame.frame_interval = 33333;

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

/* return double representation of int */
double intToFloat(int num){
    return (double)num;
}

/* return int representation of a double */
int floatToInt(double num) {
    return (int)num;
}

/* sine of angle accepted in degrees */
double sine(double angle) {
    return sin(angle * M_PI / 180.0);
}

/* cosine of angle accepted in degrees */
double cosine(double angle) {
    return cos(angle * M_PI / 180);
}

/* 
 * set frames per second (positive integer)
 * returns 0 for sucess and -1 for error
 */
int setFramerate(int rate) {
    theGame.frame_interval = 1e6 / rate;
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
    int _d = (int)(degree * 100);
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
void translatePoint(int pt[2], int* displaceX, int* displaceY, int sign, int maxFrame) {
    pt[0] += (sign * displaceX[((theGame.curr_frame < maxFrame) ? theGame.curr_frame : maxFrame - 1)]);
    pt[1] += (sign * displaceY[((theGame.curr_frame < maxFrame) ? theGame.curr_frame : maxFrame - 1)]);
}

/* translate a bezier curve control points */
void translateCurve(int start[2], int mid[2], int end[2],
    int* displaceX, int* displaceY, int maxFrame, int sign) {
    translatePoint(start, displaceX, displaceY, sign, maxFrame);
    translatePoint(mid, displaceX, displaceY, sign, maxFrame);
    translatePoint(end, displaceX, displaceY, sign, maxFrame);
}

int* allocTranslateArrayX(int* indivDispX, int* times, int num, int* numFrames) {
    int totalSeconds = 0;
    int i, j;
    int frameRate = getFramerate();
    int currTime, currFrames;
    for(i = 0; i < num; i++)
        totalSeconds += times[i];
    *numFrames = totalSeconds * frameRate;
    int* dispX = (int*) malloc((*numFrames) * sizeof(int));
    // printf("%d\n", dispX);

    float cumulX = 0.0;
    int frameIndex = 0;

    for(i = 0; i < num; i++) {
        currTime = times[i];
        currFrames = currTime * frameRate;
        // printf("%d, %d : %d\n", indivDispX[i], currTime, num);
        float dispPerFrameX = (float)indivDispX[i] / currFrames;
        for(j = 0; j < currFrames; j++) {
            cumulX += dispPerFrameX;
            dispX[frameIndex] = (int) cumulX;
            // printf("%d, ", (int)cumulX);
            frameIndex += 1;
        }
        // printf("\n");
    }
    // printf("%d, %d, %d, %d\n", frameIndex, (int) cumulX, dispX[0], dispX);
    return dispX;
}

int* allocTranslateArrayY(int* indivDispY, int* times, int num, int* numFrames) {
    int totalSeconds = 0;
    int i, j;
    int frameRate = getFramerate();
    int currTime, currFrames;
    for(i = 0; i < num; i++)
        totalSeconds += times[i];
    *numFrames = totalSeconds * frameRate;
    int* dispY = (int*) malloc((*numFrames) * sizeof(int));
    // printf("%d\n", dispY);

    float cumulY = 0.0;
    int frameIndex = 0;

    for(i = 0; i < num; i++) {
        currTime = times[i];
        currFrames = currTime * frameRate;
        // printf("%d, %d : %d\n", indivDispY[i], currTime, num);
        float dispPerFrameY = (float)indivDispY[i] / currFrames;
        for(j = 0; j < currFrames; j++) {
            cumulY += dispPerFrameY;
            dispY[frameIndex] = (int) cumulY;
            // printf("%d, ", (int)cumulY);
            frameIndex += 1;
        }
        // printf("\n");
    }
    // printf("%d, %d, %d, %d\n", frameIndex, (int) cumulY, dispY[0], dispY);

    return dispY;
}