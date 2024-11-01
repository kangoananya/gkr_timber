import compas_rrc as rrc

# Create Ros Client
ros = rrc.RosClient()
ros.run()

abb = rrc.AbbClient(ros, '/rob12')
abb.send(rrc.SetTool('T_A073_Trowel'))

# Move robot to a joints
frame, external_axes = abb.send_and_wait(rrc.GetRobtarget())

# Move robot to home position
joints, external_axes = abb.send_and_wait(rrc.GetJoints())
done = abb.send_and_wait(rrc.MoveToJoints(joints=joints, external_axes=external_axes, speed=150.0, zone=rrc.Zone.FINE))

# Move robot to a list of frames (future from JSON)
frames = [frame]
for f in frames:
    # Can implement logic to update external axes here
    done = abb.send_and_wait(rrc.MoveToRobtarget(frame, external_axes, 150.0, rrc.Zone.FINE))


# Close clients
ros.close()
ros.terminate()
