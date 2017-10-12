#include"game.h"
void OnRender()
{
    SDL_SetRenderDrawColor(theGame.renderer, 255, 0, 0, 255);
    SDL_RenderDrawLine(theGame.renderer, 20, 10, 70, 90);

    SDL_RenderPresent(theGame.renderer);
}
