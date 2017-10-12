#include"game.h"


int OnExecute() {

	theGame.window = NULL;
	theGame.Running = true;

	if(OnInit() == false) {
		return -1;
	}



	while(theGame.Running) {
		while(SDL_PollEvent(&theGame.Event)) {
			OnEvent(&theGame.Event);
		}

		OnLoop();
		OnRender();
	}

	Cleanup();

	return 0;
}

int main(int argc, char* argv[]) {


	return OnExecute();
}
