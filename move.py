import compas_rrc as rrc

# Create Ros Client
ros = rrc.RosClient()
ros.run()

abb = rrc.AbbClient(ros, '/rob12')
abb.send(rrc.SetTool('T_A083_MyTool'))
# Move robot to a joints
frame, external_axes = abb.send_and_wait(rrc.GetRobtarget())
print(frame, external_axes)
frame.point.x += 100
# done = abb.send_and_wait(rrc.MoveToRobtarget(frame, external_axes, 150.0, rrc.Zone.FINE))

print(frame, external_axes)
# Close clientsni
ros.close()
ros.terminate()
