title: intel edison的使用以及入门
-----

### 关机
```
直接关电源 
PWR 8s
开机 sw1ui5 按

2、init 0 
3、telinit 0 
4、shutdown -h now 
5、halt
6、poweroff
7. reboot
```

### 设定开机自动重启,程序自动重启

```
#! /usr/bin/env node

```
新建  cat /lib/systemd/system/mystartupapp.service

```

[Unit]
 
Description=My startup app
 
After=network.target
 
[Service]
 
#User=root

ExecStart=/home/root/programs/myapp
 
Restart=always
 
RestartSec=10s
 
[Install]
 
WantedBy=multi-user.target
```

实际使用，复制一份xdk-deamon.service;
然后修改一下脚本名字即可

systemctl status [.service] //查看某个或者所有进程状态

systemctl daemon-reload
systemcrl start yourscript.service
systemctl enable mystartupapp

reboot
即可

#### 设定系统时间

date -s "2016-3-4 12:22:33"
或者用py 
import os 
os.system( 'date -s "2016-03-01 12:57:00"' )

#### 连接WiFi
configure_edison --wifi

Math.pow(n,m) n的m次方

var uu = 'string'.toString(2); //转为2进制
parsedIn(uu,2); //2进制转为十进制

parsedIn（num,n).toString(m) //n 进制转为m进制

0x前缀表示十六进制

### i2c协议的学习
[参考文章](http://www.robot-electronics.co.uk/i2c-tutorial)
[gekius](http://tec.gekius.com/page/2)

1. i2c 有数据线SDA,时钟线路SCL,GND,VCC
2. 时钟线发出信号，各个slavor随时响应，如果要求的是自己的物理地址，那么就响应并进行数据交换，其他的就忽略 
3. 任何时候只有一个slavor 跟master交换数据
4.  slavor的物理地址为8位，最低位决定对该slavor读取还是写，高7位决定它的物理地址，每个slavor的i2c地址是一定的，由厂商决定，当然也可以通过程序修改
5. I2C中有两个特殊的信号，分别是开始和结束信号，开始时SDA和SCL都处于高电平，当SDA由高电平变为低电平时，	SCL仍然处于低电平，接着SCL马上变为低电平,代表了传输的开始，当SDA为低电平，同时SCL为高电平，接着SDA也变回低电平时，代表了本次传输的结束。 也就是为了防止混乱，当在数据传输时，SCL处于高电平中，SDA一定要稳定，不能变动。不然以为是结束信号。

---
1. 数据线同一时刻只能由master到slaver 或者slaver 到master,
2. 时钟和数据线共同决定开始和结束，每次传输以8个位，9个时钟高电平为单位,
3. 由 master 传输信号开始，先发送地址，再发送寄存器(或者指令),最后是slaver发送它的数据等，反正最后才是交互，m可以write,s也可以send
4. i2c地址前4位是由公司决定，后三位，即A0到A3由用户自己定，也就是一条总线上的只能同时接同一厂商的8个芯片

### 流程
1. start bus
2. send adress
3. the slavor of this adress respond to the master
4. send the regiser of this slavor maser want to operation(write or read)
5. send more message
6. end

```
SHT20 传感器
adress : 1000 000 
readAdress : 1000 0001 // 129 0x81
writeAdress : 1000 0000  // 128  0x80
kdd
```

### 各个协议的简介
1. spi ,全双工传输协议，一条输入，一条输出，一条片选，一条时钟
2. pwm , 用数字信号模拟类似正余弦波;w


#### C语言中
```
8bit = 00001;
8bit <<     // 左移，一位， 第一位在CY
即8bit = 00000 ; CY = 0;
8bit >> // 右移一位， 最后位在CY ,即8bit = 00010 , CY = 1; 
```


```
#ifndef TRH_SENSOR_H_
#define TRH_SENSOR_H_
 
#define TRH_SENSOR_I2C_ADDR 0x5c
 
// sensor function code
#define TRH_SENSOR_FUN_CODE_READ_REG 0x03
#define TRH_SENSOR_FUN_CODE_WRITE_REG 0x10
 
// sensor register address
#define TRH_RH_REG_ADDR_H 0x00 // high byte of humidity register address
#define TRH_RH_REG_ADDR_L 0x01 // low byte of humidity register address
#define TRH_T_REG_ADDR_H 0x02 // high byte of temperature register address
#define TRH_T_REG_ADDR_L 0x03 // low byte of temperature register address
#define TRH_STATE_REG_ADDR 0x07 // status register address
 
/* skeleton class, ignor it now
class TRHSensor {
public:
TRHSensor();
virtual ~TRHSensor();
};
*/
 
#endif /* TRH_SENSOR_H_ */
```
#include "TRH_sensor.h"
#include "mraa.h"
#include 
#include 
#include 
 
#define I2C_BUS 0x06
 
/*
* The T/HR sensor will turn into sleeping mode automatically every time master finished
* fetching data from it.We must activate the sensor before beginning transfer data.
*
* @parameter: none
* @return: error state
* 0 for successful
*/
int ActivateSensor( const mraa_i2c_context i2c_context )
{
  if ( mraa_i2c_address( i2c_context, TRH_SENSOR_I2C_ADDR ) != MRAA_SUCCESS )
    printf("can not find sensor!\n");
 
  mraa_i2c_write_byte( i2c_context, 0 );
  return 0;
}
 
int main()
{
  mraa_init();
  mraa_i2c_context i2c_context = mraa_i2c_init(I2C_BUS);
    printf( "i2c bus initialization finished\n");
  uint8_t data_requirement_buffer[3];
  uint8_t sensor_data_buffer[9] = {0};
  int humitity_i = 0, temperature_i=0, guard;
 
  for(;;)
  {
    // shake the sensor up every time you want to access its data
    ActivateSensor( i2c_context );
 
    // require temperature and humidity data
    mraa_i2c_address( i2c_context, TRH_SENSOR_I2C_ADDR );
    data_requirement_buffer[0] = TRH_SENSOR_FUN_CODE_READ_REG;
    data_requirement_buffer[1] = TRH_RH_REG_ADDR_H;
    data_requirement_buffer[2] = 4;
    if ( mraa_i2c_write( i2c_context, data_requirement_buffer, 3 )==MRAA_SUCCESS)
      printf("requirement has been send\n");
 
    // ready to go, here we are going to fetching temperature
    // and humidity data(4 bytes) at a time
    mraa_i2c_address( i2c_context, TRH_SENSOR_I2C_ADDR );// sensor address with read mark
    if (mraa_i2c_read( i2c_context, sensor_data_buffer, 8 )==MRAA_SUCCESS)
      printf( "Requirement has been sent!");
 
    guard = humitity_i;//guard command to prevent compiler common out unused variable
    humitity_i = (((int)sensor_data_buffer[2])<<8) + sensor_data_buffer[3];
    temperature_i = (((int)sensor_data_buffer[4])<<8) + sensor_data_buffer[5];
      printf( "humitiy: %.1fRH temperature: %.1fC\n", ((double)humitity_i)/10, ((double)temperature_i)/10 );
    sleep(60);//wait for another sampling available
  }
 
  mraa_i2c_stop( i2c_context );
  return 0;
}



### 三态门，除了有逻辑的0和1外，还有一个高阻，相当于悬空

### 可编程增益，增益是指电压或者电流放大倍数，是通过电阻来控制，数字可编程增益是通过处理器输出数字的增益，然后选择哪路开关通段，达到控制接入多少电阻，从而实现控制增益
