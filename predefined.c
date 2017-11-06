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
