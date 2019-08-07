local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)
    npcHandler:onCreatureAppear(cid)
end

function onCreatureDisappear(cid)
    npcHandler:onCreatureDisappear(cid)
end

function onCreatureSay(cid, type, msg)
    npcHandler:onCreatureSay(cid, type, msg)
end

function onThink()
    npcHandler:onThink()
end

local guild_level = 4 -- Task Level / 4 = Green Djinn
local npclevel = TaskSystem.DifficultyLevel.GreenDjinn
function addTask(cid, message, keywords, parameters, node)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local taskInfo = TaskSystem.MonsterList[parameters.taskName]
    local inProgressTasks = TaskSystem:GetTasksInProgressFromPlayer(cid)
    if taskInfo then
        if #inProgressTasks >= TaskSystem.MaxTasksInSameTime then
            npcHandler:say('You already reached the limit of tasks at the same time.', cid)
        elseif getPlayerStorageValue(cid, taskInfo.storages.id) == TaskSystem.StorageValue.inTask then
            npcHandler:say('You are doing this task already.', cid)
        elseif getPlayerStorageValue(cid, taskInfo.storages.id) == TaskSystem.StorageValue.finishedTask then
            npcHandler:say('You have done this task already.', cid)
        elseif getPlayerStorageValue(cid, taskInfo.storages.id) == TaskSystem.StorageValue.noTask then
            TaskSystem:AddTaskToPlayer(cid, taskInfo)
            npcHandler:say("You have accepted this task, good luck!", cid)
        end
    end

    if(parameters.reset) then
        npcHandler:resetNpc(cid)
    elseif(parameters.moveup and type(parameters.moveup) == 'number') then
        npcHandler.keywordHandler:moveUp(parameters.moveup)
    end

    return true
end

function rewards(cid, message, keywords, parameters, node)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local npcMessage = ""
    local taskList = TaskSystem:GetCompletedTasksFromPlayer(cid)

    if #taskList > 0 then
        npcMessage = "What task you want to complete: "
        for index, taskName in ipairs(taskList) do
            npcMessage = npcMessage.. "{".. taskName.. "}"

            if #taskList > 1 and index ~= #taskList then
                npcMessage = npcMessage.. ", "
            end
        end
    else
        npcMessage = "Sorry, you don't complete any tasks."
    end

    npcHandler:say(npcMessage, cid)
    return true
end

function reward(cid, message, keywords, parameters, node)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local taskInfo = TaskSystem.MonsterList[''..message:lower()..'']
    if taskInfo then
        if getPlayerStorageValue(cid, taskInfo.storages.id) == TaskSystem.StorageValue.inTask then
            if getPlayerStorageValue(cid, taskInfo.storages.count) >= taskInfo.count then
                TaskSystem:AddRewardToPlayer(cid, taskInfo)
                npcHandler:say("Here is your reward from "..taskInfo.monsterList[1].." task.", cid)
            else
                npcHandler:say('You did not finished this task yet.', cid)
            end
        elseif getPlayerStorageValue(cid, taskInfo.storages.id) == TaskSystem.StorageValue.finishedTask then
            npcHandler:say('You already recive this reward.', cid)
        end

        if(parameters.reset) then
            npcHandler:resetNpc(cid)
        elseif(parameters.moveup and type(parameters.moveup) == 'number') then
            npcHandler.keywordHandler:moveUp(parameters.moveup)
        end
    else
        npcHandler:say('I\'m sorry but I can\'t get your task.', cid)
    end

    return true
end

function leaves(cid, message, keywords, parameters, node)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local npcMessage = ""
    local taskList = TaskSystem:GetTasksInProgressFromPlayer(cid)

    if #taskList > 0 then
        npcMessage = "What task you want to leave: "
        for index, taskName in ipairs(taskList) do
            local taskInfo = TaskSystem.MonsterList[taskName]
            local count = TaskSystem:GetTasksCountFromPlayer(cid, taskInfo)

            npcMessage = npcMessage.. "{".. taskName.. "} Total [" .. count .. "/" .. taskInfo.count .. "]"

            if #taskList > 1 and index ~= #taskList then
                npcMessage = npcMessage.. ", "
            end
        end
    else
        npcMessage = "Sorry, you dont have tasks to leave."
    end

    npcHandler:say(npcMessage, cid)
    return true
end

function leave(cid, message, keywords, parameters, node)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local taskInfo = TaskSystem.MonsterList[parameters.taskName]
    if getPlayerStorageValue(cid, taskInfo.storages.id) == TaskSystem.StorageValue.inTask then
        TaskSystem:RemoveTaskFromPlayer(cid, taskInfo)
        npcHandler:say('You leave from task: '.. parameters.taskName, cid)
    else
        npcHandler:say('Sorry, you dont have this task to leave.', cid)
    end

    if(parameters.reset) then
        npcHandler:resetNpc(cid)
    elseif(parameters.moveup and type(parameters.moveup) == 'number') then
        npcHandler.keywordHandler:moveUp(parameters.moveup)
    end

    return true
end


keywordHandler:addKeyword(
    {'help'},
    StdModule.say,
    {
        npcHandler = npcHandler,
        onlyFocus = true,
        text = "You want to do a {task}? or {leave}? can also {reward} she ended up awards!"
    }
)

local difficultyNpcSay = "We need to get rid of some {monsters}. If you already have a task, you will need to {leave} it."
local difficultysNode = keywordHandler:addKeyword(
    {'task'},
    StdModule.say,
    {
        npcHandler = npcHandler,
        onlyFocus = true,
        text = difficultyNpcSay,
    }
)

for difficulty, text in ipairs(TaskSystem.DifficultyLevelOrdened) do
    local taskNpcSay = "Tell me the breed of the monster that you want to hunt: ".. TaskSystem:GetTaskList(guild_level).. "."

    local difficultyNode = difficultysNode:addChildKeyword(
        {'monsters'},
        StdModule.say,
        {
            npcHandler = npcHandler,
            onlyFocus = true,
            text = taskNpcSay,
        }
    )

    for TaskName, TaskInfo in pairs(TaskSystem.MonsterList) do
        if TaskInfo.difficult == npclevel then
			local taskNode = difficultyNode:addChildKeyword(
				{TaskName},
				StdModule.say,
				{
					npcHandler = npcHandler,
					onlyFocus = true,
					text = 'Do you really want to kill '.. TaskInfo.count.. " ".. TaskName.. "?",
				}
			)

			local taskYes = taskNode:addChildKeyword(
				{'yes'},
				addTask,
				{
					npcHandler = npcHandler,
					onlyFocus = true,
					reset = true,
					taskName = TaskName
				}
			)

			taskNode:addChildKeyword(
				{'no'},
				StdModule.say,
				{
					npcHandler = npcHandler,
					onlyFocus = true,
					text = 'Alright then.',
					reset = true
				}
			)
		else
			local taskNode = difficultyNode:addChildKeyword(
				{TaskName},
				StdModule.say,
				{
					npcHandler = npcHandler,
					onlyFocus = true,
					reset = true,
					text = 'Sorry, but this task isn\'t of my order.',
				}
			)
		end
    end
end

local rewardsNode = keywordHandler:addKeyword(
    {'reward'},
    rewards,
    {
        npcHandler = npcHandler,
        onlyFocus = true,
    }
)

for TaskName, TaskInfo in pairs(TaskSystem.MonsterList) do
    local rewardNode = rewardsNode:addChildKeyword(
        {TaskName},
        reward,
        {
            npcHandler = npcHandler,
            onlyFocus = true,
            reset = true,
            taskName = TaskName
        }
    )
end

local leavesNode = keywordHandler:addKeyword(
    {'leave'},
    leaves,
    {
        npcHandler = npcHandler,
        onlyFocus = true,
    }
)

for TaskName, TaskInfo in pairs(TaskSystem.MonsterList) do
    local leaveNode = leavesNode:addChildKeyword(
        {TaskName},
        leave,
        {
            npcHandler = npcHandler,
            onlyFocus = true,
            reset = true,
            taskName = TaskName
        }
    )
end

npcHandler:addModule(FocusModule:new())
