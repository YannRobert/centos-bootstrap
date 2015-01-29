The script batching commands you should run right after provisionning a new CentOS Virtual Machine.


## Usage

Clone the repo, then run the script named "setup.sh".


Or, you can curl-pipe-sh it... (be sure to check the script first)


```shell
curl https://raw.githubusercontent.com/YannRobert/centos-bootstrap/master/setup.sh | sh

```

You can patch the setup script on-the-fly to change a few things if you need to, for instance to set the timezone
```shell
curl https://raw.githubusercontent.com/YannRobert/centos-bootstrap/master/setup.sh | sed 's/zoneinfo\/UTC/zoneinfo\/Europe\/Paris/g' | sh

```
