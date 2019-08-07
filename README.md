# Odirion MMO Server

A free and open-source MMORPG server emulator based on **The Forgotten Server (TFS)**, designed to provide a complete multiplayer gaming experience with advanced features and customization options.

## 🎮 About

Odirion MMO Server is a robust MMORPG server implementation that supports:
- **Multiplayer gameplay** with hundreds of concurrent players
- **Live casting system** for streaming gameplay
- **Complete quest system** with NPCs and storylines  
- **Guild and party management**
- **Player vs Player (PvP) combat**
- **Skills and vocations system**
- **Housing system** with rent management
- **Market and trading system**
- **Monster spawning and AI**

## ✨ Features

### Core Gameplay
- **Multi-client support** with included official client
- **Real-time combat system** with spells, weapons, and magic
- **Character progression** through levels and skills
- **Inventory management** with containers and equipment slots
- **Death and resurrection mechanics** with configurable penalties

### Advanced Systems
- **Live Casting**: Built-in streaming support for spectators
- **Anti-bot protection** with hotkey detection
- **Stamina system** for balanced gameplay
- **Premium account features** with configurable free premium
- **Market system** with player-to-player trading
- **Admin tools** and GM commands

### Technical Features
- **Lua scripting** for custom events, spells, and actions
- **MySQL database** backend for data persistence
- **Multi-threaded architecture** for high performance
- **Protocol compatibility** with Tibia clients
- **Cross-platform support** (Windows, Linux, macOS)

## 🛠️ System Requirements

### Dependencies
- **C++11 compatible compiler** (GCC 4.9+, Clang 3.5+, MSVC 2015+)
- **CMake 2.8+** for building
- **MySQL 5.6+** or **MariaDB 10.0+**
- **Boost 1.53.0+** (system, iostreams)
- **Lua 5.1+** or **LuaJIT** (recommended)
- **PugiXML**
- **GMP library**

### Recommended Hardware
- **CPU**: Multi-core processor (2+ cores)
- **RAM**: 2GB+ (depends on player count)
- **Storage**: 1GB+ free space
- **Network**: Stable internet connection

## 🚀 Installation

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/odirion-mmoserver.git
cd odirion-mmoserver
```

### 2. Install Dependencies

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install build-essential cmake libmysqlclient-dev \
    libboost-system-dev libboost-iostreams-dev liblua5.1-0-dev \
    libpugixml-dev libgmp3-dev
```

**CentOS/RHEL:**
```bash
sudo yum install gcc-c++ cmake mysql-devel boost-devel \
    lua-devel pugixml-devel gmp-devel
```

### 3. Compile the Server
```bash
mkdir build && cd build
cmake ..
make -j$(nproc)
```

### 4. Database Setup
1. Create a MySQL database for the server
2. Import the database schema (usually `schema.sql`)

### 5. Configuration
Copy and edit the configuration file:
```bash
cp config.lua.dist config.lua
nano config.lua
```

### Server Settings
```lua
-- Network configuration
ip = "127.0.0.1"
gameProtocolPort = 7172
loginProtocolPort = 7171
statusProtocolPort = 7171
```

### Database Configuration
```lua
-- MySQL Database
mysqlHost = "127.0.0.1"
mysqlUser = "otserv"
mysqlPass = "password"
mysqlDatabase = "otserv"
mysqlPort = 3306
```

### Game Rates
```lua
-- Experience and skill rates
rateExp = 5
rateSkill = 3
rateLoot = 2
rateMagic = 3
rateSpawn = 1
```

### Advanced Features
```lua
-- Enable live casting
enableLiveCasting = true

-- Premium account settings
freePremium = false

-- PvP configuration
worldType = "pvp"  -- Options: "pvp", "no-pvp", "pvp-enforced"
```

## 🎯 Usage

### Starting the Server
```bash
./tfs
```

### Basic Commands
- **Shutdown**: Use `Ctrl+C` or send SIGTERM
- **Reload**: Some configurations support hot-reload
- **Logs**: Check console output and log files

### GM Commands (In-Game)
- `/reload` - Reload scripts and configurations
- `/teleport` - Teleport to locations
- `/summon` - Summon creatures or players
- `/kick` - Kick players from server

### Third-Party Licenses
- **The Forgotten Server**: GPL v2.0
- **Boost Libraries**: Boost Software License
- **MySQL**: GPL v2.0 (client library)

## 🆘 Support

### Getting Help
- **Issues**: Report bugs and request features via GitHub Issues
- **Documentation**: Check the code comments and configuration examples
- **Community**: Join discussions in project forums or Discord

### Common Issues
- **Database connection errors**: Verify MySQL credentials and database existence
- **Compilation errors**: Ensure all dependencies are installed
- **Port conflicts**: Check that configured ports are available
- **Permission issues**: Ensure proper file permissions for logs and data

## 🔧 Development

### Building for Development
```bash
# Debug build
cmake -DCMAKE_BUILD_TYPE=Debug ..
make -j$(nproc)

# Enable additional debugging
cmake -DCMAKE_BUILD_TYPE=Debug -DDEBUG_MODE=ON ..
```

### Code Style
- Use **4 spaces** for indentation
- Follow **C++11** standards
- Use **descriptive variable names**
- Add **comments** for complex logic

## 📊 Performance

### Optimization Tips
- Enable database optimization: `startupDatabaseOptimization = true`
- Adjust spawn rates based on server capacity
- Monitor memory usage with high player counts
- Use LuaJIT instead of standard Lua for better performance

---

**Odirion MMO Server** - Bringing communities together through immersive multiplayer gaming experiences.
