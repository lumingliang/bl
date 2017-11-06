// 有多个类，主类car依赖Tires等类，常用的方法是，在主类头部引入依赖类，并在构造函数内，实例化一个该依赖类的实例，但是这样不好，当依赖类改变时，需要修改主类的代码，而且在这里实例化的实例也不能被其他类引用
export class Car {
  public engine: Engine;
  public tires: Tires;
  public description = 'No DI';
  constructor() {
    this.engine = new Engine();
    this.tires = new Tires();
  }
  // Method using the engine and tires
  drive() {
    return `${this.description} car with ` +
      `${this.engine.cylinders} cylinders and ${this.tires.make} tires.`
  }
}

// 一个方法是，我只在主类的构造函数内声明所以赖的类，并不实例化
// 如下，向主类传递实例，这样主类只顾用
constructor(public engine: Engine, public tires: Tires) { }

// 但是这样仍然需要手动为每个实例创建,于是，让每个类有一个对应的provider用来写创建它实例的方法，为了方便各个类的创建管理，又有了容器，主类只需要声明所需依赖，容器会自动调用依赖类的provider创建方法，并把实例保存在容器内，主类可以从容器中拿出依赖直接使用
// 注意，一定要有一个provider方法，不然从容器中取出依赖时，容器不知道怎样创建这个实例，当然在ng2中，一般类不需要写provider方法，因为大多是new service就可以得到了，默认支持

但需要声明所用provider是什么，(一般在组件声明provider)然后所有子组件都可以用,当然一般情况下（子组件使用的是同一个实例）
//在父组件中
providers:[HeroService],
