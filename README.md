# SIH-23_Tr0janspL0iT915

This is the repository for the [Smart India Hackathon 2023](https://sih.gov.in/sih2023PS?technology_bucket=QWxs&category=SGFyZHdhcmU=&organization=QWxs&organization_type=QWxs). 

FPGA target [ARTY A7 100T](https://digilent.com/reference/programmable-logic/arty-a7/start)

[docs](https://docs.google.com/document/d/1eeGHoOBTvu4BX1HitgTLWrCDlPpifWjuWwZvh6EhjTM/edit?usp=sharing)

<details>
<summary>
Overview
</summary>
Problem Statement ID : 1387
  
Problem Statement Title : Detection of embedded Malware/ Trojan in hardware devices used in Power Sector.

Description : 
We know that the technology is changing fast and so are the devices used in Power Systems network. The hardware devices used in the sector are also having fast processing capacity and are intelligent. They also communicate data either periodically or on request or if some logic is met or at programmed intervals, to control centers or to local / zonal SCADA system. 
The devices could be Intelligent Electronic Devices (IEDs) like:
* Relay {_Relays are the switches that aim at closing and opening the circuits electronically as well as electromechanically_.}
* BCU{_The bay control unit (BCU) is a fundamental component of an electric power substation that is required to perform various bay operations based on predefined control logic_}
* Smart Meters, or Remote Terminal Units (RTU){_Remote terminal units. An RTU is an electronic device utilizing a microprocessor, which links objects in the physical world with an automation system._}
  
As these are electronic devices, they are prone to security threats. To make sure these devices are free from security threats, it is required to test them for : 
* malware / Trojan in hardware systems (like System on Chip/ Microcontrollers / Microprocessors/ DSP /FPGA based products)
* malicious codes present in the devices/  which has inbuilt firmware and dedicated application programs running within available and constraint memory.
  
The challenge is to validate such electronic equipment for vulnerability assessment tests and for presence of suspicious or malicious codes present if any, in the devices.

Such codes could otherwise exploit specific attacks which may cause damage to process/ system or harm the environment and living beings on certain conditions or may trigger on logics including the zero day attack. (_you have just learnt about the attack and have zero days to fix it_)

Organization: Ministry of power 

Category: Hardware

Domain: Bucket Blockchain & Cybersecurity

</details>

<details>
<summary>
What is a Hardware Trojan?
</summary>
  
It has 2 parts  

- trigger circuit
- payload (the actual malicious task which the trojan performs)

[Hardware trojans](https://youtu.be/YVbvil6LjN0?si=wm3BwDjYHRwZ3ptY) are mostly passive and hence are difficult to detect.

A Generic example of a hardware trojan

![image](https://github.com/manavshah-28/CoE_Trojan_SIH23/assets/82638448/688fc001-1e91-457d-ba0e-b35d0221ecbc)
</details>

<details>
<summary>Types of Hardware Trojans </summary>


  
* malicious logic gates
* data leak trojans
* backdoors (which can be activated)
* input triggered trojans
* time bombs
* covert comms
* voltage/frequency manipulation
* PUF vulnerabilities
* Side channel attacks
* Fault injection trojans
</details>

## Implemented clean PLC logic (without Trojan)

The design implemented on the FPGA is expected to function as Programmable Logic Controller deployed in a Water Pump control System.
It has the following functionality:
* It drives pump1 - which drives the motor responsible for filling water into the tank.
* It drives pump2 - which drives the motor responsible for draining water from the tank.
* The PLC reads water levels from a water level sensor and all controls are decided based upon those readings.

### Expected Functionality of PLC:
* Controls the Low, Medium and High water level indicators.
* Displays the water level ni form of a number (0 to 100).
* Pump fills water initially when tank is empty.
* Low indication for level (0 - 20).
* Mid indication for level (50 - 90).
* High indication for level (>90).
  
### Top level design of clean design

![image](https://github.com/manavshah-28/SIH23_Tr0janspL0iT915/assets/82638448/91e9c77b-5c77-4e40-924e-ca05180fad3e)

Internal Logic for water_lvl_sim

![image](https://github.com/manavshah-28/SIH23_Tr0janspL0iT915/assets/82638448/67ddb409-f3e6-430a-91f8-8e02647ea2c4)

Internal Logic for PLC

![image](https://github.com/manavshah-28/SIH23_Tr0janspL0iT915/assets/82638448/2635b456-50ac-49f1-a2f3-d5a154fc4a88)

### Top level design of Trojan added design

![image](https://github.com/manavshah-28/SIH23_Tr0janspL0iT915/assets/82638448/dc488203-40c8-4810-9476-332ac249e6a4)

Internal logic of time based Trojan Trigger 

![image](https://github.com/manavshah-28/SIH23_Tr0janspL0iT915/assets/82638448/88586fd8-843f-40fe-afbe-294134bd79f1)

