local M = {}
print("Hello my cucumber plugin")

-- Function to build the test command
M.buildRunNeasterScenarioCmd = function()
    local filetype = vim.bo.filetype
    local testCommand = ""
    if filetype == "cucumber" then
        local line_number = vim.fn.search('^scenario:', 'n')
        if line_number > 0 then
            testCommand = "npm run test:dev --feature " .. vim.fn.expand("%") .. ":" .. line_number
        else
            print("No scenario found in the current file")
        end
    end
    return testCommand
end

-- Function to build and execute the test command
M.runNearestScenario = function()
    local testCommand = M.buildRunNeasterScenarioCmd()
    if testCommand ~= "" then
        vim.cmd(
            'FloatermNew --height=0.8 --width=0.8 --wintype=float --autoclose=0 --name=cucumber-tests --position=center ' ..
            testCommand
        )
    else
        print("No test command found for the current file type")
    end
end

M.buildRunFeatureFileCmd = function()
    local filetype = vim.bo.filetype
    local testCommand = ""
    if filetype == "cucumber" then
        testCommand = "npm run test:dev --feature " .. vim.fn.expand("%")
    end
    return testCommand
end
-- Function to build and print the test command for running the entire file
M.runFeatureFileCmd = function()
    local testCommand = M.buildRunFeatureFileCmd()
    if testCommand ~= "" then
        vim.cmd(
            'FloatermNew --height=0.8 --width=0.8 --wintype=float --autoclose=0 --name=cucumber-tests --position=center ' ..
            testCommand
        )
    else
        print("No test command found for the current file type")
    end
end

return M
