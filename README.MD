The script batching commands you should run right after provisionning a new CentOS Virtual Machine.


## Usage

Clone the repo (you need to have ```git``` already), then run the script named ```setup.sh```.
```shell
yum install git
git clone https://github.com/YannRobert/centos-bootstrap.git
cd centos-bootstrap
./setup.sh
```


Or, you can curl-pipe-sh it... (be sure to check the script first)

```shell
curl https://raw.githubusercontent.com/YannRobert/centos-bootstrap/master/bootstrap.sh | sudo sh
```
