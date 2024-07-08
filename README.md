## About The Project (TLDR)
This is a battery monitoring system application that consist of monitoring system using Arduino and monitoring app using Flutter frameworks. This is built based on the 4s2p LiFePo4 battery configuration using Coloumb counting algorith to determine the percentage. If you want to use this using your own battery configuration, you have to modify this [App](#reconfig-app) and [Arduino](#reconfig-arduino).

## Battery SoC Method Used
Coloumb counting is an algorithm to determine SoC by counting how many electric charge that flows through battery. The reason why the project use coloumb counting method is because this method doesnt require a `Voltage load reference curve` to operate. In the voltage estimation SoC method, we need to create a reference curve to know the exact percentage of a battery and because of the characteristic of a battery, it will have different curve in every load. By using coloumb counting algorithm, we don't need to do that, so it will be more flexible in term of load usage and reduce a lot of time in development compared to the voltage estimation SoC method. The formula can be represented with below equation.
<p align="center">
  <img src="https://www.batterydesign.net/wp-content/uploads/2022/05/coulomb-counting.jpg" alt="Example Image" />
</p>

* `SoC(t)`: Battery percentage.
* `SoC(t-1)`: Previous/last battery percentage.
* `I(t)`: Current through the battery.
* `Q(n)`: Electric charge or can be represented as battery capacity.
* `Δt`: Time interval between measurement.

## Hardware
The project is build using this set of hardware.
* Arduino Nano ATmega328p.
* Set of resistors that is used for voltage dividers.
* Bluetooth BLE HM-10.
* Current sensor INA226 (Modified shunt-resistor to 0.01 Ω).

Here is the schematic for the battery monitoring system:
![Alt text](https://github.com/medioka/battery-monitoring-app/raw/master/images/schematic.png)

## Software
The project's application is build using Flutter frameworks. The reason?, no special reason to be honest. The only explaination is, at the time this project was built, it needs to be finished fast. So based on my research, 
Flutter is the right choice for it. Here are some key features that the application have:
* Showcase battery parameters (voltages, current, cell voltages, capacity, percentage) and status (charging, idle, or discharging).
* Connect to device that supports Bluetooth 4.0 BLE.
* Recalibrate SOC to 100%.
* Change battery capacity in mAh.
* Auto pair in saved valid devices.

Here are the screenshots of the app:
<p float="left">
  <img align = "top" src="/images/home_screen.png" width="100" />
  <img align = "top" src="/images/settings_screen.png" width="100" /> 
</p>

## Reconfig Arduino
Here are some parameters and function that you need to change, if you use different battery configurations or want to modify things to run the code:
* `#define VOLT_MULTIPLIER`: The multiplier value comes from the ratio of voltage divider that you use, you can readjust based on the voltage divider formula.
* `#define VOLT_REFERENCE`: Change this to the voltage that your microcontroller use. Usually, most of the arduino device will run in 5V (using USB), but you can readjust based on your need.
* `batCapacity`: Battery capacity writte in Ah format.
* `INA.setMaxCurrentShunt(bat_max_volt, shunt_used)`: Change the maximum voltage that the sensor can handle and also the shunt resistor. Formula can be seen in the datasheet of INA226.
* Function `sendDataToApp()`: This function is used to send data that we get to the app. As per bluetooth works, the data will get send sequentially in the form of string with the `,` as its seperator . So you need to make sure the order matches the order that is set within the app.


## Reconfig App
In the app, you can go to `battery_mode.dart` file to set all of the parameters that you want to show within the screen and `data_utils.dart` to modify how it works. Here is the workflow of the app:
App listen for data -> Data coming -> convert string into set of valid values (Float, Int, etc) -> assigned valid values into the data model -> model created -> screen data changed

## Notes
Due to the limited that happened when this project was build, the app only created to serve the showcase monitoring functionality. Because of that, there may be some bugs and lack of features in this app that will be fixed in the future.
Here are some known bugs and lack of features:
* Bluetooth switch cannot be disconnected by flipping the switch (Must be manually turned off in the system).
* Auto pair mode sometimes not working.
* Battery cell voltages is still fixed size, so user can only modify it through code.
