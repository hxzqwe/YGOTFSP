# 项目说明
本项目是把卡片力量SP卡池的YGO服务端运行在docker容器中 

## 项目使用方式一
```
git clone https://github.com/hxzqwe/YGOTFSP.git
cd YGOTFSP
docker build -t YGOTFSP .
docker run -d --name YGOTFSP -p 7911:7911 YGOTFSP
```

## 项目使用方式二
拉取dockerhub镜像安装
```
docker run -d --name ygotfsp -p 7911:7911 hxzqwe/ygotfsp
```
