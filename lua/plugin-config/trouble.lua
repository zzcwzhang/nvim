local status, trouble = pcall(require, "trouble")
if not status then
  vim.notify("没有找到 trouble")
  return
end

-- trouble.setup()
