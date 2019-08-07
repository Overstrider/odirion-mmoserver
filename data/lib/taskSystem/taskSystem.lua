TaskSystem = {}

TaskSystem.Repeteable = false
TaskSystem.PlayerInPartyMaxCount = 4
TaskSystem.MaxTasksInSameTime = 2

TaskSystem.EachVocation = true

TaskSystem.DifficultyLevel = {
    ["Military"] = 1,
    ["Hunter"] = 2,
    ["BlueDjinn"] = 3,
    ["GreenDjinn"] = 4,
    ["Slayer"] = 5,
    ["Inquisitor"] = 6,   
}

TaskSystem.DifficultyLevelOrdened = {
    [1] = "military",
    [2] = "hunter",
    [3] = "bluedjinn",
    [4] = "greendjinn",
    [5] = "slayer",
    [6] = "inquisitor",   
}

TaskSystem.StorageValue = {
    noTask = -1,
    inTask = 1,
    finishedTask = 2,
}

TaskSystem.MonsterList = {
    ["troll"] = {
        monsterList = {"troll","frost troll","swamp troll"},        
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 30,
        reward = {
            itemList = {},
            exp = 1200,
            money = 300,
        },
        storages = {
            id = 851001,
            count = 852001,
            site = 853001,
        },
    },
    ["goblin"] = {
        monsterList = {"goblin"},        
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 50,
        reward = {
            itemList = {},
            exp = 2500,
            money = 300,
        },
        storages = {
            id = 851002,
            count = 852002,
            site = 853002,
        },
    },
    ["orc"] = {
        monsterList = {"orc","orc spearman","orc warrior"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 50,
        reward = {
            itemList = {{2428,1}},
            exp = 3000,
            money = 400,
        },
        storages = {
            id = 851016,
            count = 852016,
            site = 200266,
        },
    },
    ["rotworm"] = {
        monsterList = {"rotworm"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 50,
        reward = {
            itemList = {},
            exp = 4000,
            money = 400,
        },
        storages = {
            id = 851003,
            count = 852003,
            site = 853003,
        },
    },
    ["minotaur"] = {
        monsterList = {"minotaur","minotaur guard","minotaur archer"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 50,
        reward = {
            itemList = {},
            exp = 5000,
            money = 500,
        },
        storages = {
            id = 851015,
            count = 852015,
            site = 200265,
        },
    },
    ["stalker"] = {
        monsterList = {"stalker"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 30,
        reward = {
            itemList = {{2311,40}},
            exp = 5400,
        },
        storages = {
            id = 851005,
            count = 852005,
            site = 853005,
        },
    },
    ["skeleton"] = {
        monsterList = {"skeleton"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 80,
        reward = {
            itemList = {},
            exp = 5600,
            money = 500,
        },
        storages = {
            id = 851011,
            count = 852011,
            site = 200261,
        },
    },
    ["slime"] = {
        monsterList = {"slime"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 20,
        reward = {
            itemList = {},
            exp = 6400,
            money = 600,
        },
        storages = {
            id = 851020,
            count = 852020,
            site = 200270,
        },
    },
    ["fire devil"] = {
        monsterList = {"fire devil"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 30,
        reward = {
            itemList = {{2383,1}},
            exp = 6600,        
        },
        storages = {
            id = 851022,
            count = 852022,
            site = 200270,
        },
    },
    ["amazon"] = {
        monsterList = {"amazon", "valkyrie"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 50,
        reward = {
            itemList = {},
            exp = 7250,
            money = 700,
        },
        storages = {
            id = 851009,
            count = 852009,
            site = 200259,
        },
    },
    ["ghoul"] = {
        monsterList = {"ghoul"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 50,
        reward = {
            itemList = {},
             exp = 8500,
             money = 800,
            },
        storages = {
            id = 851021,
            count = 852021,
            site = 200271,
        },
    },
    ["larva"] = {
        monsterList = {"larva"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 100,
        reward = {
            itemList = {{2394,1}},
            exp = 8800,
        },
        storages = {
            id = 851014,
            count = 852014,
            site = 200264,
        },
    },
    ["mummy"] = {
        monsterList = {"mummy"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 30,
        reward = {
            itemList = {{2162,1}},
            exp = 9000,
        },
        storages = {
            id = 851041,
            count = 852041,
            site = 200291,
        },
    },
    ["cyclops"] = {
        monsterList = {"cyclops"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 80,
        reward = {
            itemList = {{2490,1}},
            exp = 15000,
        },
        storages = {
            id = 851031,
            count = 852031,
            site = 200281,
        },
    },
    ["crypt shambler"] = {
        monsterList = {"crypt shambler"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 50,
        reward = {
            itemList = {},
            exp = 19500,
            money = 1500,
        },
        storages = {
            id = 854040,
            count = 855040,
            site = 856040,
        },
    },
    ["dwarf"] = {
        monsterList = {"dwarf", "dwarf soldier"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 200,
        reward = {
            itemList = {{2525,1}},
            exp = 22500,
        },
        storages = {
            id = 851006,
            count = 852006,
            site = 853006,
        },
    },
    ["scarab"] = {
        monsterList = {"scarab"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 100,
        reward = {
            itemList = {{2540,1}},
            exp = 24000,
        },
        storages = {
            id = 851018,
            count = 852018,
            site = 200268,
        },
    },
    ["carniphila"] = {
        monsterList = {"carniphila"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 80,
        reward = {
            itemList = {},
            exp = 30000,
            money = 3000,
        },
        storages = {
            id = 851007,
            count = 852007,
            site = 200257,
        },
    },
    ["humans"] = {
        monsterList = {"hunter","wild warrior","bandit","smuggler"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 300,
        reward = {
            itemList = {{2489,1}},
            exp = 39000,
        },
        storages = {
            id = 851013,
            count = 852013,
            site = 200263,
        },
    },
    ["elf"] = {
        monsterList = {"elf","elf scout","elf arcanist"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 300,
        reward = {
            itemList = {},
            exp = 45000,
            money = 2000,
        },
        storages = {
            id = 851008,
            count = 852008,
            site = 200258,
        },
    },
    ["gargoyle"] = {
        monsterList = {"gargoyle"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 150,
        reward = {
            itemList = {},
            exp = 45000,
            money = 3000,
        },
        storages = {
            id = 851029,
            count = 852029,
            site = 200279,
        },
    },
    ["stone golem"] = {
        monsterList = {"stone golem"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 150,
        reward = {
            itemList = {},
            exp = 48000,
            money = 3500,
        },
        storages = {
            id = 851044,
            count = 852044,
            site = 200244,
        },
    },
    ["tarantula"] = {
        monsterList = {"tarantula"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 300,
        reward = {
            itemList = {{2647,1}},
            exp = 54000,
        },
        storages = {
            id = 851019,
            count = 852019,
            site = 200269,
        },
    },
    ["apes"] = {
        monsterList = {"sibang","kongra","merlkin"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 500,
        reward = {
            itemList = {},
            exp = 100000,
            money = 4000,
        },
        storages = {
            id = 851023,
            count = 852023,
            site = 200273,
        },
    },
    ["lizard"] = {
        monsterList = {"lizard sentinel","lizard snakecharmer","lizard templar"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 500,
        reward = {
            itemList = {},
            exp = 120000,
            money = 5000,
        },
        storages = {
            id = 851057,
            count = 852057,
            site = 200307,
        },
    },
    ["dwarf guard"] = {
        monsterList = {"dwarf guard"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 300,
        reward = {
            itemList = {},
            exp = 99000,
            money = 4000,
        },
        storages = {
            id = 851035,
            count = 852035,
            site = 200285,
        },
    },
    ["beholder"] = {
        monsterList = {"beholder"},
        difficult = TaskSystem.DifficultyLevel.Military;
        count = 500,
        reward = {
            itemList = {},
            exp = 120000,
            money = 10000,
        },
        storages = {
            id = 851010,
            count = 852010,
            site = 200260,
        },
    },
--[[
  Task Hunter
--]]
["minotaur"] = {
        monsterList = {"minotaur","minotaur guard","minotaur archer","minotaur mage"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 1000,
        reward = {
            itemList = {{7134,1}},
            exp = 166667,
        },
        storages = {
            id = 851028,
            count = 852028,
            site = 200278,
        },
    },
    ["cyclops warrior"] = {
        monsterList = {"cyclops warrior"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 600,
        reward = {
            itemList = {{7134,1}},
            exp = 240000,
        },
        storages = {
            id = 851032,
            count = 852032,
            site = 200282,
        },
    },
    ["dwarf guard"] = {
        monsterList = {"dwarf guard"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 500,
        reward = {
            itemList = {{7134,1}},
            exp = 133333,
        },
        storages = {
            id = 851036,
            count = 852036,
            site = 200286,
        },
    },
    ["beholder"] = {
        monsterList = {"beholder"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 600,
        reward = {
            itemList = {{7134,1}},
            exp = 136000,
        },
        storages = {
            id = 851040,
            count = 852040,
            site = 200290,
        },
    },
    ["elder beholder"] = {
        monsterList = {"elder beholder"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 600,
        reward = {
            itemList = {{7134,1}},
            exp = 224000,
        },
        storages = {
            id = 851045,
            count = 852045,
            site = 200295,
        },
    },
    ["demon skeleton"] = {
        monsterList = {"demon skeleton"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 400,
        reward = {
            itemList = {{7134,1}},
            exp = 130667,
        },
        storages = {
            id = 851046,
            count = 852046,
            site = 200296,
        },
    },
    ["bonebeast"] = {
        monsterList = {"bonebeast"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 400,
        reward = {
            itemList = {{7134,1}},
            exp = 386667,
        },
        storages = {
            id = 851053,
            count = 852053,
            site = 200303,
        },
    },
    ["necromancer"] = {
        monsterList = {"necromancer","priestess"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 400,
        reward = {
            itemList = {{7134,1}},
            exp = 266667,
        },
        storages = {
            id = 851039,
            count = 852039,
            site = 200289,
        },
    },
    ["vampire"] = {
        monsterList = {"vampire"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 400,
        reward = {
            itemList = {{7134,1}},
            exp = 170667,
        },
        storages = {
            id = 851043,
            count = 852043,
            site = 200293,
        },
    },
    ["orc hard"] = {
        monsterList = {"orc warlord","orc leader"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 1000,
        reward = {
            itemList = {{7134,1}},
            exp = 666667,
        },
        storages = {
            id = 851042,
            count = 852042,
            site = 200292,
        },
    },
    ["dragon"] = {
        monsterList = {"dragon"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 1000,
        reward = {
            itemList = {{7134,1}},
            exp = 933333,
        },
        storages = {
            id = 851033,
            count = 852033,
            site = 200283,
        },
    },
    ["ancient scarab"] = {
        monsterList = {"ancient scarab"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 800,
        reward = {
            itemList = {{7134,1}},
            exp = 768000,
        },
        storages = {
            id = 851024,
            count = 852024,
            site = 200274,
        },
    },
    ["lich"] = {
        monsterList = {"lich"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 300,
        reward = {
            itemList = {{7134,1}},
            exp = 360000,
        },
        storages = {
            id = 851027,
            count = 852027,
            site = 200277,
        },
    },
    ["giant spider"] = {
        monsterList = {"giant spider"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 700,
        reward = {
            itemList = {{7134,1}},
            exp = 840000,
        },
        storages = {
            id = 851037,
            count = 852037,
            site = 200287,
        },
    },
    ["icegiant"] = {
        monsterList = {"icegiant"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 300,
        reward = {
            itemList = {{7134,1}},
            exp = 360000,
        },
        storages = {
            id = 851069,
            count = 852069,
            site = 200319,
        },
    },
    ["icegiant spellcaster"] = {
        monsterList = {"icegiant spellcaster"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 300,
        reward = {
            itemList = {{7134,1}},
            exp = 560000,
        },
        storages = {
            id = 851070,
            count = 852070,
            site = 200320,
        },
    },
    ["icegiant guard"] = {
        monsterList = {"icegiant guard"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 200,
        reward = {
            itemList = {{7134,1}},
            exp = 600000,
        },
        storages = {
            id = 851071,
            count = 852071,
            site = 200321,
        },
    },
    ["hero"] = {
        monsterList = {"hero"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 500,
        reward = {
            itemList = {{7134,1}},
            exp = 320000,
        },
        storages = {
            id = 851038,
            count = 852038,
            site = 200288,
        },
    },
    ["black knight"] = {
        monsterList = {"black knight"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 600,
        reward = {
            itemList = {{7134,1}},
            money = 426667,
        },
        storages = {
            id = 851030,
            count = 852030,
            site = 200280,
        },
    },
    ["banshee"] = {
        monsterList = {"banshee"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 300,
        reward = {
            itemList = {{7134,1}},
            exp = 360000,
        },
        storages = {
            id = 851026,
            count = 852026,
            site = 200276,
        },
    },
    ["giant ant"] = {
        monsterList = {"giant ant"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 300,
        reward = {
            itemList = {{7134,1}},
            exp = 180000,
        },
        storages = {
            id = 851054,
            count = 852054,
            site = 200304,
        },
    },
    ["quartz golem"] = {
        monsterList = {"quartz golem"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 200,
        reward = {
            itemList = {{7134,1}},
            exp = 333333,
        },
        storages = {
            id = 851054,
            count = 854057,
            site = 200304,
        },
    },
    ["dwarf brewmaster"] = {
        monsterList = {"dwarf brewmaster"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 300,
        reward = {
            itemList = {{7134,1}},
            exp = 386667,
        },
        storages = {
            id = 851054,
            count = 852054,
            site = 200304,
        },
    },
    ["dwarf warrior"] = {
        monsterList = {"dwarf warrior"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 300,
        reward = {
            itemList = {{7134,1}},
            exp = 600000,
        },
        storages = {
            id = 851054,
            count = 856054,
            site = 200304,
        },
    },
    ["dwarf berserker"] = {
        monsterList = {"dwarf berserker"},
        difficult = TaskSystem.DifficultyLevel.Hunter;
        count = 300,
        reward = {
            itemList = {{7134,1}},
            exp = 1000000,
        },
        storages = {
            id = 851054,
            count = 857054,
            site = 200304,
        },
    },
--[[
  Task Blue Djinn
--]]   
    ["blue djinn"] = {
        monsterList = {"blue djinn"},
        difficult = TaskSystem.DifficultyLevel.BlueDjinn;
        count = 50,
        reward = {
            itemList = {},
            exp = 0,
        },
        storages = {
            id = 851055,
            count = 852055,
            site = 200305,
        },
    },
--[[
  Task Green Djinn
--]]
   ["green djinn"] = {
        monsterList = {"green djinn"},
        difficult = TaskSystem.DifficultyLevel.GreenDjinn;
        count = 50,
        reward = {
            itemList = {},
            exp = 0,
        },
        storages = {
            id = 851056,
            count = 852056,
            site = 200306,
        },
    },
--[[
  Task Slayer
--]]
    ["dragon lord"] = {
        monsterList = {"dragon lord"},
        difficult = TaskSystem.DifficultyLevel.Slayer;
        count = 500,
        reward = {
            exp = 700000,
        },
        storages = {
            id = 851034, 
            count = 852034,
            site = 200284,
        },
    },
    ["behemoth"] = {
        monsterList = {"behemoth"},
        difficult = TaskSystem.DifficultyLevel.Slayer;
        count = 500,
        reward = {
            exp = 833333,
        },
        storages = {
            id = 851047,
            count = 852047,
            site = 200297,
        },
    },
    ["warlock"] = {
        monsterList = {"warlock"},
        difficult = TaskSystem.DifficultyLevel.Slayer;
        count = 500,
        reward = {
            exp = 1333333,
        },
        storages = {
            id = 851048,
            count = 852048,
            site = 200298,
        },
    },
    ["demon"] = {
        monsterList = {"demon"},
        difficult = TaskSystem.DifficultyLevel.Slayer;
        count = 500,
        reward = {
            itemList = {},
            exp = 2000000,
        },
        storages = {
            id = 851049,
            count = 852049,
            site = 200299,
        },
    },
    ["hydra"] = {
        monsterList = {"hydra"},
        difficult = TaskSystem.DifficultyLevel.Slayer;
        count = 500,
        reward = {
            itemList = {{2498, 1}},
            exp = 700000,
        },
        storages = {
            id = 851050,
            count = 852050,
            site = 200300,
        },
    },
    ["serpent spawn"] = {
        monsterList = {"serpent spawn"},
        difficult = TaskSystem.DifficultyLevel.Slayer;
        count = 500,
        reward = {
            itemList = {},
            exp = 1000000,
        },
        storages = {
            id = 851051,
            count = 852051,
            site = 200301,
        },
    },  
    ["icegiant guard"] = {
        monsterList = {"icegiant guard"},
        difficult = TaskSystem.DifficultyLevel.Slayer;
        count = 500,
        reward = {
            itemList = {},
            exp = 1000000,
        },
        storages = {
            id = 851058,
            count = 852058,
            site = 200308,
        },
    },
    ["yeti"] = {
        monsterList = {"yeti"},
        difficult = TaskSystem.DifficultyLevel.Slayer;
        count = 500,
        reward = {
            itemList = {},
            exp = 1000000,
        },
        storages = {
            id = 851052,
            count = 852052,
            site = 200302,
        },
    },  
    ["obsidian golem"] = {
        monsterList = {"obsidian golem"},
        difficult = TaskSystem.DifficultyLevel.Slayer;
        count = 500,
        reward = {
            itemList = {},
            exp = 1000000,
        },
        storages = {
            id = 851059,
            count = 852059,
            site = 200309,
        },
    },     
    ["polar dragon"] = {
        monsterList = {"polar dragon"},
        difficult = TaskSystem.DifficultyLevel.Slayer;
        count = 500,
        reward = {
            itemList = {{2222,1}},
            exp = 2000000,
        },
        storages = {
            id = 851060,
            count = 852060,
            site = 200310,
        },
    },
--[[
  Task Inquisitor
--]]
    ["dragon lord"] = {
        monsterList = {"dragon lord"},
        difficult = TaskSystem.DifficultyLevel.Inquisitor;
        count = 5000,
        reward = {
            itemList = {{2506,1}},
            exp = 7000000,
        },
        storages = {
            id = 851072,
            count = 852072,
            site = 200322,
        },
    },
    ["behemoth"] = {
        monsterList = {"behemoth"},
        difficult = TaskSystem.DifficultyLevel.Inquisitor;
        count = 6000,
        reward = {
            itemList = {{7423,1}},
            exp = 10000000,
        },
        storages = {
            id = 851073,
            count = 852073,
            site = 200323,
        },
    },
    ["warlock"] = {
        monsterList = {"warlock"},
        difficult = TaskSystem.DifficultyLevel.Inquisitor;
        count = 4000,
        reward = {
            itemList = {{7417,1}},
            exp = 10666667,
        },
        storages = {
            id = 851074,
            count = 852074,
            site = 200324,
        },
    },
    ["demon"] = {
        monsterList = {"demon"},
        difficult = TaskSystem.DifficultyLevel.Inquisitor;
        count = 6666,
        reward = {
            itemList = {{2495,1}},
            exp = 29623704,
        },
        storages = {
            id = 851075,
            count = 852075,
            site = 200325,
        },
    },
    ["hydra"] = {
        monsterList = {"hydra"},
        difficult = TaskSystem.DifficultyLevel.Inquisitor;
        count = 5000,
        reward = {
            itemList = {{7416,1}},
            exp = 7000000,
        },
        storages = {
            id = 851076,
            count = 852076,
            site = 200326,
        },
    },
    ["serpent spawn"] = {
        monsterList = {"serpent spawn"},
        difficult = TaskSystem.DifficultyLevel.Inquisitor;
        count = 4000,
        reward = {
            itemList = {{7418,1}},
            exp = 8133333,
        },
        storages = {
            id = 851077,
            count = 852077,
            site = 200327,
        },
    },  
    ["icegiant guard"] = {
        monsterList = {"icegiant guard"},
        difficult = TaskSystem.DifficultyLevel.Inquisitor;
        count = 5000,
        reward = {
            itemList = {{6096,1}},
            exp = 10000000,
        },
        storages = {
            id = 851078,
            count = 852078,
            site = 200328,
        },
    },
    ["yeti"] = {
        monsterList = {"yeti"},
        difficult = TaskSystem.DifficultyLevel.Inquisitor;
        count = 5000,
        reward = {
            itemList = {{2496,1}},
            exp = 10166667,
        },
        storages = {
            id = 851079,
            count = 852079,
            site = 200329,
        },
    },  
    ["obsidian golem"] = {
        monsterList = {"obsidian golem"},
        difficult = TaskSystem.DifficultyLevel.Inquisitor;
        count = 5000,
        reward = {
            itemList = {{7150,1}},
            exp = 10000000,
        },
        storages = {
            id = 851080,
            count = 852080,
            site = 200330,
        },
    },     
    ["polar dragon"] = {
        monsterList = {"polar dragon"},
        difficult = TaskSystem.DifficultyLevel.Inquisitor;
        count = 4000,
        reward = {
            itemList = {{7103,1}},
            exp = 16000000,
        },
        storages = {
            id = 851081,
            count = 852081,
            site = 200331,
        },
    },
}

function TaskSystem.GetDifficultyList(self)
    local taskDifficulty = ""

    for level, difficulty in ipairs(self.DifficultyLevelOrdened) do
        taskDifficulty = taskDifficulty.. difficulty

        if level < #self.DifficultyLevelOrdened - 2 then
            taskDifficulty = taskDifficulty.. ", "
        elseif level < #self.DifficultyLevelOrdened - 1 then
            taskDifficulty = taskDifficulty.. " or "
        end
    end

    return taskDifficulty
end

function TaskSystem.GetTaskList(self, difficultyLevel)
    local taskList = ""
    local hasLast = false
    difficultyLevel = difficultyLevel or 0

    for taskName, taskInfo in pairs(self.MonsterList) do
        if difficultyLevel == 0 or difficultyLevel == taskInfo.difficult then
            if hasLast then
                taskList = taskList.. ", "
            end

            taskList = taskList.. taskInfo.count.. " {".. taskName.. "}"
            hasLast = true
        end
    end

    return taskList
end

function TaskSystem.GetTaskInfoByDifficulty(self, difficultyLevel)
    local taskList = {}

    for taskName, taskInfo in pairs(self.MonsterList) do
        if difficultyLevel == taskInfo.difficult then
            taskList[taskName] = taskInfo
        end
    end

    return taskList
end

function TaskSystem.GetCompletedTasksFromPlayer(self, cid)
    local completedTasks = {}

    for taskName, taskInfo in pairs(self.MonsterList) do
        if getPlayerStorageValue(cid, taskInfo.storages.id) == self.StorageValue.inTask and getPlayerStorageValue(cid, taskInfo.storages.count) >= taskInfo.count then
            table.insert(completedTasks, taskName)
        end
    end

    return completedTasks
end

function TaskSystem.GetTasksInProgressFromPlayer(self, cid)
    local inProgress = {}

    for taskName, taskInfo in pairs(self.MonsterList) do
        if getPlayerStorageValue(cid, taskInfo.storages.id) == self.StorageValue.inTask then
            table.insert(inProgress, taskName)
        end
    end

    return inProgress
end

function TaskSystem.GetTasksCountFromPlayer(self, cid, taskInfo)
    local count = 0

    if getPlayerStorageValue(cid, taskInfo.storages.id) == self.StorageValue.inTask then
        count = getPlayerStorageValue(cid, taskInfo.storages.count)
    end

    return count
end

function TaskSystem.AddRewardToPlayer(self, cid, taskInfo)
	if taskInfo.reward.exp then
        doPlayerAddExp(cid, taskInfo.reward.exp)
    end
    if taskInfo.reward.money then
        doPlayerAddMoney(cid, taskInfo.reward.money)
    end
    if #taskInfo.reward.itemList > 0 then
    	for x = 1, #taskInfo.reward.itemList do
			doPlayerAddItem(cid, taskInfo.reward.itemList[x][1], taskInfo.reward.itemList[x][2])
		end
	end
	setPlayerStorageValue(cid, taskInfo.storages.id, self.StorageValue.finishedTask)
    -- setPlayerStorageValue(cid, taskInfo.storages.count, 0)
end

function TaskSystem.AddTaskToPlayer(self, cid, taskInfo)
    setPlayerStorageValue(cid, taskInfo.storages.id, self.StorageValue.inTask)
    setPlayerStorageValue(cid, taskInfo.storages.count, 0)
end

function TaskSystem.RemoveTaskFromPlayer(self, cid, taskInfo)
    setPlayerStorageValue(cid, taskInfo.storages.id, self.StorageValue.noTask)
    setPlayerStorageValue(cid, taskInfo.storages.count, 0)
end

function TaskSystem.AddTaskCountToPlayer(self, cid, taskInfo)
    if getPlayerStorageValue(cid, taskInfo.storages.id) == self.StorageValue.inTask then
        local currentCount = getPlayerStorageValue(cid, taskInfo.storages.count)
		if currentCount < taskInfo.count then
			setPlayerStorageValue(cid, taskInfo.storages.count, currentCount + 1)
			return true
		end
        return true
    end

    return false
end

function TaskSystem.AddTaskCountOnKillToPlayer(self, cid, taskName)
    local taskInfo = self.MonsterList[taskName]

    if getPlayerStorageValue(cid, taskInfo.storages.id) == self.StorageValue.inTask then
        self:AddTaskCountToPlayer(cid, taskInfo)

        local currentCount = getPlayerStorageValue(cid, taskInfo.storages.count)
        if currentCount == taskInfo.count then
            doPlayerSendTextMessage(cid, 18, "Congratulations! You finished the task of "..taskName..".")
        else
            doPlayerSendTextMessage(cid, 18, "Defeated total [" .. currentCount .. "/" .. taskInfo.count .. "] " .. taskName)
        end
    end
end

function TaskSystem.GetTaskNameByMonsterName(self, monstername)
    local monsterName = string.lower(monstername)
    local taskName = nil

    for taskname, taskinfo in pairs(TaskSystem.MonsterList) do
        for index, taskMonsterName in ipairs(taskinfo.monsterList) do
            if monsterName == taskMonsterName then
                taskName = taskname
                break
            end
        end

        if taskName then
            break
        end
    end

    return taskName
end

function TaskSystem.IsSharedPartyEnabled(self, cid, partyMembers)
	local sorcerer = 0
	local knight = 0
	local druid = 0
	local paladin = 0
    if not partyMembers then
        return false
    end
    if #partyMembers > TaskSystem.PlayerInPartyMaxCount and TaskSystem.EachVocation == false then
        return false
    end
    if TaskSystem.EachVocation == false then
		local partyMembersArray = {2,3,4}
        if isInArray(partyMembersArray, #partyMembers) == false then
            return false
        end
		if #partyMembers == 4 then
			for index, sid in ipairs(partyMembers) do
				if getPlayerVocation(sid) == 1 or getPlayerVocation(sid) == 5 then
					sorcerer = sorcerer + 1
				elseif getPlayerVocation(sid) == 2 or getPlayerVocation(sid) == 6 then
					druid = druid + 1
				elseif getPlayerVocation(sid) == 3 or getPlayerVocation(sid) == 7 then
					paladin = paladin + 1
				elseif getPlayerVocation(sid) == 4 or getPlayerVocation(sid) == 8 then
					knight = knight + 1
				end
			end
			if sorcerer > 1 or knight > 1 or paladin > 1 or druid > 1 then
				return false
			end
		end
    end
    if not Player(cid):getParty():isSharedExperienceActive() then
        return false
    end
return true
end