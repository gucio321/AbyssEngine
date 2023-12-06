module;

#include <SDL2/SDL.h>
#include <chrono>

export module OD2.Scenes.MainMenu;

import Abyss.Common.Button;
import Abyss.Common.Scene;
import Abyss.Common.SpriteFont;
import Abyss.DataTypes.DC6;
import OD2.Scenes.MainMenu.Logo;
import OD2.Common.PaletteManager;
import OD2.Common.ButtonDefManager;
import OD2.Common.ResourcePaths;

namespace OD2::Scenes::MainMenu {

export class MainMenu final : public Abyss::Common::Scene {
    Abyss::DataTypes::DC6 _background;
    Logo _d2Logo;
    Abyss::Common::Button<Abyss::DataTypes::DC6> _btnExit;
    Abyss::Common::SpriteFont<Abyss::DataTypes::DC6> _font;

    auto onExitClicked() -> void {}

  public:
    MainMenu()
        : _background(Abyss::DataTypes::DC6(Common::ResourcePaths::MainMenu::GameSelectScreen)),
          _btnExit(Common::ButtonDefManager::getInstance().getButtonDef("Wide"), "Exit Diablo II", [this] { onExitClicked(); }),
          _font(Common::ResourcePaths::FontsAndLocales::FontExocet10, Common::PaletteManager::getInstance().getPalette("Static")) {
        _background.setPalette(Common::PaletteManager::getInstance().getPalette("Sky"));
        _font.setText("EXIT DIABLO II");
        // Abyss::AbyssEngine::getInstance().setBackgroundMusic(Common::ResourcePaths::Music::Title);
    }

    auto update([[maybe_unused]] const std::chrono::duration<double> deltaTime) -> void { _d2Logo.update(deltaTime); }

    auto processEvent([[maybe_unused]] const SDL_Event &event) -> void {}

    auto render() -> void {
        _background.draw(0, 0, 0, 4, 3);
        _d2Logo.render();
        _btnExit.draw(264, 535);
        _font.draw(314, 545);
    }
};

} // namespace OD2::Scenes::MainMenu
