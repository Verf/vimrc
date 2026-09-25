-- 必须在启动读取目录之前注册，不能延迟到 UIEnter。
Config.now(function() require('plugins.files').setup() end)
