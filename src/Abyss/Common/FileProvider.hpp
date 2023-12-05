#pragma once

#include <Abyss/Streams/MPQStream.h>
#include <string>

namespace Abyss::Common {

class FileProvider {
  public:
    virtual ~FileProvider() = default;
    [[nodiscard]] virtual auto loadFile(std::string_view path) -> Streams::MPQStream = 0;
    [[nodiscard]] virtual auto loadString(std::string_view path) -> std::string = 0;
    [[nodiscard]] virtual auto loadStringList(std::string_view path) -> std::vector<std::string> = 0;
    [[nodiscard]] virtual auto loadBytes(std::string_view path) -> std::vector<std::byte> = 0;
    [[nodiscard]] virtual auto loadStream(std::string_view path) -> Streams::InputStream = 0;
};

} // namespace Abyss::Common