-- this is the first file executed when the application starts
-- we have to load the first modules form here

-- setup logger

-- print first terminal message
g_logger.info("Odirion Online")

-- add data directory to the search path
if not g_resources.addSearchPath(g_resources.getWorkDir() .. "data", true) then
  g_logger.fatal("Unable to add data directory to the search path.")
end

-- add modules directory to the search path
if not g_resources.addSearchPath(g_resources.getWorkDir() .. "modules", true) then
  g_logger.fatal("Unable to add modules directory to the search path.")
end

-- try to add mods path too
g_resources.addSearchPath(g_resources.getWorkDir() .. "mods", true)

-- setup directory for saving configurations
if not g_resources.addSearchPath(g_resources.getWorkDir() .. "config", true) then
   g_resources.setWriteDir(g_resources.getWorkDir())
   g_resources.makeDir("config")
end
g_resources.setWriteDir(g_resources.getWorkDir() .. "config")

-- search all packages
g_resources.searchAndAddPackages('/', '.otpkg', true)

-- load settings
g_configs.loadSettings("/config.otml")
	
g_modules.discoverModules()

-- libraries modules 0-99
g_modules.autoLoadModules(99)
g_modules.ensureModuleLoaded("corelib")
g_modules.ensureModuleLoaded("gamelib")

-- client modules 100-499
g_modules.autoLoadModules(499)
g_modules.ensureModuleLoaded("client")

-- game modules 500-999
g_modules.autoLoadModules(999)
g_modules.ensureModuleLoaded("game_interface")

-- mods 1000-9999
g_modules.autoLoadModules(9999)

local script = '/' .. g_app.getCompactName() .. 'rc.lua'

if g_resources.fileExists(script) then
  dofile(script)
end