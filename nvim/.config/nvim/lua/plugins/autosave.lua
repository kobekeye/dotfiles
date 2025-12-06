return {
  "pocco81/auto-save.nvim",
  event = { "InsertLeave", "TextChanged" }, -- 延遲載入，直到這些事件發生
  config = function()
    -- 這邊放入你提供的完整設定
    require("auto-save").setup({
      enabled = true, -- 啟用自動儲存
      execution_message = {
        message = function()
          -- 儲存時顯示的訊息
          return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
        dim = 0.18, -- 訊息顏色的亮度
        cleaning_interval = 1250, -- 訊息自動清除的時間
      },
      trigger_events = { "InsertLeave", "TextChanged" }, -- 觸發儲存的事件
      -- 決定是否要儲存的條件函式
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")

        -- 檢查緩衝區是否可修改，且檔案類型不是在排除列表中
        if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
          return true -- 符合條件，可以儲存
        end
        return false -- 不儲存
      end,
      write_all_buffers = false, -- 當前檔案儲存時，是否要儲存所有已開啟的檔案
      debounce_delay = 135, -- 儲存的延遲時間（毫秒），避免過於頻繁
      callbacks = { -- 在不同階段執行的回呼函式
        enabling = nil,
        disabling = nil,
        before_asserting_save = nil,
        before_saving = nil,
        after_saving = nil,
      },
    })
  end,
}
