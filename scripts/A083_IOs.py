import compas_rrc as rrc
from compas.geometry import Frame
from compas.geometry import Vector
from compas.geometry import Point
import time

# set wait time value for gripper
wait_gripper = 1.5  # Unit [s]

# set IO values
low = 0
high = 1


def TimeStamp(rob, msg):
    t = time.strftime("%H:%M:%S - ", time.localtime())
    txt = t + msg
    rob.send(rrc.PrintText(txt))
    print(txt)


def CloseGripper(rob):
    # Print text on FlexPendant
    TimeStamp(rob, "Closing Gripper")
    # Set digital output / open
    rob.send_and_wait(rrc.SetDigital("doUnitR12ValveA1", high))
    rob.send_and_wait(rrc.SetDigital("doUnitR12ValveB1", low))
    # Wait for gripper to be closed
    rob.send_and_wait(rrc.WaitTime(wait_gripper))


def OpenGripper(rob):
    # Print text on FlexPendant
    TimeStamp(rob, "Opening Gripper")
    # Set digital output / open
    rob.send_and_wait(rrc.SetDigital("doUnitR12ValveA1", low))
    rob.send_and_wait(rrc.SetDigital("doUnitR12ValveB1", high))
    # Wait for gripper to be closed
    rob.send_and_wait(rrc.WaitTime(wait_gripper))
