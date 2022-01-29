// --- 三个重要概念

// Dynamic Animator：动画者
// 负责做仿真动画的对象
// (在哪个范围做)

// Dynamic Animator Item：动力学元素
// 做仿真行为的对象
// (谁要做仿真行为)

// UIDynamicBehavior：仿真行为
// 做仿真行为的对象怎样去做行为
// (做什么样的仿真行为)

// --- 仿真行为的步骤

// 1.通过某个view的范围 创建一个动画者
// 2.创建一个仿真行为 并传入某个动力学元素(比如:需要做仿真行为的view)
// 3.为动画者 添加 仿真行为

// --- 重力(UIGravityBehavior)

// 初始化方法Items: 希望有重力行为的动力学元素(某个view)

// 方向
// gravityDirection 向量的形式
// angle 角度的形式

// 量级 重力
// magnitude 默认为1 相当于越大越快

// --- 碰撞(UICollisionBehavior)

// 初始化方法Items: 希望有碰撞行为的动力学元素(某个view)

// 设置仿真动画范围为边界
// collision.translatesReferenceBoundsIntoBoundary = YES;

// 碰撞模式
// collision.collisionMode =  UICollisionBehaviorModeEverything;

// 碰撞模式枚举
// UICollisionBehaviorModeItems 仅元素
// UICollisionBehaviorModeBoundaries 仅边界
// UICollisionBehaviorModeEverything 边界+元素 // *默认

// 使用path作为边界
// - (void)addBoundaryWithIdentifier:(id <NSCopying>)identifier forPath:(UIBezierPath *)bezierPath;

// 使用线作为边界
// - (void)addBoundaryWithIdentifier:(id <NSCopying>)identifier fromPoint:(CGPoint)p1 toPoint:(CGPoint)p2;

// 开始对某个item碰撞
// - (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p;

// 解释对某个item碰撞
// - (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2;

// 开始对某个边界碰撞
// - (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(nullable id<NSCopying>)identifier atPoint:(CGPoint)p;

// 结束对某个边界碰撞
// - (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(nullable id<NSCopying>)identifier;

// --- 甩(UISnapBehavior)
// snapPoint 甩到的位置
// damping 减速程度

// --- 附着(UIAttachmentBehavior)
// length 距离
// frequency 频率
// damping 振幅

// --- 推(UIPushBehavior)

// 一定要设置属性

// 推力模式
// UIPushBehaviorModeContinuous 持续推力
// UIPushBehaviorModeInstantaneous 瞬时推力

// 方向
// pushDirection 向量的形式
// angle 角度的形式

// 量级 力量
// magnitude 默认为1 相当于越大越快

// --- 动力学元素自身(UIDynamicItemBehavior)
// elasticity 弹性
// density 密度
// friction 摩擦力
