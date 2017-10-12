#include"game.h"

void OnEvent(SDL_Event* Event) {
    if(Event->type == SDL_QUIT) {
        theGame.Running = false;
    }
}
