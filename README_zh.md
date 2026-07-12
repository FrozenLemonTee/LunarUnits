# LunarUnits

[![CI](https://github.com/FrozenLemonTee/LunarUnits/actions/workflows/ci.yml/badge.svg)](https://github.com/FrozenLemonTee/LunarUnits/actions/workflows/ci.yml)

[English](README.md) | **简体中文**

[在线文档](https://frozenlemontee.github.io/LunarUnits-docs/)

如果需要更完整的上手指南、案例、设计说明和 OSC2026 评审入口，请优先查看在线文档站。

LunarUnits 是一个面向 [MoonBit](https://www.moonbitlang.com) 的运行时量纲检查物理量与单位系统。它通过显式建模量纲与单位换算，帮助工程计算、科学计算、教学和数据处理代码避免单位错误。

单位错误是科学与工程计算中常见的 bug 来源。LunarUnits 为每个数值附带单位，在运算时检查量纲一致性，并拒绝无意义的组合（例如把长度加到时间上），而不是悄悄产生错误的数字。MVP 阶段的检查发生在运行时，而不是通过编译期量纲类型系统完成。

## 特性

- `Quantity` —— 数值与单位的组合。
- 七个基本量纲，背后是一套最小化的规范化符号代数。
- SI 基本单位，以及一组按领域分组的常用单位（time、geometry、mass、mechanics、fluid、thermal、electromagnetism、angle、solid_angle、information、currency、count）。
- 加、减、乘、除和整数幂，单位自动组合。
- 同量纲换算，并在运行时拒绝量纲非法的运算。
- 单位与物理量的格式化输出，支持 ASCII（`m/s^2`）、SI/Unicode（`m/s²`）和
  LaTeX（`\mathrm{m}/\mathrm{s}^{2}`）三种记法。
- 不可变的符号目录（`notation/catalog`），以及按领域分包的预置目录
  （`notation/preset`），用于解析与扩展单位符号。
- 字符串解析器（`notation/parser`），解析单位与数量表达式
  （`m/s^2`、`9.8 m/s^2`），错误分类清晰且不 panic。
- 仿射标度（`affine/`），表示带 offset 的绝对点（如温度 °C、°F、K、°R），
  用类型区分「绝对点」与「差值」。
- 对数标度（`logarithmic/`），表示电平（dBm、dBW、dBV）与增益（dB、Np），
  功率类与根功率类严格区分。
- 内置单位领域的便捷物理量构造函数。
- 扩展维度与常用物理常数。
- 每个公共 API 都带有可运行的文档示例。

## 安装

```bash
moon add FrozenLemonTee/LunarUnits
```

在通过 `moon new` 创建的标准项目中，将以下包加入 `cmd/main/moon.pkg`（保留其中
现有的 `options("is-main": true)` 配置）：

```
import {
  "FrozenLemonTee/LunarUnits/core/quantity",
  "FrozenLemonTee/LunarUnits/units/si",
  "FrozenLemonTee/LunarUnits/notation/preset",
  "FrozenLemonTee/LunarUnits/notation/parser",
  "FrozenLemonTee/LunarUnits/quantities/qgeometry",
}
```

## 快速开始

将 `cmd/main/main.mbt` 替换为：

```moonbit
fn main {
  // 用便捷构造函数，或用数值和单位直接构造物理量。
  let distance = @qgeometry.meters(100.0)
  let time = @quantity.Quantity::new(10.0, @si.second)

  // 运算会自动组合单位。
  let speed = distance / time
  println(@quantity.format_quantity(speed))

  // checked API 适合在 main 中使用：非法换算返回 None。
  let in_meters = @qgeometry
    .kilometers(2.0)
    .checked_to(@si.meter)
    .unwrap()
  println(@quantity.format_quantity(in_meters))

  // 解析完整物理量，同时避免在 main 中引入未处理的错误效果。
  let catalog = @preset.all()
  let gravity = @parser
    .parse_quantity_opt(catalog, "9.8 m/s^2")
    .unwrap()
  println(@quantity.format_quantity(gravity))

  // 非法量纲加法会被拒绝，但不会终止程序。
  println(distance.checked_add(time) is None)
}
```

运行 `moon run cmd/main` 会输出：

```text
10 m/s
2000 m
9.8 m/s^2
true
```

严格版本的 `add`/`sub`/`to` 和 `parse_*` API 会在操作非法时抛出类型化错误；
请在能够处理或继续传播错误的函数中使用它们。在 `main` 等非抛错入口中，
应使用 `checked_*` 和 `*_opt`。

更多完整示例（速度、加速度、力、能量、换算以及非法运算拒绝）见
[`examples/`](examples/examples.mbt)，它们都在 `moon test` 下运行验证。

## 设计

LunarUnits 采用单向依赖的分层结构；上层依赖下层，反之绝不依赖。

1. **`core/algebra`** —— 最小化的规范化符号代数。由于单位与量纲只会做乘、除和整数幂，这套代数就是符号上的自由阿贝尔群：每个表达式都规范化为唯一的**单项式**（一个系数乘以若干 `symbol^exponent` 项的乘积）。这让比较、化简和规范排序都自动成立。
2. **`core/dimension`** —— 用单项式表达七个 SI 基本量纲（长度、质量、时间、电流、温度、物质的量、发光强度）。两个量纲相等当且仅当它们的指数向量相同，这是量纲检查的基础。
3. **`core/unit`** —— `Un`，单位符号单项式与一个量纲的组合。系数承载相对相干 SI 单位的缩放因子，因此复合单位（如 m/s）和换算都由代数自动推导得出。
4. **`core/quantity`** —— `Quantity`，数值加单位。加减法和换算会做量纲检查；乘除法组合单位。`Dimension`、`Un` 和 `Quantity` 支持 `*` 与 `/` 作为总是合法的代数组合语法糖；整数幂继续通过 `.pow(n)` 显式表达。

格式化与 `Show` 刻意分离：`Show` 保持面向调试和测试 diff，而 `format_unit`/`format_quantity`（及其 `*_with` 变体）用于用户可见的展示，支持 ASCII、SI/Unicode 与 LaTeX 三种记法。

符号解析放在独立的 `notation/` 层：`notation/catalog` 提供不可变的「符号 → 单位」查找表，且不参与核心单位身份判断；`notation/preset` 为每个单位包提供一份现成目录（外加 `all()` 取并集）。在二者之上，`notation/parser` 解析单位与数量字符串——原子符号来自 catalog，`*`、`/`、`^`、整数指数与括号由 parser 处理，失败时返回分类化的 `ParseError`（或 `*_opt` 变体的 `None`）而非 panic。

非线性标度同样不进乘法核心。`affine/` 包表示换算为 `value × scale + offset` 的绝对点（如温度），沿用 boost.units / Pint 的仿射空间范式：绝对点 `Point`（`20 °C`）与差值（kelvin 上的普通 `Quantity`）是**不同类型**——`点 − 点` 得差值、`点 + 差值` 得点，而无意义的 `点 + 点`、`点 × 标量` 根本不存在。`Un` 不带 offset；泛型 `AffineUn`/`Point` 可由用户扩展（温度只是随附的预置）。

`logarithmic/` 包按同样的「绝对 vs 相对」原则处理分贝与奈培，沿用 Unitful.jl：`Level` 是绝对量（带参考，`30 dBm` 知道自己是 1 W），`Gain` 是纯比（`3 dB`）。电平经 `to_linear`/`from_linear` 与线性量互转，增益平移电平，两电平之差是增益，两个相等的功率电平合成约 +3 dB（功率翻倍）而非 +6。功率类与根功率类标度（factor 10 vs 20）严格区分、绝不自动互转。

错误处理遵循刻意的分层：底层**查询**返回 `Option`（如 `Un::conversion_factor`），而上层**操作**用 raise（`Quantity::add`/`sub`/`to` 在量纲不匹配时 raise `DimensionMismatch`）。

单位集合按领域组织，用户只需导入所需部分。扩展包可以引入额外维度，而不要求面向 SI 的核心层或既有单位领域依赖这些维度。

## 包结构

```
core/
  algebra      规范化符号代数（Expr、Monomial）
  dimension    物理量纲（Dimension）
  unit         单位定义与换算（Un）
  quantity     带单位的数值（Quantity、DimensionMismatch）
dimensions/
  angle_dimension        平面角扩展维度
  solid_angle_dimension  立体角扩展维度
  information_dimension  信息量扩展维度
  currency_dimension     货币扩展维度
  count_dimension        离散计数扩展维度
units/
  si           SI 基本单位
  time         分、时、日、毫/微/纳秒（固定长度时长）
  angle        弧度、角度、整圈、角分、角秒、周（cycle）、赫兹（Hz）
  solid_angle  球面度、平方度、整球面
  geometry     长度、面积、体积
  mass         质量、密度
  mechanics    力、压力、速度、能量、功率
  fluid        动力/运动粘度、渗透率
  thermal      传热系数、热导率、比热、热功
  electromagnetism  电荷、电压、电阻、电容、电感、磁通
  information  bit、byte 以及常用十进制/二进制字节单位
  currency     美元、美分、k$、M$（仅限同一货币换算）
  count        个、打、罗
quantities/
  qtime        时长物理量构造函数（minutes、hours、days…）
  qangle       平面角物理量构造函数，含周（cycle）与赫兹（Hz，频率）
  qsolidangle  立体角物理量便捷构造函数
  qsi          SI 基本物理量便捷构造函数
  qgeometry    几何物理量便捷构造函数
  qmass        质量与密度物理量便捷构造函数
  qmechanics   力学物理量便捷构造函数
  qfluid       流体物理量便捷构造函数
  qthermal     热学物理量便捷构造函数
  qelectromagnetism  电学与磁学物理量便捷构造函数
  qinformation 信息量物理量便捷构造函数
  qcurrency    货币物理量便捷构造函数
  qcount       离散计数物理量便捷构造函数
constants/
  physics      以物理量表示的常用物理常数
notation/
  catalog      不可变的「符号 → 单位」查找表（Catalog）
  preset       预置目录，每个单位包一份，外加 all()
  parser       解析单位/数量字符串（parse_unit、parse_quantity）
affine/        仿射标度（AffineUn、Point），含温度单位
logarithmic/   对数标度（Level、Gain），含分贝/奈培单位
examples/      可运行、自校验的示例
docs/          设计与路线图文档
```

> 线性的 `units/thermal` 只保留 kelvin 及其线性派生单位。仿射温度点（°C、°F、°R）放在独立的 `affine/` 包，对数电平/增益放在 `logarithmic/`，使 `Un`/`Quantity` 保持纯乘法。

## 开发

- 测试与被验证的包放在一起（黑盒测试用 `_test.mbt`，白盒测试用 `_wbtest.mbt`）。公共 API 同时带可运行的文档示例。
- 运行 `moon test` 构建并验证一切（包含文档示例）。
- 在审阅 diff 前运行 `moon info && moon fmt`。

## 许可证

Apache-2.0，见 [LICENSE](LICENSE)。
