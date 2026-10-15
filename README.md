
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

使用正式 Calcit/procs 0.29.3，入口明确为 JS/browser。采用已发布的
Quatrefoil 0.1.6 一致依赖组合：JS-FFI 0.2.2、Quaternion 0.2.12、
Pointed Prompt 0.0.17；不任意拼接冲突的新版本，不使用 alpha/hash。
Caps 使用 strict 安装，原入口、公开定义和类型门禁改用当前命令并保留。

组件返回具体 Component，轴线为 Shape；Number/Bool 与开放状态在真实
边界解码，不再靠强转。回调声明 Number/Bool 和 Unit dispatch 合同，
保留四元数左乘、迭代次数、标量提示、坐标和场景子节点顺序。
移除无用的 portal/tab 状态读取；非法输入会在解码边界更早报错。
COS 内置校验、预览隔离和原生产部署路径不变；不新增验证脚本或测试框架，
不提交生成目录，也不宣称开放类型债务已经清零。

0.30.0 仅用于额外预检；正式 0.30.1 配套可用后，仍需更新固定工具链并
重新验收，不能将本次过渡迁移视为已完成 0.30.1 升级。

### License

MIT
