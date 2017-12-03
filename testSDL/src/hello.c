#include <stdio.h>
#include <stdlib.h>

#define SDL_MAIN_HANDLED

#include "SDL2/SDL.h"

#define SCREEN_W 640
#define SCREEN_H 480
#define SCREEN_SCALE 1
#define SCREEN_NAME "SOL"

void game_init(void);
void game_quit(void);

static struct {
	// define "attributes"
	SDL_bool running;

	// define window attributes
	struct {
		unsigned int w;
		unsigned int h;
		const char *name;
		SDL_Window* window;
		SDL_Renderer* renderer;
	} screen;

	// define "methods"
	void (*init)(void);
	void (*quit)(void);
} Game = {
	SDL_FALSE,
	{
		SCREEN_SCALE * SCREEN_W,
		SCREEN_SCALE * SCREEN_H,
		SCREEN_NAME,
		NULL,
		NULL,
	},
	game_init,
	game_quit
};


void game_init(void) {
	if (SDL_Init(SDL_INIT_EVERYTHING) != 0) {
		printf("SDL error -> %s\n", SDL_GetError());
		exit(1);
	}

	unsigned int w = Game.screen.w;
	unsigned int h = Game.screen.h;
	const char* name = Game.screen.name;

	// create window
	Game.screen.window = SDL_CreateWindow(
		name,
		SDL_WINDOWPOS_CENTERED,
		SDL_WINDOWPOS_CENTERED,
		w, h, 0
	);

	// creat renderer
	Game.screen.renderer = SDL_CreateRenderer(
		Game.screen.window, -1,
		SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC
	);

	// set game as running
	Game.running = SDL_TRUE;
}

void game_quit(void) {
	SDL_DestroyRenderer(Game.screen.renderer);
	SDL_DestroyWindow(Game.screen.window);

	Game.screen.window = NULL;
	Game.screen.renderer = NULL;

	SDL_Quit();
}

int main(int argc, char *argv[]) {

	SDL_Event event;
	Game.init();

	while(Game.running) {
		while (SDL_PollEvent(&event)) {
			switch(event.type) {
				case SDL_QUIT:{
					Game.running = SDL_FALSE;
				} break;
			}
		}

		SDL_RenderClear(Game.screen.renderer);
		SDL_RenderPresent(Game.screen.renderer);
	}

	Game.quit();
	return 0;
}
