import compas_rrc as rrc

# Create Ros Client
ros = rrc.RosClient()
ros.run()

# robot 12 to move tool and external axes Y and Z
abb = rrc.AbbClient(ros, '/rob12')
abb.send(rrc.SetTool('T_A073_Trowel'))

# robot 11 to move external axes X
abb1 = rrc.AbbClient(ros, '/rob11')


# Move robot to a joints
frame, external_axes = abb.send_and_wait(rrc.GetRobtarget())

# Template home position
home_config, home_ext_axes = [0.0, -90.0, 90.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0]

# Add logic if external axes X is different from current external axes X
if external_axes[0] - home_ext_axes[0] > 0.1:
    # Move robot 1  external axes X
    joints, external_axes = abb1.send_and_wait(rrc.GetJoints())
    target_external_axes = [home_ext_axes[0], external_axes[1], external_axes[2]]
    done = abb1.send_and_wait(rrc.MoveToJoints(joints=joints, external_axes=target_external_axes, speed=50.0, zone=rrc.Zone.FINE))

# Move robot to home position
joints, external_axes = abb.send_and_wait(rrc.GetJoints())
done = abb.send_and_wait(rrc.MoveToJoints(joints=joints, external_axes=external_axes, speed=50.0, zone=rrc.Zone.FINE))

# Move robot to a list of frames (future from JSON)
frames = [frame]
for f in frames:
    # Can implement logic to update external axes here
    done = abb.send_and_wait(rrc.MoveToRobtarget(frame, external_axes, 150.0, rrc.Zone.FINE))


# Close clients
ros.close()
ros.terminate()
