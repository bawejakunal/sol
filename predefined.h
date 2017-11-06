#include<SDL.h>
#include<stdlib.h>
#include<stdio.h>
#include<stdbool.h>

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
