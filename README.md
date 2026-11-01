### Protea

> Compute boids with Triadica controls in WebGPU

Previews on https://webgpu.art/protea/

Based on https://webgpu.github.io/webgpu-samples/samples/computeBoids .

Search parameters:

- `remote-control` to enable remote control,
- `control-host` to set remote control host,
- `control-port` to set remote control port.

To use Protea, try [Protea TypeScript workflow](https://github.com/Triadica/protea-ts-workflow).

### Calcit demo development

使用者影响：Demo 配对正式 Calcit CLI / `@calcit/procs` **0.32.1**，使用 Node 24、
Yarn 4.18.0 和 Caps 0.1.1。需要重新安装依赖并构建；TypeScript 库 API、npm 版本、
WGSL、图片和原发布/部署路径保持，本次不发布 npm。

模块配对精确正式 HUD Nav 0.0.10、Respo 0.17.1、UI 0.9.0、Reel 0.7.0；
UI 发布图中的 Router 0.9.0-alpha.4 保留。30 个定义的执行代码、schema、文档、测试元数据
在官方规范化前后视图中完全一致，仅迁移类型标注存储语法。

renderer 的真实事件入口沿用 Enum，回调先检查 `enum?` 再派发；
现有 Store/updater 的字段解码、函数身份检查和 Number/Bool 渲染参数合同保持。
`hud!` 的构建及 shader 错误提示保留，remote-control 仍需显式启用。
原存储监听/恢复代码继续禁用，正常刷新回到原默认模型，不宣称有持久化恢复功能。

```sh
caps --strict --ci
corepack yarn install --immutable
caps verify --toolchain
calcit --check-only --all-defs
calcit fix --workflow strict --verify
corepack yarn build
corepack yarn compile
```

`compile` 是原 TypeScript 声明构建；开发时先用 `calcit calcit.cirru js` 生成 Demo，
再运行 `yarn vite`，持续编辑可另开终端运行 `calcit calcit.cirru -w`。
源码仅用 `calcit.cirru`、`deps.cirru`；生成的 js-out/dist/lib 不提交。
新解析候选 npm 版本采用 60 分钟包龄，无单包例外；正常复用 lock 不重新等待。

本轮 Caps 六模块与工具链配对、immutable 安装、208/208 全定义（含依赖）、
完整 strict passed / diagnostics=[]、五 namespace 公开定义 30/30、原 TypeScript 编译
和前端构建均通过。deprecated-call、dynamic-method、应用 unsafe 为零。
没有 attached tests，原 `yarn test` 是明确失败的占位符，不将它或零测试写成验收通过。
实际 WebGPU 页面经 HUD 切换 Fireworks、Lorenz 并绘制，切换后刷新回到原默认模型，
error/warn 为空；未启用远程控制，未做物理 gamepad 验收，也不覆盖全部 30 个模型。
原 bundle 超过 500 kB 的构建提示保留，不通过提高阈值掩盖。

Actions 保留全部原门禁，PR 只检查和构建；仍仅 main 上传 dist/assets 到
`https://cos-sh.tiye.me/WebGPU-Art/protea/assets/`，使用 COS Action 内置 verify，
不增加校验脚本。npm release workflow 与前端服务器目录不变；本轮不合并或部署。

旧 TypeScript `@triadica/touch-control@0.0.4-a1` 继续保留：实际导入渲染、状态、Atom
和向量运算，不能以 Calcit 模块 tag 或 CSS 分发包直接替换。正式分发缺口需要单独处理，
不在本次仅迁移 Calcit 的改动中冒充已清除 alpha 依赖。

### API

Main API of Protea is a function to pass buffers and shaders:

```ts
async function createRenderer(
  canvas: HTMLCanvasElement,
  computeOptions: {
    seedSize: number;
    seedData: Float32Array;
    params: number[];
    computeShader: string;
  },
  renderOptions: {
    vertexCount: number;
    vertexData: number[];
    vertexBufferLayout: GPUVertexBufferLayout[];
    indexData?: number[];
    renderShader: string;
  }
): RenderFn;
```

There are two phases running Protea demos:

- Compute shader to iterate ping/pong buffers, which hold information about points,
- Render shader to illustrate position and velocity of points.

The pipelines are reused, while parameters can be passed from main function.

This project is still in early stage and I used it for drawing interesting patterns.

### Shaders

- `#import protea::perspective` to import uniform and perspective function.
- `#import protea::colors` to import `hsl` function for intuitive color definition.

### Replace Parameters

To hot replace spin speed:

```js
window.__hotUpdateParams([0.1, 1.6, 0.12, 0.7]);
```

4 paramters are:

- `speed`
- `length` of stroke
- `width` of stroke
- `opacity`

### Bind Groups

Bindings in shader:

```wgsl
@group(0) @binding(0) var<uniform> uniforms: UniformData;
@group(0) @binding(1) var<uniform> params: Params;

@group(1) @binding(0) var<storage, read> particles_a: Particles;
@group(1) @binding(1) var<storage, read_write> particles_b: Particles;
```

shaders is mocked to be unified in both compute shader and fragment shader.

### Gamepad Manual

![Default Mode](./assets/protea-default.png)

"Roll mode" means to earier to roll the camera,

![Roll Mode](./assets/protea-roll.png)

### Licence

MIT
