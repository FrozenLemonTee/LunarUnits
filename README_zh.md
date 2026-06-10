# LunarUnits

[English](README.md) | **简体中文**

LunarUnits 是一个面向 [MoonBit](https://www.moonbitlang.com) 的运行时量纲检查物理量与单位系统。它通过显式建模量纲与单位换算，帮助工程计算、科学计算、教学和数据处理代码避免单位错误。

单位错误是科学与工程计算中常见的 bug 来源。LunarUnits 为每个数值附带单位，在运算时检查量纲一致性，并拒绝无意义的组合（例如把长度加到时间上），而不是悄悄产生错误的数字。MVP 阶段的检查发生在运行时，而不是通过编译期量纲类型系统完成。

## 特性

- `Quantity` —— 数值与单位的组合。
- 七个基本量纲，背后是一套最小化的规范化符号代数。
- SI 基本单位，以及一组按领域分组的常用单位（geometry、mass、mechanics、fluid、thermal、electromagnetism、angle、solid_angle、information、currency、count）。
- 加、减、乘、除和整数幂，单位自动组合。
- 同量纲换算，并在运行时拒绝量纲非法的运算。
- 单位与物理量的 ASCII 格式化输出，例如 `m/s^2` 和 `9.8 m/s^2`。
- 内置单位领域的便捷物理量构造函数。
- 扩展维度与常用物理常数。
- 每个公共 API 都带有可运行的文档示例。

## 安装

```bash
moon add FrozenLemonTee/LunarUnits
```

然后在你的 `moon.pkg` 里按需导入，例如：

```
import {
  "FrozenLemonTee/LunarUnits/core/quantity",
  "FrozenLemonTee/LunarUnits/units/si",
  "FrozenLemonTee/LunarUnits/constants/physics",
  "FrozenLemonTee/LunarUnits/quantities/qgeometry",
  "FrozenLemonTee/LunarUnits/quantities/qinformation",
  "FrozenLemonTee/LunarUnits/quantities/qmechanics",
}
```

## 快速开始

```moonbit
// 用便捷构造函数，或用数值和单位直接构造物理量。
let distance = @qgeometry.meters(100.0)
let time = @quantity.Quantity::new(10.0, @si.second)

// 运算会自动组合单位。
let speed = distance / time // 10 m/s
let speed_text = @quantity.format_quantity(speed) // "10 m/s"

// 牛顿第二定律：F = m * a。
let mass = @quantity.Quantity::new(2.0, @si.kilogram)
let acceleration = @quantity.Quantity::new(3.0, @si.meter / @si.second.pow(2))
let force = mass * acceleration // 6 N

// 同量纲换算保持物理量大小不变。
let in_meters = @qgeometry.kilometers(2.0).to(@si.meter)
// in_meters.value() == 2000.0

// 领域构造函数只是 Quantity::new(value, unit) 的简写。
let load = @qmechanics.newtons(6.0)

// 常数与扩展维度同样是普通物理量。
let light_second = @physics.speed_of_light * @quantity.Quantity::new(1.0, @si.second)
let memory = @qinformation.kibibytes(1.0)

// 量纲非法的运算会被拒绝：当量纲不匹配时，
// `add`/`sub`/`to` 会 raise `DimensionMismatch`。
let total = distance.add(time) // raise DimensionMismatch
```

更多完整示例（速度、加速度、力、能量、换算以及非法运算拒绝）见
[`examples/`](examples/examples.mbt)，它们都在 `moon test` 下运行验证。

## 设计

LunarUnits 采用单向依赖的分层结构；上层依赖下层，反之绝不依赖。

1. **`core/algebra`** —— 最小化的规范化符号代数。由于单位与量纲只会做乘、除和整数幂，这套代数就是符号上的自由阿贝尔群：每个表达式都规范化为唯一的**单项式**（一个系数乘以若干 `symbol^exponent` 项的乘积）。这让比较、化简和规范排序都自动成立。
2. **`core/dimension`** —— 用单项式表达七个 SI 基本量纲（长度、质量、时间、电流、温度、物质的量、发光强度）。两个量纲相等当且仅当它们的指数向量相同，这是量纲检查的基础。
3. **`core/unit`** —— `Un`，单位符号单项式与一个量纲的组合。系数承载相对相干 SI 单位的缩放因子，因此复合单位（如 m/s）和换算都由代数自动推导得出。
4. **`core/quantity`** —— `Quantity`，数值加单位。加减法和换算会做量纲检查；乘除法组合单位。`Dimension`、`Un` 和 `Quantity` 支持 `*` 与 `/` 作为总是合法的代数组合语法糖；整数幂继续通过 `.pow(n)` 显式表达。

格式化与 `Show` 刻意分离：`Show` 保持面向调试和测试 diff，而 `format_unit` 与 `format_quantity` 用于用户可见的紧凑 ASCII 展示。

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
  angle        弧度、角度、整圈、角分、角秒
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
  qangle       平面角物理量便捷构造函数
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
examples/      可运行、自校验的示例
docs/          设计与路线图文档
```

> 温度目前只提供 kelvin：仿射单位（°C、°F）需要 offset 支持，计划与更完整的温度语义一起加入。

## 开发

- 测试与被验证的包放在一起（黑盒测试用 `_test.mbt`，白盒测试用 `_wbtest.mbt`）。公共 API 同时带可运行的文档示例。
- 运行 `moon test` 构建并验证一切（包含文档示例）。
- 在审阅 diff 前运行 `moon info && moon fmt`。

## 许可证

Apache-2.0，见 [LICENSE](LICENSE)。
