git clone --recurse-submodules https://github.com/ArduPilot/ardupilot.git

cd airsim/ardupilot

docker build . -t ardupilot-dev --build-arg USER_UID=$(id -u) --build-arg USER_GID=$(id -g)

docker run --gpus all --rm -it --network host -v "$PWD:/ardupilot" -w /ardupilot  ardupilot-dev  bash

        git config --global --add safe.directory /ardupilot
        git submodule update --init --recursive
        ./waf configure --board sitl && ./waf copter
        ./build/sitl/bin/arducopter \
              --model airsim-copter --speedup 1 \
              --sim-address=127.0.0.1 \
              --sim-port-in 14550 \
              --sim-port-out 14540 \
              -I0 &

        mavproxy.py --master=tcp:127.0.0.1:5760
                param set FRAME_CLASS 1;param set FRAME_TYPE 1;param save;reboot


-------------------------------------------------

https://ardupilot.org/dev/docs/sitl-with-airsim.html#sitl-with-airsim-install
(Binaries - https://github.com/microsoft/AirSim/releases/download/v1.8.1/MSBuild2018.zip)

airsim/MSBuild2018/LinuxNoEditor
./MSBuild2018.sh
vim ~/Documents/AirSim/settings.json

{
    "Vehicles": {
     "Copter1": {
       "VehicleType": "ArduCopter",
       "UdpIp": "127.0.0.1",
       "UdpPort": 14550,
       "ControlPort": 14540
     }
  }
}
