import compas_rrc as rrc
from A083_IOs import OpenGripper

# Create Ros Client
ros = rrc.RosClient()
ros.run()

# Create ABB Client
abb = rrc.AbbClient(ros, '/rob12')
print('Connected')


# Open gripper
OpenGripper(abb)

# End of Code
print('Finished')

# Close client
ros.close()
ros.terminate()
