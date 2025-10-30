local schedule = vim.schedule
local notify = vim.notify

local group = vim.api.nvim_create_augroup("auto-saver", { clear = true })

local MESSAGES = {
	autosave_enabled = "✅ Autosave enabled.",
	autosave_disabled = "❌ Autosave disabled.",
	autocommit_enabled = "✅ Autocommit enabled.",
	autocommit_disabled = "❌ Autocommit disabled.",
}

--- Создание автокоманд при установке соответствующих переменных среды ---

-- Автосохранение
if os.getenv("NVIM_AUTOSAVE") == "1" then
	vim.api.nvim_create_autocmd({ "FocusLost", "CursorHold", "InsertLeave" }, {
		group = group,
		pattern = "*",
		callback = function()
			schedule(function()
				notify("autosave called!", vim.log.levels.DEBUG)
			end)
		end,
	})

	schedule(function()
		notify(MESSAGES.autosave_enabled, vim.log.levels.INFO)
	end)
else
	schedule(function()
		notify(MESSAGES.autosave_disabled, vim.log.levels.INFO)
	end)
end

-- Автокоммиты
if os.getenv("NVIM_AUTOCOMMIT") == "1" then
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = group,
		pattern = "*",
		callback = function()
			schedule(function()
				notify("autocommit called!", vim.log.levels.DEBUG)
			end)
		end,
	})

	schedule(function()
		notify(MESSAGES.autocommit_enabled, vim.log.levels.INFO)
	end)
else
	schedule(function()
		notify(MESSAGES.autocommit_disabled, vim.log.levels.INFO)
	end)
end
