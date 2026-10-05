
A visual of Quaternion multiplication
----

> Based on [Quatrefoil](https://github.com/Quamolit/quatrefoil.calcit).

Demo http://r.tiye.me/Quatrefoil-GL/play-quaternion-multiply

Video: 四元数乘法可视化 https://www.bilibili.com/video/BV1if4y1t7Yq

### Workflow

https://github.com/Quatrefoil-GL/quatrefoil-workflow

COS 使用 Action 1.2 的 `public-base-url` 内置 verify，不增加独立上传校验脚本。
PR 预览按编号/run/attempt 隔离，生产前缀与原服务器 rsync 路径不变。
串行队列保留待处理任务；构建和上传分别设定超时。Calcit 从 `deps.cirru` 读取，
由 Caps 检查工具链一致性，不在工作流重复硬编码版本。

当前仍为正式 Calcit/procs 0.27.0；正式 0.28 的只读检查被已发布 Quatrefoil
0.1.5 的 Option/spread 旧用法阻塞，等待兼容模块发布，不使用 hash/新 alpha
绕过。本次部署改造不代表语言升级已完成。原 Caps 非 strict 图的 JS-FFI
版本冲突警告、类型债务及原入口/公开定义/类型门禁均保留。

### License

MIT
